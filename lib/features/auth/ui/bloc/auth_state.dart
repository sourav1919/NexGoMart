import 'package:nexgomart/features/auth/data/models/user_model.dart';


abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthLoginSuccess extends AuthState {
  final String token;

  AuthLoginSuccess(this.token);
}

class AuthSuccess extends AuthState {
  final UserModel user;

  AuthSuccess(this.user);
}

class AuthFailure extends AuthState {
  final String message;

  AuthFailure(this.message);
}
