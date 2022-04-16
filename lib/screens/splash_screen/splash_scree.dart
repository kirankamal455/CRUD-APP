import 'dart:async';
import 'package:crud_app_flutter/screens/home_screen/students_details_list.dart';
import 'package:crud_app_flutter/screens/login_screen/login_scree.dart';
import 'package:crud_app_flutter/widgets/progress_bar.dart';
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
      backgroundColor: const Color(0xFFFFD600),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            child: Image.asset(
              'assets/images/flutter_ui_dev_logo.png',
              height: 120,
              width: 120,
            ),
          ),
          const SizedBox(height: 37),
          const ProgressBar(),
        ],
      ),
    );
  }

//Checks whether the user is logged in or not
  void isUserisLogedOrnot() async {
    if (FirebaseAuth.instance.currentUser?.uid == null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => const LoginScreen(),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => const HomePage(),
        ),
      );
    }
  }
}
