import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../domain/entities/categories_entity.dart';
 import '../domain/usecases/usecases.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  final GetHomeUseCase getCategories;

  CategoriesCubit(this.getCategories) : super(CategoriesInitial());

  Future<void> fetchCategories() async {
    if (state is CategoriesLoaded|| state is CategoriesLoading) return; 

    emit(CategoriesLoading());
  
    try {
      final data = await getCategories();

      // تحقق أن الـ Cubit لم يتم غلقه قبل إصدار الحالة
      if (!isClosed) {
        emit(CategoriesLoaded(data));
      }
    } catch (e) {
      if (!isClosed) {
        emit(CategoriesError(e.toString()));
      }
    }
  }


 
}
 