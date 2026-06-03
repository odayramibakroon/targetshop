import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  String _filter = 'all';

  Stream<QuerySnapshot<Map<String, dynamic>>> _ordersStream() {
    return FirebaseFirestore.instance
        .collection('orders')
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  Future<String> _currentRole() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return '';

    final doc =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    return (doc.data()?['role'] ?? '').toString().toLowerCase();
  }

  bool _canMarkReady(String role) =>
      role == 'chef' ||
      role == 'cook' ||
      role == 'admin' ||
      role == '\u0637\u0628\u0627\u062e' ||
      role == '\u0627\u062f\u0645\u0646';

  bool _canMarkPaid(String role) =>
      role == 'cashier' ||
      role == 'admin' ||
      role == '\u0643\u0627\u0634\u064a\u0631' ||
      role == '\u0627\u062f\u0645\u0646';

  Future<void> _markReady(String orderId) {
    return FirebaseFirestore.instance.collection('orders').doc(orderId).update({
      'status': 'ready',
      'readyAt': FieldValue.serverTimestamp(),
      'readyBy': FirebaseAuth.instance.currentUser?.uid,
    });
  }

  Future<void> _markPaid(String orderId) {
    return FirebaseFirestore.instance.collection('orders').doc(orderId).update({
      'paid': true,
      'paidAt': FieldValue.serverTimestamp(),
      'paidBy': FirebaseAuth.instance.currentUser?.uid,
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _currentRole(),
      builder: (context, roleSnapshot) {
        final role = roleSnapshot.data ?? '';

        return Scaffold(
          appBar: AppBar(title: const Text('Orders')),
          body: Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.all(12),
                child: SegmentedButton<String>(
                  segments: const [
                    ButtonSegment(value: 'all', label: Text('All')),
                    ButtonSegment(value: 'preparing', label: Text('Preparing')),
                    ButtonSegment(value: 'ready', label: Text('Ready')),
                    ButtonSegment(value: 'paid', label: Text('Paid')),
                  ],
                  selected: {_filter},
                  onSelectionChanged: (value) {
                    setState(() => _filter = value.first);
                  },
                ),
              ),
              Expanded(
                child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: _ordersStream(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }

                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    final docs = snapshot.data!.docs.where((doc) {
                      final data = doc.data();
                      if (_filter == 'all') return true;
                      if (_filter == 'paid') return data['paid'] == true;
                      return data['paid'] != true && data['status'] == _filter;
                    }).toList();

                    if (docs.isEmpty) {
                      return const Center(child: Text('No invoices found'));
                    }

                    return ListView.separated(
                      padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                      itemCount: docs.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 8),
                      itemBuilder: (context, index) {
                        final doc = docs[index];
                        return _OrderCard(
                          orderId: doc.id,
                          data: doc.data(),
                          canMarkReady: _canMarkReady(role),
                          canMarkPaid: _canMarkPaid(role),
                          onMarkReady: () => _markReady(doc.id),
                          onMarkPaid: () => _markPaid(doc.id),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _OrderCard extends StatelessWidget {
  final String orderId;
  final Map<String, dynamic> data;
  final bool canMarkReady;
  final bool canMarkPaid;
  final Future<void> Function() onMarkReady;
  final Future<void> Function() onMarkPaid;

  const _OrderCard({
    required this.orderId,
    required this.data,
    required this.canMarkReady,
    required this.canMarkPaid,
    required this.onMarkReady,
    required this.onMarkPaid,
  });

  @override
  Widget build(BuildContext context) {
    final status = (data['status'] ?? 'preparing').toString();
    final paid = data['paid'] == true;
    final type = (data['orderType'] ?? 'table').toString();
    final tableNumber = (data['tableNumber'] ?? '').toString();
    final total = (data['totalPrice'] as num?)?.toDouble() ?? 0;
    final createdAt = data['createdAt'];
    final shortId = orderId.substring(0, orderId.length > 6 ? 6 : orderId.length);

    return Card(
      child: ListTile(
        onTap: () => _showDetails(context),
        title: Text('Invoice #$shortId'),
        subtitle: Text(
          '${type == 'takeaway' ? 'Take away' : 'Table $tableNumber'} - ${_formatTime(createdAt)}',
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Chip(label: Text(paid ? 'Paid' : status)),
            if (!paid && status == 'preparing' && canMarkReady)
              IconButton(
                tooltip: 'Ready',
                onPressed: onMarkReady,
                icon: const Icon(Icons.restaurant_menu),
              ),
            if (!paid && status == 'ready' && canMarkPaid)
              IconButton(
                tooltip: 'Mark paid',
                onPressed: onMarkPaid,
                icon: const Icon(Icons.payments),
              ),
          ],
        ),
        leading: CircleAvatar(child: Text(total.toStringAsFixed(0))),
      ),
    );
  }

  void _showDetails(BuildContext context) {
    final rawItems = data['items'] as List<dynamic>? ?? [];
    final items = rawItems
        .whereType<Map>()
        .map((item) => item.map((key, value) => MapEntry(key.toString(), value)))
        .toList();
    final type = (data['orderType'] ?? 'table').toString();
    final tableNumber = (data['tableNumber'] ?? '').toString();
    final total = (data['totalPrice'] as num?)?.toDouble() ?? 0;

    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (context) {
        return SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(
                type == 'takeaway' ? 'Take away' : 'Table $tableNumber',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 4),
              Text('Order time: ${_formatTime(data['createdAt'])}'),
              const Divider(height: 24),
              for (final item in items)
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text((item['name'] ?? '').toString()),
                  subtitle: Text('Qty: ${item['quantity']}'),
                  trailing: Text(
                    '${((item['price'] as num?)?.toDouble() ?? 0).toStringAsFixed(2)} EGP',
                  ),
                ),
              const Divider(height: 24),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'Total: ${total.toStringAsFixed(2)} EGP',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  String _formatTime(dynamic value) {
    if (value is! Timestamp) return '-';
    final date = value.toDate();
    final hour = date.hour.toString().padLeft(2, '0');
    final minute = date.minute.toString().padLeft(2, '0');
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')} $hour:$minute';
  }
}
