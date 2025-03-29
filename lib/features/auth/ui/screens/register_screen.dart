import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'dart:math';

import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

class RegisterScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildGroceryBackground(), // Grocery themed background
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
                        SizedBox(height: 20),
                        Text("Create an Account", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.green.shade700)),
                        SizedBox(height: 10),
                        Text("Join us and start shopping!", style: TextStyle(color: Colors.grey)),
                        SizedBox(height: 20),
                        TextField(
                          controller: nameController,
                          decoration: InputDecoration(
                            labelText: "Name",
                            prefixIcon: Icon(Icons.person),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                        SizedBox(height: 10),
                        TextField(
                          controller: emailController,
                          decoration: InputDecoration(
                            labelText: "Email",
                            prefixIcon: Icon(Icons.email),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                        SizedBox(height: 10),
                        TextField(
                          controller: passwordController,
                          decoration: InputDecoration(
                            labelText: "Password",
                            prefixIcon: Icon(Icons.lock),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                          obscureText: true,
                        ),
                        SizedBox(height: 20),
                        BlocConsumer<AuthBloc, AuthState>(
                          listener: (context, state) {
                            if (state is AuthSuccess) {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Registration Successful!")));
                              context.go('/'); // Navigate to Login after success
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
                                      context.read<AuthBloc>().add(
                                        RegisterRequested(nameController.text, emailController.text, passwordController.text),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green.shade700,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                      padding: EdgeInsets.symmetric(vertical: 15),
                                    ),
                                    child: Text("Register", style: TextStyle(fontSize: 16, color: Colors.white)),
                                  ),
                                ),
                                SizedBox(height: 10),
                                TextButton(
                                  onPressed: () => context.go('/'),
                                  child: Text("Already have an account? Login", style: TextStyle(color: Colors.green.shade700)),
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

  Widget _buildGroceryBackground() {
    final List<IconData> icons = [
      Icons.shopping_cart,
      Icons.local_grocery_store,
      Icons.fastfood,
      Icons.apple,
      Icons.shopping_basket,
      Icons.food_bank,
    ];

    final Random random = Random();

    return Container(
      color: Colors.green.shade50,
      child: Stack(
        children: List.generate(10, (index) {
          return Positioned(
            top: random.nextDouble() * 700, 
            left: random.nextDouble() * 400,
            child: Icon(
              icons[random.nextInt(icons.length)],
              size: 40,
              color: Colors.green.shade200.withOpacity(0.3),
            ),
          );
        }),
      ),
    );
  }
}
