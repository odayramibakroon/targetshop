import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:targetshop/src/cubits/productquantitycubit/productquantity_cubit.dart';

import '../../cubit/products_cubit.dart';
import '../../data/models/products_model.dart';
 import '../widgets/FavoriteButtonAnimated.dart';
/// كلاس المنتج
//Riverpod ادارة الحاله

class ListProducts extends StatelessWidget {
  final String categoryId;
  const ListProducts({super.key, required this.categoryId});
 
  @override
  Widget build(BuildContext context) {
  Stream<List<ProductsModel>> getProducts({required String categoryId}) {
  final uid = FirebaseAuth.instance.currentUser!.uid;
  final firestore = FirebaseFirestore.instance;

  return firestore
      .collection('categories')
      .doc(categoryId)
      .collection('products')
      .snapshots()
      .asyncMap((productsSnapshot) async {
    // جلب المفضلة للمستخدم
    final favSnapshot = await firestore
        .collection('users')
        .doc(uid)
        .collection('favorites')
        .get();

    final favoriteIds = favSnapshot.docs.map((doc) => doc['productId'] as String).toSet();

    // إنشاء قائمة المنتجات مع تحديث حالة اللايك
    return productsSnapshot.docs.map((doc) {
      final data = doc.data();
      return ProductsModel(
        id: doc.id,
        name: data['name'] ?? '',
        details: data['details'] ?? '',
        price: (data['price'] ?? 0).toDouble(),
        image: data['image'] ?? '',
        quantity: (data['quantity'] ?? 0).toDouble(),
        categoryId: categoryId,
        like: favoriteIds.contains(doc.id), // هنا تحدد حالة اللايك
      );
    }).toList();
  });
}
    return StreamBuilder<List<ProductsModel>>(
      stream: context.read<ProductsCubit>().getProductsByCategory(categoryId: categoryId), 
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

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                   Text(
              product.name,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
                FavoriteButtonAnimated(size: 25, isLiked: product.like,
                 categoryId: categoryId,
                  productId: product.id,
                ),
              ],
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
                
             Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${product.price.toStringAsFixed(2)} EGP",
                  style: const TextStyle(
                     fontWeight: FontWeight.bold,
                  ),
                ),
         BlocProvider(
  create: (_) => ProductQuantityCubit(
    productId: product.id,
    categoryId: categoryId,
    initialQuantity: product.quantity, image: product.image, price: product.price, name: product.name,
  ),
  child: BlocBuilder<ProductQuantityCubit, double>(
    builder: (context, quantity) {
      return Row(
        children: [
          GestureDetector(
            onTap: () => context.read<ProductQuantityCubit>().decrement(),
            child: Icon(quantity == 0 ? Icons.delete : Icons.remove_circle_outline, size: 20),
          ),
          const SizedBox(width: 6),
          Text("$quantity", style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(width: 6),
          GestureDetector(
            onTap: () => context.read<ProductQuantityCubit>().increment(),
            child: const Icon(Icons.add_circle_outline, size: 20),
          ),
        ],
      );
    },
  ),
)

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