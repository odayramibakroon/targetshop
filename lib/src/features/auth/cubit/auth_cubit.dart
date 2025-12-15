import 'package:bloc/bloc.dart';
import 'package:clone_whatsapp_round34/src/features/auth/domain/entities/entities.dart';
import 'package:clone_whatsapp_round34/src/features/auth/domain/usecases/usecases.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
 final SignUpUseCase signUpUseCase;

  AuthCubit(this.signUpUseCase) : super(AuthInitial());

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
