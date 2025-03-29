import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'dart:math';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildDecorativeBackground(),
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.shopping_cart, size: 80, color: Colors.green.shade700),
                        SizedBox(height: 20),
                        Text("Welcome to NexGo Mart!", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.green.shade700)),
                        SizedBox(height: 10),
                        Text("Login to continue shopping", style: TextStyle(color: Colors.grey)),
                        SizedBox(height: 20),
                        _buildTextField(emailController, "Email", Icons.email),
                        SizedBox(height: 10),
                        _buildTextField(passwordController, "Password", Icons.lock, isPassword: true),
                        SizedBox(height: 20),
                        BlocConsumer<AuthBloc, AuthState>(
                          listener: (context, state) {
                            if (state is AuthLoginSuccess) {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Login Successful!")));
                              context.go('/main');
                            } else if (state is AuthFailure) {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
                            }
                          },
                          builder: (context, state) {
                            if (state is AuthLoading) {
                              return CircularProgressIndicator();
                            }
                            return Column(
                              children: [
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      context.read<AuthBloc>().add(LoginRequested(emailController.text, passwordController.text));
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green.shade700,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                      padding: EdgeInsets.symmetric(vertical: 15),
                                    ),
                                    child: Text("Login", style: TextStyle(fontSize: 16, color: Colors.white)),
                                  ),
                                ),
                                SizedBox(height: 10),
                                TextButton(
                                  onPressed: () => context.push('/register'),
                                  child: Text("Don't have an account? Register", style: TextStyle(color: Colors.green.shade700)),
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDecorativeBackground() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return CustomPaint(
          size: Size(constraints.maxWidth, constraints.maxHeight),
          painter: _BackgroundPainter(),
        );
      },
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, IconData icon, {bool isPassword = false}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      obscureText: isPassword,
    );
  }
}

class _BackgroundPainter extends CustomPainter {
  final List<IconData> icons = [
    Icons.shopping_bag, Icons.local_grocery_store, Icons.fastfood, Icons.eco, Icons.apple,
  ];

  final List<Color> colors = [
    Colors.green.shade100, Colors.green.shade200, Colors.green.shade300,
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final random = Random();
    final paint = Paint();
    final iconSize = 50.0;

    for (int i = 0; i < 10; i++) {
      final icon = icons[random.nextInt(icons.length)];
      final color = colors[random.nextInt(colors.length)];
      final dx = random.nextDouble() * size.width;
      final dy = random.nextDouble() * size.height;

      paint.color = color.withOpacity(0.3);
      canvas.drawCircle(Offset(dx, dy), iconSize / 2, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
