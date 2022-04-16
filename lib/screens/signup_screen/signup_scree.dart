import 'package:crud_app_flutter/widgets/elevated_button.dart';
import 'package:crud_app_flutter/widgets/text_field.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String errorMessage = '';
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordController1 = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign up')),
      body: Form(
        key: _key,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[
              const SizedBox(height: 80),
              const Heading(text: 'Register'),
              const SizedBox(height: 30),
              EmailTextField(emailController: emailController),
              PasswordTextField(passwordController: passwordController),
              const SizedBox(height: 40),
              Button(
                emailController: emailController,
                key1: _key,
                passwordController: passwordController,
                text: 'Sign Up',
                state: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
