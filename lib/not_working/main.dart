import 'package:flutter/material.dart';
import 'package:proiect/screens/homepage.dart';
import 'package:proiect/objectbox.dart';

late ObjectBox objectBox;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  objectBox = await ObjectBox.create();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Proiect',
      home: FutureBuilder<ObjectBox>(
        future: _initializeObjectBox(), // Initialize ObjectBox asynchronously
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Show a loading screen while ObjectBox initializes
            return const Scaffold(
              body: const Center(child: CircularProgressIndicator()),
            );
          } else if (snapshot.hasError) {
            // Handle any errors during initialization
            return Scaffold(
              body: Center(
                  child:
                      Text('Error initializing database: ${snapshot.error}')),
            );
          }

          // Initialization successful, use ObjectBox instance
          objectBox = snapshot.data!;
          return HomePage(objectBox: objectBox); // Pass ObjectBox to HomePage
        },
      ),
    );
  }

  /// Asynchronous initialization of ObjectBox
  Future<ObjectBox> _initializeObjectBox() async {
    return await ObjectBox.create();
  }
}
