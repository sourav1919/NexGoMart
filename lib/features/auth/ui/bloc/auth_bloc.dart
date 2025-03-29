import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nexgomart/core/utils/auth_storage.dart';
import 'package:nexgomart/features/auth/domain/usecases/register_usecase.dart';
import '../../domain/usecases/login_usecase.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;

  AuthBloc({required this.loginUseCase, required this.registerUseCase})
    : super(AuthInitial()) {
    on<LoginRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        final user = await loginUseCase.execute(event.email, event.password);
        await AuthStorage.saveToken(user.token);
        emit(AuthLoginSuccess(user.token));
      } catch (e) {
        emit(AuthFailure(e.toString()));
      }
    });

    on<LoginRequestedFromToken>((event, emit) async {
      emit(
        AuthLoginSuccess(event.token),
      ); // Directly set AuthSuccess if token exists
    });

    on<RegisterRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        final user = await registerUseCase.execute(
          event.name,
          event.email,
          event.password,
        );
        emit(AuthSuccess(user));
      } catch (e) {
        emit(AuthFailure(e.toString()));
      }
    });

    on<LogoutRequested>((event, emit) async {
      await AuthStorage.deleteToken(); // Delete token
      emit(AuthInitial());
    });
  }
}
