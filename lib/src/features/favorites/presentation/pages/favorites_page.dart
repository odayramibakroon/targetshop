import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/config/config.dart';
import '../../../home/cubit/products_cubit.dart';
import '../../../home/data/models/products_model.dart';
import '../../../home/presentation/widgets/FavoriteButtonAnimated.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    Stream<List<ProductsModel>> getFavoriteProducts() {
      final firestore = FirebaseFirestore.instance;

      return firestore
          .collectionGroup('products')
          .where('like', isEqualTo: true)
          .snapshots()
          .map((snapshot) {
        return snapshot.docs.map((doc) {
          return ProductsModel.fromFirestore(doc.data(), doc.id);
        }).toList();
      });
    }

    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text('Favorites')),
          leading: IconButton(
            icon: Icon(Icons.shopping_basket),
            onPressed: () {
              // Navigator.pushNamed(context, RoutesName.favorites);
            },
          ),
        ),
        body: BlocProvider(
            create: (context) => ProductsCubit(getProductsByCategory: getIt()),
            child: StreamBuilder<List<ProductsModel>>(
                stream: getFavoriteProducts(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text("حدث خطأ: ${snapshot.error}"));
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final products = snapshot.data!;

                  return ListView.builder(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Container(
                          key: Key(product.id),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: CachedNetworkImage(
                                          imageUrl: product.image,
                                          width: 90,
                                          height: 90,
                                          placeholder: (context, url) =>
                                              const CircularProgressIndicator(
                                                  strokeWidth: 2),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error,
                                                  color: Colors.red),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  product.name,
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                FavoriteButtonAnimated(
                                                  size: 25,
                                                  isLiked: product.like,
                                                  categoryId:
                                                      product.categoryId,
                                                  productId: product.id,
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              product.details,
                                              style:
                                                  const TextStyle(fontSize: 12),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            const SizedBox(height: 10),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
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
                                                        context
                                                            .read<
                                                                ProductsCubit>()
                                                            .minProduct(
                                                              productId:
                                                                  product.id,
                                                              currentQuantity:
                                                                  product
                                                                      .quantity,
                                                              categoryId: product
                                                                  .categoryId,
                                                            );
                                                      },
                                                      child: const Icon(
                                                        Icons
                                                            .remove_circle_outline,
                                                        size: 20,
                                                      ),
                                                    ),
                                                    Text(
                                                      "${product.quantity}",
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        context
                                                            .read<
                                                                ProductsCubit>()
                                                            .addProduct(
                                                              productId:
                                                                  product.id,
                                                              currentQuantity:
                                                                  product
                                                                      .quantity,
                                                              categoryId: product
                                                                  .categoryId,
                                                            );
                                                      },
                                                      child: const Icon(
                                                        Icons
                                                            .add_circle_outline,
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
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                })));
  }
}
