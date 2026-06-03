 import 'package:targetshop/src/features/home/domain/entities/categories_entity.dart';
import 'package:targetshop/src/features/home/domain/repositories/repositories.dart';

class AddCategoryUseCase {
  final HomeRepository repository;

  AddCategoryUseCase( this.repository);

  Future<void> call(Category category) {
    return repository.addCategory(category);
  }
}