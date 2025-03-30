import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nexgomart/config/router/app_router.dart';
import 'package:nexgomart/core/utils/auth_storage.dart';
import 'package:nexgomart/features/auth/data/repo/auth_repository.dart';
import 'package:nexgomart/features/auth/ui/bloc/auth_bloc.dart';
import 'package:nexgomart/features/auth/ui/bloc/auth_event.dart';
import 'package:nexgomart/features/cart/ui/bloc/cart_bloc.dart';
import 'features/auth/data/datasources/auth_remote_data_source.dart';
import 'features/auth/domain/usecases/login_usecase.dart';
import 'features/auth/domain/usecases/register_usecase.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final authRepository = AuthRepository(remoteDataSource: AuthRemoteDataSource());

  String? savedToken = await AuthStorage.getToken();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(
            loginUseCase: LoginUseCase(repository: authRepository),
            registerUseCase: RegisterUseCase(repository: authRepository),
          ),
        ),
        BlocProvider(create: (context) => CartBloc()),
      ],
      child: MyApp(savedToken: savedToken),
    ),
  );
}

class MyApp extends StatelessWidget {
  final String? savedToken;
  
  const MyApp({super.key, this.savedToken});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
      builder: (context, child) {
        if (savedToken != null) {
          context.read<AuthBloc>().add(LoginRequestedFromToken(savedToken!));
        }
        return child!;
      },
    );
  }
}
