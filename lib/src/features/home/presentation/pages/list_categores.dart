import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';

/// كلاس المنتج
class Product {
  final String id;
  final String name;
  final String details;
  final double price;
  final String image;
  final double quantity  ;

  Product({
    required this.id,
    required this.name,
    required this.details,
    required this.price,
    required this.image,
    this.quantity = 0,
 
   });

  factory Product.fromFirestore(Map<String, dynamic> data, String id) {
    return Product(
      id: id,
      name: data['name'] ?? '',
      details: data['details'] ?? '',
      price: (data['price'] ?? 0).toDouble(),
      image: data['image'] ?? '',
      quantity: (data['quantity'] ?? 0).toDouble(),     
    );
  }
}

 class ListCategores extends StatelessWidget {
  const ListCategores({super.key});

  Stream<List<Product>> getProductsStream() {
    return FirebaseFirestore.instance
        .collection('products')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Product.fromFirestore(doc.data(), doc.id))
            .toList());
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Product>>(
      stream: getProductsStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SliverToBoxAdapter(
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const SliverToBoxAdapter(
            child: Center(
                child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Text("No products available"),
            )),
          );
        }

        final products = snapshot.data!;

        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final product = products[index];
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Container(
                  decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,

                     borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  /**ListTile(
                    leading: CachedNetworkImage(
                      imageUrl: product.image,
                      width: 50,
                      height: 50,
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(strokeWidth: 2),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error, color: Colors.red),
                      fit: BoxFit.cover,
                    ),
                    title: Text(product.name),
                    subtitle: Text(product.details),
                    trailing: Text("\$${product.price.toStringAsFixed(2)}"),
                  ), */
                  child: Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
  Padding(
  padding: const EdgeInsets.all(10),
  child: Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
       ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: CachedNetworkImage(
                      imageUrl: product.image,
                       width: 90,
          height: 90,
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(strokeWidth: 2),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error, color: Colors.red),
                      fit: BoxFit.cover,
                    ),
      ),

      const SizedBox(width: 12),

      // 📝 المحتوى (على اليمين)
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              product.name,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              product.details,
              style: const TextStyle(
                fontSize: 12,
               ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 10),

            // السعر + الكمية
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${product.price.toStringAsFixed(2)} EGP",
                  style: const TextStyle(
                     fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                       
                      },
                      child: const Icon(
                        Icons.remove_circle_outline,
                        size: 20,
                      ),
                    ),
                          Text(
                  "${product.quantity.toStringAsFixed(2)}",
                  style: const TextStyle(
                     fontWeight: FontWeight.bold,
                  ),
                ),
                    GestureDetector(
                      onTap: () {
                        
                      },
                      child: const Icon(
                        Icons.add_circle_outline,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    ],
  ),
) 

        ],
      ),
    ),
                ),
              );
            },
            childCount: products.length,
          ),
        );
      },
    );
  }
}
