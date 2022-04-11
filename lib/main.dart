import 'package:crud_app_flutter/database/database_functions.dart';
import 'package:crud_app_flutter/screens/splashScreen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await initializeDataBase();
  getAllStudentsDetails();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login App',
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 53, 6, 221),
      ),
      home: const SplashScreen(),
    );
  }
}
