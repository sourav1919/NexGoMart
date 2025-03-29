abstract class AuthEvent {}

class LoginRequested extends AuthEvent {
  final String email;
  final String password;

  LoginRequested(this.email, this.password);
}

class LoginRequestedFromToken extends AuthEvent {
  final String token;

  LoginRequestedFromToken(this.token);

  @override
  List<Object?> get props => [token];
}

class RegisterRequested extends AuthEvent {
  final String name;
  final String email;
  final String password;

  RegisterRequested(this.name, this.email, this.password);
}

class LogoutRequested extends AuthEvent {}

