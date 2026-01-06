part of 'auth_cubit.dart';

 sealed class AuthState {}

final class AuthInitial extends AuthState {}
 
class LoginLoadingState extends AuthState {}
class LoginSuccessState extends AuthState {
  final AuthEntity user;
  LoginSuccessState(this.user);
}
class LoginFailureState extends AuthState {
  final String errMessage;
  LoginFailureState({required this.errMessage});
}