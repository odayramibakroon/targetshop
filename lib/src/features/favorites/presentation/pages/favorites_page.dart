import 'package:cached_network_image/cached_network_image.dart';
 
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:targetshop/generated/l10n.dart';
 import 'package:targetshop/src/cubits/productquantitycubit/productquantity_cubit.dart';
import 'package:targetshop/src/features/favorites/cubit/favorite_products_cubit.dart';
import 'package:targetshop/src/features/favorites/data/models/favorite_product_model.dart';
 
import '../../../../core/config/config.dart';
 
import '../../../home/presentation/widgets/FavoriteButtonAnimated.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {

 








    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text( S.of(context).favorites)),
          leading: IconButton(
            icon: Icon(Icons.shopping_basket),
            onPressed: () {
              // Navigator.pushNamed(context, RoutesName.favorites);
            },
          ),
        ),
        body: BlocProvider(
            create: (context) => FavoriteProductsCubit( getIt()),
            child: Builder(
              builder: (context) {
                return StreamBuilder<List<FavoriteProductModel>>(
                    stream:  context.read<FavoriteProductsCubit>().getFavoriteProductsUseCase(),
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
                                        BlocProvider(
                  create: (_) => ProductQuantityCubit(
                    productId: product.id,
                    categoryId: product.categoryId,
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
                                          ] ),  
                                      )  ], 
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    });
              }
            )));
  }
}
