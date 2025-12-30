import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/config/container.dart';
import '../../../users/cubit/user_cubit.dart';
import '../../../users/data/models/user_model.dart';
import '../../cubit/categories_cubit.dart';
import 'list_categores.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Future<void> addProduct() async {
      await FirebaseFirestore.instance.collection('categories').add({
        'name': 'فراخ',
        'details': 'حاجه',
        'image':
            'https://i.ytimg.com/vi/uKdToU5pO8s/hq720.jpg?sqp=-oaymwEhCK4FEIIDSFryq4qpAxMIARUAAAAAGAElAADIQj0AgKJD&rs=AOn4CLB9WtK9ewptr8jCyqNTNNbsQjLeKA',
      });
    }

    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: addProduct,
          child: const Icon(Icons.add),
        ),
        body: CustomScrollView(
          slivers: [
           StreamBuilder<UserViewModel>(
            
  stream: context.read<UserCubit>().getUserStream(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                        final user = snapshot.data!;
                  return SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage( user.image),
                          ),
                          const SizedBox(width: 12),
                          Text(
                             user.firstname + " " +  user.lastname,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
     
                if (snapshot.hasError||!snapshot.hasData ||snapshot.data == null) {
      return SliverToBoxAdapter(
        child: Text('Error: ${snapshot.error}'),
      );
    }

                return SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        const CircleAvatar(
                          radius: 30,
                          backgroundImage:
                              AssetImage('assets/images/imgprofile.png'),
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
                );
              },
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
            BlocProvider(
              create: (context) => CategoriesCubit(getIt())..fetchCategories(),
              child: ListCategories(),
            )
          ],
        ) //closed custom

        );
  }
}
