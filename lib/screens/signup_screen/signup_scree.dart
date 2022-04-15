import 'package:crud_app_flutter/firebase/user_authentication.dart';
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
                  const Center(
                    child: Text(
                      'Register',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      controller: emailController,
                      validator: validateEmail,
                      decoration: const InputDecoration(
                          hintText: 'Email id',
                          contentPadding: EdgeInsets.all(15),
                          border: OutlineInputBorder()),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: TextFormField(
                      obscureText: true,
                      controller: passwordController,
                      validator: validatePassword,
                      decoration: const InputDecoration(
                          hintText: 'Password',
                          contentPadding: EdgeInsets.all(15),
                          border: OutlineInputBorder()),
                    ),
                  ),
                  const SizedBox(height: 40),
                  Container(
                    height: 50,
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Padding(
                        padding: const EdgeInsets.fromLTRB(40, 5, 40, 0),
                        child: ElevatedButton(
                          child: const Text('Sign up'),
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ))),
                          onPressed: () {
                            final validation = ValidateEmailAndPassword(
                              context: context,
                              key: _key,
                              emailController: emailController.text.trim(),
                              passwordController:
                                  passwordController.text.trim(),
                              state: false,
                            );
                            validation.userSignInAndSighnUp();

                            //signUp();
                            setState(() {});
                          },
                        )),
                  ),
                ],
              )),
        ));
  }
}
