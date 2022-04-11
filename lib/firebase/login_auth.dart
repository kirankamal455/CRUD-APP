import 'package:crud_app_flutter/screens/students_details_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ValidateEmailAndPassword {
  final String emailController;
  final String passwordController;
  final BuildContext context;
  bool? state;
  GlobalKey<FormState> key;
  ValidateEmailAndPassword(
      {required this.emailController,
      required this.passwordController,
      required this.context,
      required this.key,
      this.state});
  String errorMessage = '';

  userSignInAndSighnUp() async {
    if (key.currentState!.validate()) {
      try {
        if (state == true) {
          //validation of signing
          await FirebaseAuth.instance
              .signInWithEmailAndPassword(
                  email: emailController, password: passwordController)
              .then((value) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const HomePage()));
          });
          //validation of signup
        } else {
          await FirebaseAuth.instance
              .createUserWithEmailAndPassword(
                  email: emailController, password: passwordController)
              .then((value) {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const HomePage()),
                (Route<dynamic> route) => false);
          });
        }
        errorMessage = '';
      } on FirebaseAuthException catch (e) {
        errorMessage = e.code;
        //An error from the firbase will trigger the snack bar
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(errorMessage),
          backgroundColor: Colors.red,
        ));
      }
    }
  }
}

///To check if the password field is empty or not
String? validateEmail(String? formEmail) {
  if (formEmail == null || formEmail.isEmpty) {
    return 'Email addrees is required';
  }

  return null;
}

//To check if the password field is empty or not
String? validatePassword(String? formpass) {
  if (formpass == null || formpass.isEmpty) {
    return 'Password is required';
  }
  return null;
}
