import 'package:go_router/go_router.dart';
import 'package:nexgomart/features/auth/ui/screens/login_screen.dart';
import 'package:nexgomart/features/auth/ui/screens/main_screen.dart';
import 'package:nexgomart/features/auth/ui/screens/register_screen.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => RegisterScreen(),
    ),
    GoRoute(
      path: '/main',
      builder: (context, state) => MainScreen(),
    ),
  ],
);
