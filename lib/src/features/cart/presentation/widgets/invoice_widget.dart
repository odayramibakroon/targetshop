import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:targetshop/src/features/home/data/models/products_model.dart';

class InvoiceWidget extends StatelessWidget {
  final BuildContext context;
  final double totalPrice;
  final List<ProductsModel> products;

  const InvoiceWidget({
    super.key,
    required this.totalPrice,
    required this.context,
    required this.products,
  });

  Future<void> _checkout(BuildContext context) async {
    if (products.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cart is empty')),
      );
      return;
    }

    final details = await _showOrderDetailsDialog(context);
    if (details == null) return;

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final firestore = FirebaseFirestore.instance;
    final orderRef = firestore.collection('orders').doc();
    final cartRef = firestore.collection('users').doc(user.uid).collection('products');
    final batch = firestore.batch();

    batch.set(orderRef, {
      'id': orderRef.id,
      'status': 'preparing',
      'paid': false,
      'orderType': details.orderType,
      'tableNumber': details.tableNumber,
      'createdAt': FieldValue.serverTimestamp(),
      'createdBy': user.uid,
      'totalPrice': totalPrice,
      'items': products
          .map((product) => {
                'id': product.id,
                'name': product.name,
                'details': product.details,
                'image': product.image,
                'categoryId': product.categoryId,
                'price': product.price,
                'quantity': product.quantity,
              })
          .toList(),
    });

    for (final product in products) {
      batch.delete(cartRef.doc(product.id));
    }

    await batch.commit();

    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Order sent to kitchen')),
    );
  }

  Future<_OrderDetails?> _showOrderDetailsDialog(BuildContext context) {
    var orderType = 'table';
    final tableController = TextEditingController();

    return showDialog<_OrderDetails>(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Order details'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropdownButtonFormField<String>(
                    value: orderType,
                    decoration: const InputDecoration(labelText: 'Type'),
                    items: const [
                      DropdownMenuItem(value: 'table', child: Text('Table')),
                      DropdownMenuItem(value: 'takeaway', child: Text('Take away')),
                    ],
                    onChanged: (value) {
                      if (value != null) setState(() => orderType = value);
                    },
                  ),
                  if (orderType == 'table') ...[
                    const SizedBox(height: 12),
                    TextField(
                      controller: tableController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: 'Table number'),
                    ),
                  ],
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(dialogContext),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    final tableNumber = tableController.text.trim();
                    if (orderType == 'table' && tableNumber.isEmpty) return;
                    Navigator.pop(
                      dialogContext,
                      _OrderDetails(orderType: orderType, tableNumber: tableNumber),
                    );
                  },
                  child: const Text('Checkout'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  '${totalPrice.toStringAsFixed(2)} EGP',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _checkout(context),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('Checkout', style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OrderDetails {
  final String orderType;
  final String tableNumber;

  const _OrderDetails({
    required this.orderType,
    required this.tableNumber,
  });
}
