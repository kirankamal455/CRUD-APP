import 'package:crud_app_flutter/database/list_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'Signup_Screen.dart';

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
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  String errorMessage = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
          automaticallyImplyLeading: false,
        ),
        body: Form(
          key: _key,
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
                          labelText: 'User Name',
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
                            child: const Text('Sign in',
                                style: TextStyle(fontSize: 16)),
                            onPressed: () {
                              signIn();

                              setState(() {});
                            },
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18.0),
                                        side: const BorderSide(
                                            color: Colors.blue)))))),
                    const SizedBox(height: 20),
                    Row(
                      children: <Widget>[
                        const Text('Dont have an account ?'),
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

  signIn() async {
    if (_key.currentState!.validate()) {
      try {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailController.text, password: passwordController.text)
            .then((value) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const HomePage()));
        });
        errorMessage = '';
      } on FirebaseAuthException catch (e) {
        errorMessage = e.code;
        //An error from the firbase will trigger the snack bar
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(errorMessage),
          backgroundColor: Colors.red,
        ));
      }
      setState(() {});
    }
  }
}

//To check if the password field is empty or not
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
// Future<void> InternetCheck()
// async {
//   bool result = await InternetConnectionChecker().hasConnection;
// if(result == true) {
//   print('YAY! Free cute dog pics!');
// } else {
//   print('No internet :( Reason:');
//   print(InternetConnectionChecker().lastTryResults);
// }
// }
