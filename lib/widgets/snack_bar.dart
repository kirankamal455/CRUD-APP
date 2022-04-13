import 'package:flutter/material.dart';

// class Snackbar11 {
//   final String text;
//   final Color color;
//   BuildContext context;
//   Snackbar11({required this.text, required this.color, required this.context});
//   Widget build(BuildContext context) {
//     return Scaffold();
//   }
// }
// final String text;
//   final Color color;
//   BuildContext context;
//   SnackBar({required this.text, required this.color, required this.context});
void snackBarnew(BuildContext context, message, color) {
  snackBarnew(context, message, color);
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(message), backgroundColor: color),
  );
}
