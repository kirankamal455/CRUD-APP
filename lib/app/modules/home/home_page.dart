import 'package:crud_app_flutter/app/core/values/colors.dart';
import 'package:crud_app_flutter/app/data/model/data_model.dart';
import 'package:crud_app_flutter/app/data/provider/database/database_functions.dart';
import 'package:crud_app_flutter/app/data/provider/firebase/user_authentication.dart';
import 'package:crud_app_flutter/app/global/widgets/bottom_sheet.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Students Details',
          style: TextStyle(color: Colors.black),
        ),
        automaticallyImplyLeading: false,
        elevation: 5,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              signOutUser(context);
            },
          ),
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: studentListNotifier,
        builder:
            (BuildContext context, List<StudentModel> students, Widget? child) {
          return ListView.builder(
              itemCount: students.length,
              itemBuilder: (context, index) {
                final data = students[index];
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(
                      color: Colors.grey.withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                  color: const Color.fromARGB(252, 252, 252, 255),
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    leading: const Icon(
                      Icons.account_circle_rounded,
                      size: 45,
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data.name,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Age:' + data.age,
                        ),
                        Text('RollNo:' + data.rollno),
                      ],
                    ),
                    trailing: SizedBox(
                      width: 100,
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.yellow),
                            onPressed: () {
                              final details = BottomUpSheet(
                                  id: data.id,
                                  name: data.name,
                                  age: data.age,
                                  rollno: data.rollno,
                                  context: context);

                              details.studentsDetailsForm();
                            },
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              int? a = data.id;
                              deleteStudent(a!);
                              Get.rawSnackbar(
                                message: 'Successfully deleted a Student',
                                backgroundColor: red,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              });
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          final detailsForm =
              BottomUpSheet(context: context, dataIsAvailable: true);
          detailsForm.studentsDetailsForm();
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      backgroundColor: lightyellow,
    );
  }
}
