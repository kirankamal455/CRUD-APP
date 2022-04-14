import 'package:crud_app_flutter/firebase/user_authentication.dart';
import 'package:flutter/material.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  //Form validation
  //generation of formkey
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
                    Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(10),
                        child: const Text(
                          'Login to your Account ',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        )),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        controller: emailController,
                        validator: validateEmail,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Email Id',
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: TextFormField(
                        obscureText: true,
                        controller: passwordController,
                        validator: validatePassword,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    Container(
                        height: 50,
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: ElevatedButton(
                            child: const Text('Sign In',
                                style: TextStyle(fontSize: 16)),
                            onPressed: () {
                              final validation = ValidateEmailAndPassword(
                                context: context,
                                key: key,
                                emailController: emailController.text.trim(),
                                passwordController:
                                    passwordController.text.trim(),
                                state: true,
                              );
                              validation.userSignInAndSighnUp();

                              setState(() {});
                            },
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ))))),
                    const SizedBox(height: 20),
                    Row(
                      children: <Widget>[
                        const Text(
                          'Dont have an account ?',
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
                                    builder: (context) =>
                                        const SignUpScreen()));
                          },
                        )
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                  ],
                )),
          ),
        ));
  }
}
