import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

import '../../../../core/config/config.dart';
import '../../domain/usecases/toggle_like_use_case.dart';
class FavoriteButtonAnimated extends StatelessWidget {
  final double size;
  final bool isLiked;
  final String categoryId;
  final String productId;
   
  const FavoriteButtonAnimated({
    super.key,
    this.size = 30,
    required this.isLiked,
    required this.categoryId,
    required this.productId,
  });

  @override
  Widget build(BuildContext context) {
    return LikeButton(
      size: size,
      isLiked: isLiked,
      circleColor: const CircleColor(
        start: Colors.red,
        end: Colors.pink,
      ),
      bubblesColor: const BubblesColor(
        dotPrimaryColor: Colors.red,
        dotSecondaryColor: Colors.pink,
      ),
onTap: (currentLike) async {
  final newValue = !currentLike;

  // نعيد القيمة فورًا للقلب لتحديث الواجهة
  ToggleLikeUseCase(repository: getIt()).call(
    categoryId: categoryId,
    productId: productId,
    isLiked: newValue,
  );

  return newValue; // <- هذا يخلي القلب يتغير فورًا
},



      likeBuilder: (isLiked) {
        return Icon(
          isLiked ? Icons.favorite : Icons.favorite_border,
          color: isLiked ? Colors.red : Colors.grey,
          size: size,
        );
      },
    );
  }
}
