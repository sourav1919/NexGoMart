import 'package:nexgomart/features/auth/data/models/user_model.dart';
import 'package:nexgomart/features/auth/data/repo/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository repository;

  RegisterUseCase({required this.repository});

  Future<UserModel> execute(String name, String email, String password) {
    return repository.register(name, email, password);
  }
}
