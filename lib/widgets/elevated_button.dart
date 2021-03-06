import 'package:crud_app_flutter/firebase/user_authentication.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool? state;
  final GlobalKey<FormState> key1;
  final String text;
  const Button({
    required this.emailController,
    required this.key1,
    Key? key,
    required this.passwordController,
    required this.text,
    this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46,
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: ElevatedButton(
        child: Text(text, style: const TextStyle(fontSize: 16)),
        onPressed: () {
          final validation = ValidateEmailAndPassword(
            context: context,
            key: key1,
            emailController: emailController.text.trim(),
            passwordController: passwordController.text.trim(),
            state: state,
          );
          validation.userSignInAndSighnUp();
        },
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(80.0),
            ),
          ),
        ),
      ),
    );
  }
}
