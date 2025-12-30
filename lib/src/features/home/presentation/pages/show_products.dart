import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        'categoryId':categoryId,
    'name': "name",
    'details': "details",
    'image': "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTwg_pYaa-MB5-Bpa7opP0bl1zMDNLnqn7b5g&s",
    'price': 30,
    'quantity': 0, 
    'like': true, 
    
    // الكمية الافتراضية
  });
    }
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: addProduct,
        child: const Icon(Icons.add),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assets/images/imgprofile.png'),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    "Saja Bakroon",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
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
                      create: (context) => ProductsCubit(  getProductsByCategory: getIt()),
                    child:       ListProducts(categoryId: categoryId)
,
          )
         ],
      ),
    );
  }
}