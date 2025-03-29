// import 'package:nexgomart/features/auth/data/repo/auth_repository.dart';
// import 'package:nexgomart/features/auth/ui/bloc/auth_bloc.dart';

// import 'data/datasources/auth_remote_data_source.dart';
// import 'domain/usecases/login_usecase.dart';

// class AuthModule {
//   static AuthRemoteDataSource provideAuthRemoteDataSource() {
//     return AuthRemoteDataSource();
//   }

//   static AuthRepository provideAuthRepository() {
//     return AuthRepository(remoteDataSource: provideAuthRemoteDataSource());
//   }

//   static LoginUseCase provideLoginUseCase() {
//     return LoginUseCase(repository: provideAuthRepository());
//   }

//   static AuthBloc provideAuthBloc() {
//     return AuthBloc(loginUseCase: provideLoginUseCase());
//   }
// }
