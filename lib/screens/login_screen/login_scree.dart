import 'package:crud_app_flutter/screens/signup_screen/signup_scree.dart';
import 'package:crud_app_flutter/widgets/elevated_button.dart';
import 'package:crud_app_flutter/widgets/text_field.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  //Form validation and generation of formkey
  final GlobalKey<FormState> key = GlobalKey<FormState>();
  String errorMessage = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        automaticallyImplyLeading: false,
      ),
      body: Form(
        key: key,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                const SizedBox(height: 80),
                const Heading(text: 'Login to your Account'),
                const SizedBox(height: 10),
                EmailTextField(emailController: emailController),
                const SizedBox(height: 10),
                PasswordTextField(passwordController: passwordController),
                const SizedBox(height: 40),
                Button(
                  emailController: emailController,
                  key1: key,
                  passwordController: passwordController,
                  text: 'Sign In',
                  state: true,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      "Don't have an account ?",
                      style: TextStyle(color: Colors.black),
                    ),
                    TextButton(
                      child: const Text(
                        'Sign up',
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignUpScreen(),
                          ),
                        );
                      },
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
