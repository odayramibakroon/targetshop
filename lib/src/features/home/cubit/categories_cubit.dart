import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:targetshop/src/core/config/injection.dart';
import 'package:targetshop/src/features/home/domain/usecases/addcategory.dart';
 
import '../domain/entities/categories_entity.dart';
import '../domain/usecases/usecases.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  final GetHomeUseCase getCategories;
  final AddCategoryUseCase addCategory;

  CategoriesCubit(this.getCategories, this.addCategory)
      : super(CategoriesInitial());

  Future<void> fetchCategories() async {
    if (state is CategoriesLoading) return;

    emit(CategoriesLoading());

    try {
      final data = await getCategories();

      if (!isClosed) {
        emit(CategoriesLoaded(data));
      }
    } catch (e) {
      if (!isClosed) {
        emit(CategoriesError(e.toString()));
      }
    }
  }

  Future<void> addCategories(Category category) async {
    

 
    try {
            print("Adding category1: ${category.name}"); // Debug print

      await addCategory(category);
      print("Adding category2: ${category.name}"); // Debug print

 
      await fetchCategories();
    } catch (e) {
      print("Error adding category: ${e.toString()}"); // Debug print
     }
  }
}
