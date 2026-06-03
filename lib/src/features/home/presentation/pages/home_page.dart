import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:targetshop/generated/l10n.dart';
import 'package:targetshop/src/features/home/domain/entities/categories_entity.dart';
import 'package:targetshop/src/features/home/presentation/widgets/shimmeruser.dart';

 import '../../../users/cubit/user_cubit.dart';
import '../../cubit/categories_cubit.dart';
import 'list_categores.dart';

 
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddCategoryDialog(
            context,
            context.read<CategoriesCubit>(),
          );
        },
        child: const Icon(Icons.add),
      ),

      appBar: AppBar(
        title: Center(child: Text(S.of(context).home)),
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
                        if (user.isVerified)
                          const Icon(
                            Icons.verified,
                            size: 16,
                            color: Color.fromARGB(255, 74, 130, 255),
                          ),
                      ],
                    );
                  }

                  if (state is UserError) {
                    return Text(state.message);
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

           const ListCategories(),
        ],
      ),
    );
  }
}
void _showAddCategoryDialog(
  BuildContext context,
  CategoriesCubit cubit,
) {
  final nameController = TextEditingController();
  final detailsController = TextEditingController();
  final imageController = TextEditingController();

  showDialog(
    context: context,
    builder: (dialogContext) {
      return AlertDialog(
        title: const Text("Add Category"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Name"),
            ),
            TextField(
              controller: detailsController,
              decoration: const InputDecoration(labelText: "Details"),
            ),
            TextField(
              controller: imageController,
              decoration: const InputDecoration(labelText: "Image URL"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text("Cancel"),
          ),

          ElevatedButton(
            onPressed: () {
              if (nameController.text.isEmpty ||
                  detailsController.text.isEmpty ||
                  imageController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Please fill all fields")),
                );
                return;
              }

              cubit.addCategories(
                Category(
                  name: nameController.text,
                  details: detailsController.text,
                  image: imageController.text,
                ),
              );

              Navigator.pop(dialogContext);
            },
            child: const Text("Save"),
          ),
        ],
      );
    },
  );
}