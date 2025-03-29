import 'package:nexgomart/features/auth/domain/entities/user.dart';

import '../models/user_model.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepository({required this.remoteDataSource});

  Future<UserModel> login(String email, String password) {
    return remoteDataSource.login(email, password);
  }

  Future<UserModel> register(String name, String email, String password) {
    return remoteDataSource.register(name, email, password);
  }
}
