 
 
import 'package:targetshop/src/features/auth/domain/entities/auth_register_entity.dart';

sealed class AuthRegisterState {}

final class AuthRegisterInitial extends AuthRegisterState {}

final class AuthRegisterLoadingState extends AuthRegisterState {}

final class AuthRegisterSuccessState extends AuthRegisterState {
    final AuthRegisterEntity user;
  AuthRegisterSuccessState(this.user);
}

final class AuthRegisterFailureState extends AuthRegisterState {
  final String errMessage;

  AuthRegisterFailureState({required this.errMessage});
   
} 