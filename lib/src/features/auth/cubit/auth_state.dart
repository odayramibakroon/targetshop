part of 'auth_cubit.dart';

 sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class SignUpLoadingState extends AuthState {}

final class SignUpSuccessState extends AuthState {
    final AuthEntity user;
  SignUpSuccessState(this.user);
}

final class SignUpFailureState extends AuthState {
  final String errMessage;

  SignUpFailureState({required this.errMessage});
   
}
class LoginLoadingState extends AuthState {}
class LoginSuccessState extends AuthState {
  final AuthEntity user;
  LoginSuccessState(this.user);
}
class LoginFailureState extends AuthState {
  final String errMessage;
  LoginFailureState({required this.errMessage});
}