import '../repositories/repositories.dart';

class ToggleLikeUseCase {
  final HomeRepository repository;

  ToggleLikeUseCase({required this.repository});

  Future<void> call({
    required String categoryId,
    required String productId,
    required bool isLiked,
  }) {
    return repository.toggleLike(
      categoryId: categoryId,
      productId: productId,
      isLiked: isLiked,
    );
  }
}
