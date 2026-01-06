// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:targetshop/src/features/auth/cubit/auth_register_state.dart';
import 'package:targetshop/src/features/auth/domain/entities/auth_register_entity.dart';

import '../domain/entities/entities.dart';
import '../domain/usecases/login_use_case.dart';
import '../domain/usecases/usecases.dart';

 
class AuthRegisterCubit extends Cubit<AuthRegisterState> {
  final RegisterUseCase signUpUseCase;
 
  AuthRegisterCubit(this.signUpUseCase ) : super(AuthRegisterInitial());

  Future<void> signUp({
    required String email,
    required String password,
    required String firstname,
    required String lastname,
    required int age,
  }) async {
    emit(AuthRegisterLoadingState());
    try {
      AuthRegisterEntity user = await signUpUseCase(
        email: email,
        password: password,
        firstname: firstname,
        lastname: lastname,
        age: age,
      );

      emit(AuthRegisterSuccessState(user));
    } catch (e) {
      emit(AuthRegisterFailureState(errMessage: e.toString()));
    }
  }

 
}
