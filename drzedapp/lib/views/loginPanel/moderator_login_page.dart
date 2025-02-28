import 'package:flutter/material.dart';

class ModeratorLoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(  // Wrap everything with Scaffold
      appBar: AppBar(
        title: const Text("Moderator Login"),
        backgroundColor: Colors.orange,
      ),
      body: _buildLoginForm("Moderator Login", Icons.security, Colors.orange),
    );
  }

  Widget _buildLoginForm(String title, IconData icon, Color color) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 80, color: color),
          const SizedBox(height: 20),
          Text(title, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          _buildTextField("Email"),
          _buildTextField("Password", isPassword: true),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // TODO: Handle moderator login logic
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: color,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
            ),
            child: const Text("Login", style: TextStyle(fontSize: 18, color: Colors.white)),
          ),
          const SizedBox(height: 10),
          TextButton(
            onPressed: () {
              // TODO: Handle "Forgot Password"
            },
            child: const Text("Forgot Password?", style: TextStyle(fontSize: 16)),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String hint, {bool isPassword = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      child: TextField(
        obscureText: isPassword,
        decoration: InputDecoration(
          hintText: hint,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }
}
