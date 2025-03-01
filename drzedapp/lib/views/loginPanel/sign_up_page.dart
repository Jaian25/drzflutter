import 'package:drzedapp/services/firebase_auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/material.dart';
import '../../models/user.dart' as db_user;
import '../../views/homePanel/home_screen.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();

  bool _isLoading = false;

  Future<void> _signUp() async {
    setState(() => _isLoading = true);

    FirebaseAuthService firebaseAuthService = FirebaseAuthService();
    firebase_auth.User? signedUpUser = await firebaseAuthService.signUpWithEmail(
      _emailController.text.trim(),
      _passwordController.text.trim(),
    );

    setState(() => _isLoading = false);

    if (signedUpUser == null) {
      _showErrorDialog("Signup failed. Please try again.");
      return;
    }

    db_user.User newUser = db_user.User(
      userId: signedUpUser.uid,
      name: _nameController.text.trim(),
      mobile: _mobileController.text.trim(),
      email: _emailController.text.trim(),
      favourites: [],
      profileUri: "",
      privilege: db_user.Privilege.User,
      dateCreated: DateTime.now(),
      lastLogin: DateTime.now(),
      isActive: true,
      bio: _bioController.text.trim().isNotEmpty ? _bioController.text.trim() : "",
    );

    print("User Created: ${newUser.toMap()}");

    // Show success message
    _showSuccessDialog();
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Signup Failed"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Signup Successful"),
        content: const Text("Redirecting to Home..."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
            },
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign Up"),
        backgroundColor: Colors.green,
      ),
      body: _buildSignUpForm(),
    );
  }

  Widget _buildSignUpForm() {
  return SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch, // Stretch elements to fit width
        children: [
          const Icon(Icons.person_add, size: 80, color: Colors.green),
          const SizedBox(height: 20),
          _buildTextField("Name", _nameController),
          _buildTextField("Email", _emailController),
          _buildTextField("Mobile", _mobileController),
          _buildTextField("Password", _passwordController, isPassword: true),
          _buildTextField("Bio (optional)", _bioController),
          const SizedBox(height: 20),
          _isLoading
              ? const Center(child: CircularProgressIndicator())  // Center loader
              : ElevatedButton(
                  onPressed: _signUp,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  ),
                  child: const Text("Sign Up", style: TextStyle(fontSize: 18, color: Colors.white)),
                ),
        ],
      ),
    ),
  );
}

  Widget _buildTextField(String hint, TextEditingController controller, {bool isPassword = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        decoration: InputDecoration(
          hintText: hint,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }
}
