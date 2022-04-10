import 'dart:async';
import 'package:crud_app_flutter/Firebase_user_Login/Login_Screen_1.dart';
import 'package:crud_app_flutter/database/list_view.dart';
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

    Timer(const Duration(seconds: 4), () {
      isUserisLogedOrnot();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: const BoxDecoration(color: Colors.greenAccent),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 50.0,
                      child: Icon(
                        Icons.cast_for_education_rounded,
                        color: Colors.black,
                        size: 50.0,
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 15.0)),
                    Text(
                      "CRUD APP",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24.0,
                          color: Colors.black),
                    ),
                    SizedBox(height: 26),
                    CircularProgressIndicator(
                      backgroundColor: Colors.white,
                      valueColor: AlwaysStoppedAnimation(Colors.greenAccent),
                      strokeWidth: 3,
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
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
