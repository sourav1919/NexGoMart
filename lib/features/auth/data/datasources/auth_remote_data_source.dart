import 'package:dio/dio.dart';
import '../models/user_model.dart';

// class AuthRemoteDataSource {
//   final Dio _dio = Dio();

//   Future<UserModel> login(String email, String password) async {
//     final response = await _dio.post('https://your-api.com/auth/login', data: {
//       'email': email,
//       'password': password,
//     });

//     if (response.statusCode == 200) {
//       return UserModel.fromJson(response.data);
//     } else {
//       throw Exception('Login failed');
//     }
//   }

//   Future<UserModel> register(String name, String email, String password) async {
//     final response = await _dio.post('https://your-api.com/auth/register', data: {
//       'name': name,
//       'email': email,
//       'password': password,
//     });

//     if (response.statusCode == 200) {
//       return UserModel.fromJson(response.data);
//     } else {
//       throw Exception('Registration failed');
//     }
//   }
// }

class AuthRemoteDataSource {
  // Static user data (for testing without an API)
  static const String testEmail = "test@nexgomart.com";
  static const String testPassword = "password123";

  Future<UserModel> login(String email, String password) async {
    // Simulating API delay
    await Future.delayed(Duration(seconds: 2));

    if (email == testEmail && password == testPassword) {
      return UserModel(
        id: "1",
        name: "Test User",
        email: email,
        token: "dummy_token_123",
      );
    } else {
      throw Exception('Invalid email or password');
    }
  }

  Future<UserModel> register(String name, String email, String password) async {
    // Simulating API delay
    await Future.delayed(Duration(seconds: 2));

    return UserModel(
      id: "2",
      name: name,
      email: email,
      token: "dummy_token_456",
    );
  }
}
