import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nexgomart/features/auth/ui/bloc/auth_bloc.dart';
import 'package:nexgomart/features/auth/ui/bloc/auth_event.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Profile"),
        actions: [
          // IconButton(
          //   icon: Icon(Icons.logout),
          //   onPressed: () {
          //     context.go('/');
          //     context.read<AuthBloc>().add(LogoutRequested());
          //   },
          // ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey.shade300,
                    child: Icon(Icons.person, size: 50, color: Colors.white),
                  ),
                  SizedBox(height: 10),
                  Text("Test User", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Text("test@nexgomart.com", style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),
            SizedBox(height: 20),
            Divider(),
            _buildProfileOption(Icons.edit, "Edit Profile"),
            _buildProfileOption(Icons.location_on, "Manage Addresses"),
            _buildProfileOption(Icons.shopping_bag, "My Orders"),
            _buildProfileOption(Icons.payment, "Payment Methods"),
            _buildProfileOption(Icons.help, "Help & Support"),
            _buildProfileOption(Icons.logout, "Logout", isLogout: true, onTap: () {
              context.go('/');
              context.read<AuthBloc>().add(LogoutRequested());
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileOption(IconData icon, String title, {bool isLogout = false, VoidCallback? onTap}) {
    return ListTile(
      leading: Icon(icon, color: isLogout ? Colors.red : Colors.black87),
      title: Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
      trailing: Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap ?? () {},
    );
  }
}
