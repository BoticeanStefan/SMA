import 'package:flutter/material.dart';
import 'register_page.dart';
import 'login_page.dart';
import '../objectbox.dart';

class HomePage extends StatelessWidget {
  final ObjectBox objectBox; // Accept ObjectBox as a parameter

  const HomePage({super.key, required this.objectBox});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Proiect'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(), // No parameters needed for LoginPage (optional)
                  ),
                );
              },
              child: const Text('Login'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RegisterPage(objectBox: objectBox), // Pass the ObjectBox instance
                  ),
                );
              },
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
