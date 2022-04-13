import 'dart:async';
import 'package:crud_app_flutter/screens/Login_Screen.dart';
import 'package:crud_app_flutter/screens/students_details_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 2), () {
      isUserisLogedOrnot();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.yellow,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              child: Image.asset(
                'assets/images/flutter_ui_dev_logo.png',
                height: 180,
                width: 180,
              ),
            ),
            // SizedBox(height: 30),
            // Container(
            //   child: const Text('CRUD APP'),
            // )
          ],
        ));
  }

//checking wether the user is loged or not
  void isUserisLogedOrnot() async {
    if (FirebaseAuth.instance.currentUser?.uid == null) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => const LoginScreen()));
    } else {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => const HomePage()));
    }
  }
}
