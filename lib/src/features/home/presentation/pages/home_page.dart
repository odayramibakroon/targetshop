 import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'list_categores.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
      Future<void> addProduct() async {
    await FirebaseFirestore.instance.collection('products').add({
      'name': 'فراخ',
      'details': 'اي حاجه',
      'price': 32,
      'image':
          'https://i.ytimg.com/vi/uKdToU5pO8s/hq720.jpg?sqp=-oaymwEhCK4FEIIDSFryq4qpAxMIARUAAAAAGAElAADIQj0AgKJD&rs=AOn4CLB9WtK9ewptr8jCyqNTNNbsQjLeKA',
    
      'quantity': 100,});
  }
      List<Map<String, dynamic>> sampleProducts = [
            {"name": "Product 1", "details": "Details 1", "price": 10, "image": "assets/images/item1.png"},
            {"name": "Product 2", "details": "Details 2", "price": 20, "image": "assets/images/item.png"},
            {"name": "Product 3", "details": "Details 3", "price": 30, "image": "assets/images/item3.png"},
          //  {"name": "Product 4", "details": "Details 4", "price": 40, "image": "assets/images/item4.png"},
           // {"name": "Product 5", "details": "Details 5", "price": 50, "image": "assets/images/item5.png"},
            //{"name": "Product 6", "details": "Details 6", "price": 60, "image": "assets/images/item.png"},
          ];
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
                    style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),

          // حقل البحث
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

          // عرض المنتجات من Firebase
          const ListCategores(),
        ],
      ),
    );
  }
}