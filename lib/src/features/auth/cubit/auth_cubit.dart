import 'package:bloc/bloc.dart';
 
import 'package:firebase_auth/firebase_auth.dart';
 
import '../domain/entities/entities.dart';
import '../domain/usecases/usecases.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final SignUpUseCase signUpUseCase;

  AuthCubit( this.signUpUseCase ) : super(AuthInitial());

  Future<void> signUp({
    required String email,
    required String password,
   
  }) async {
    emit(SignUpLoadingState());
    try {
 

      AuthEntity user = await signUpUseCase(
        email: email,
        password: password,
      );
       
      emit(SignUpSuccessState(user));
    } catch (e) {
      emit(SignUpFailureState(errMessage: e.toString()));
    }
  }
}
