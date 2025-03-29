import 'package:nexgomart/features/auth/data/models/user_model.dart';
import 'package:nexgomart/features/auth/data/repo/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase({required this.repository});

  Future<UserModel> execute(String email, String password) {
    return repository.login(email, password);
  }
}
