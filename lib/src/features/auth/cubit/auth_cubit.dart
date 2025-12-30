// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';

import '../domain/entities/entities.dart';
import '../domain/usecases/login_use_case.dart';
import '../domain/usecases/usecases.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final SignUpUseCase signUpUseCase;
  final LoginUseCase loginUseCase;

  AuthCubit(this.signUpUseCase, this.loginUseCase) : super(AuthInitial());

  Future<void> signUp({
    required String email,
    required String password,
    required String firstname,
    required String lastname,
    required int age,
  }) async {
    emit(SignUpLoadingState());
    try {
      AuthEntity user = await signUpUseCase(
        email: email,
        password: password,
        firstname: firstname,
        lastname: lastname,
        age: age,
      );

      emit(SignUpSuccessState(user));
    } catch (e) {
      emit(SignUpFailureState(errMessage: e.toString()));
    }
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(LoginLoadingState());
    try {
      final user = await loginUseCase(email: email, password: password);
      emit(LoginSuccessState(user));
    } catch (e) {

   
    String message(String e) {
    switch (e) {
 
      case 'Exception: The supplied auth credential is incorrect, malformed or has expired.':
        return 'Your Email Or Password Not Correct';
      case 'invalid-email':
        return 'صيغة الإيميل غير صحيحة';
      case 'user-disabled':
        return 'هذا الحساب معطّل';
      default:
        return e.toString();
    }
  }
 
  emit(LoginFailureState(errMessage: message(e.toString())));
 
          

      print("errMessage:${e.toString()}");

    }
  }
}
