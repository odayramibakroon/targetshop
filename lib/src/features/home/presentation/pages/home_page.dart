import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:targetshop/generated/l10n.dart';
import 'package:targetshop/src/features/home/presentation/widgets/shimmeruser.dart';
 
import '../../../../core/config/container.dart';
import '../../../users/cubit/user_cubit.dart';
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
        appBar: AppBar(title: Center(child: Text( S.of(context).home)),),
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
              Icon(Icons.verified, size: 16, color: const Color.fromARGB(255, 74, 130, 255)), 
  
            ],
          );
        }
    if (state is UserError) {
          final user = state.message;

           return Row(
            children: [
            
              const SizedBox(width: 12),
              Text(
                '${user.toString()}  ',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            
  
            ],
          );
        }

        return const SizedBox.shrink();
      },
    ),
  ),
)
,
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
