import 'package:flutter/material.dart';
import 'package:proiect/objectbox.dart';
import 'package:proiect/models/user.dart';
import '../objectbox.g.dart';
import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  final ObjectBox objectBox; // Accept ObjectBox as a parameter

  const RegisterPage({super.key, required this.objectBox});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  /// Function to register a new user
  void _register() {
    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      _showSnackBar('Please fill in all fields.');
      return;
    }

    final userBox = widget.objectBox.store.box<User>(); // Use ObjectBox from widget

    // Check if username already exists
    final existingUser = userBox
        .query(User_.username.equals(username))
        .build()
        .findFirst();

    if (existingUser != null) {
      _showSnackBar('Username already exists!');
    } else {
      // Create and store new user
      final newUser = User(username: username, password: password);
      try {
        userBox.put(newUser);
        _showSnackBar('Registration Successful!', isSuccess: true);

        // Navigate to Login Page after a slight delay
        Future.delayed(const Duration(seconds: 1), () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginPage()),
          );
        });
      } catch (e) {
        _showSnackBar('An error occurred during registration.');
      }
    }
  }

  /// Function to show a snack bar with a message
  void _showSnackBar(String message, {bool isSuccess = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isSuccess ? Colors.green : Colors.red,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register v3')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _register,
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
