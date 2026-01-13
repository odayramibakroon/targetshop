 import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:targetshop/src/core/config/config.dart';
 import 'package:targetshop/src/features/cart/cubit/cart_cubit.dart';
import 'package:targetshop/src/features/cart/presentation/widgets/invoice_widget.dart';
import 'package:targetshop/src/features/cart/presentation/widgets/list_view_car.dart';
 import 'package:targetshop/src/features/home/data/models/products_model.dart';

import '../../../../core/routes/names.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});
Stream<List<ProductsModel>> streamUserProducts() {
  final uid = FirebaseAuth.instance.currentUser!.uid;

  return FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .collection('products')
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) {
            final data = doc.data();
            return ProductsModel.fromFirestore(data, doc.id);
          }).toList());
}


   double calculateTotalPrice(List<ProductsModel> products) {
    double total = 0.0;
    for (var product in products) {
      total += product.price * product.quantity;
    }
    return total; 
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(      appBar: AppBar(
        title: Center(child: Text("Cart Page"),),
        actions: [
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut().then((_) {
                  
                  Navigator.pushNamedAndRemoveUntil(
                      context, RoutesName.login, (route) => false);
                 }).catchError((error) {
                 });
              },
              icon: Icon(Icons.logout))
        ],
      ),
       body: BlocProvider(
            create: (context) => CartCubit( getIt()),
            child: Builder(
              builder: (context) {
                return StreamBuilder<List<ProductsModel>>(
                    stream: context.read<CartCubit>().streamUserProductsUseCase(),
                    builder: (context, snapshot) {
                      
                      if (snapshot.hasError) {
                        return Center(child: Text("حدث خطأ: ${snapshot.error}"));
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                
                      final products = snapshot.data!;
              

                      return Column(
                        children: [
                          Expanded(
                            child: listview_cart(products: products),


                          ),
                          InvoiceWidget(context: context, totalPrice: calculateTotalPrice(products)),
                        ],
                      );
                    });
              }
            )),
      );
  }
}


 