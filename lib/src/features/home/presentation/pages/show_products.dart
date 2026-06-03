import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:targetshop/src/features/home/presentation/widgets/shimmeruser.dart';
import 'package:targetshop/src/features/users/cubit/user_cubit.dart';

import '../../../../core/config/config.dart';
import '../../cubit/products_cubit.dart';
import 'list_products.dart';

class ShowProducts extends StatelessWidget {
  final String categoryId;

  const ShowProducts({super.key, required this.categoryId});

  @override
  Widget build(BuildContext context) {
    Future<void> addProduct() async {
      await FirebaseFirestore.instance
          .collection('categories')
          .doc(categoryId)
          .collection('products')
          .add({
        'categoryId': categoryId,
        'name': "name",
        'details': "details",
        'image':
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTwg_pYaa-MB5-Bpa7opP0bl1zMDNLnqn7b5g&s",
        'price': 30,
        'quantity': 0,
        'like': true,

        // الكمية الافتراضية
      });
    }

    return Scaffold(
      appBar: AppBar(title: Text("Products")),
      floatingActionButton: FloatingActionButton(
        onPressed: addProduct,
        child: const Icon(Icons.add),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: BlocBuilder<UserCubit, UserState>(
                builder: (context, state) {
                  if (state is UserLoading) {
                    return const SkeletonListuser();
                  }

                  if (state is UserLoaded) {
                    final user = state.user;

                    return Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(user.image),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          '${user.firstname} ${user.lastname}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (user.isVerified) // تظهر فقط لو true
                          Icon(Icons.verified,
                              size: 16,
                              color: const Color.fromARGB(255, 74, 130, 255)),

                        // Icon(Icons.verified, size: 24, color: const Color.fromARGB(255, 74, 130, 255)),
                      ],
                    );
                  }

                   return const SizedBox.shrink();
                },
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
            ),
          ),
           
              BlocProvider(
              create: (context) =>
                  ProductsCubit(getProductsByCategory: getIt()),
              child: ListProducts(categoryId: categoryId),
            ),
           
        ],
      ),
    );
  }
}
