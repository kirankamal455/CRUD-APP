// import 'package:crud_app_flutter/app/passdata/secondScreen.dart';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// // class FirstScreen extends StatefulWidget {
// //   const FirstScreen({Key? key}) : super(key: key);

// //   @override
// //   _FirstScreenState createState() {
// //     return _FirstScreenState();
// //   }
// // }

// // class _FirstScreenState extends State<FirstScreen> {
// // this allows us to access the TextField text
// class FirstScreen extends StatelessWidget {
//   FirstScreen({Key? key}) : super(key: key);

//   final TextEditingController textFieldController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('First screen')),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(32.0),
//             child: TextField(
//               controller: textFieldController,
//               style: const TextStyle(
//                 fontSize: 24,
//                 color: Colors.black,
//               ),
//             ),
//           ),
//           RaisedButton(
//             child: const Text(
//               'Go to second screen',
//               style: TextStyle(fontSize: 24),
//             ),
//             onPressed: () {
//               _sendDataToSecondScreen();
//             },
//           )
//         ],
//       ),
//     );
//   }

//   // get the text in the TextField and start the Second Screen
//   void _sendDataToSecondScreen() {
//     String textToSend = textFieldController.text;

//     Get.to(
//       () => SecondScreen(
//         text: textToSend,
//       ),
//     );
//   }
// }
