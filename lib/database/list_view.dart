import 'package:crud_app_flutter/Firebase_user_Login/Login_Screen_1.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:crud_app_flutter/database/sql_functions/database_functions.dart';
import 'package:flutter/material.dart';

import '../data_model/data_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int k = 0;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _rollnoController = TextEditingController();
  // This function will be working  when the floating button is pressed
  // It will also be working when you want to update an student
  void _studentsDetailsForm(int? id, var name, var age, var rollno) async {
    // if id == null -> create new student
    //  if  id != null -> update an existing student
    if (id != null || name != null || age != null || rollno != null) {
      _nameController.text = name;
      _ageController.text = age;
      _rollnoController.text = rollno;
    }
    showModalBottomSheet(
        context: context,
        elevation: 5,
        isScrollControlled: true,
        builder: (context) => Container(
              padding: EdgeInsets.only(
                top: 15,
                left: 15,
                right: 15,
                // this will prevent the soft keyboard from covering the text fields
                bottom: MediaQuery.of(context).viewInsets.bottom + 50,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(hintText: 'Student Name'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _ageController,
                    decoration: const InputDecoration(hintText: 'Age'),
                  ),
                  TextFormField(
                    controller: _rollnoController,
                    decoration: const InputDecoration(hintText: 'Roll No'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        // Save Student

                        if (id == null) {
                          await addStudentButtonClicked();
                          if (k == 0) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Successfully Added a Student'),
                                  backgroundColor: Colors.blue),
                            );
                          }
                        }

                        if (id != null) {
                          _updateStudentDetails(id);
                        }

                        // Clear the text fields
                        _nameController.text = '';
                        _ageController.text = '';
                        _rollnoController.text = '';

                        // Close the bottom sheet
                        Navigator.of(context).pop();
                      },
                      child: Text(id == null
                          ? 'Add Student'
                          : 'Update student Details'),
                    ),
                  )
                ],
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Students Details',
        ),
        automaticallyImplyLeading: false,
        elevation: 5,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              signOut(context);
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
                      )),
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
                        Text(data.name,
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
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
                            icon: const Icon(Icons.edit, color: Colors.blue),
                            onPressed: () => _studentsDetailsForm(
                                data.id, data.name, data.age, data.rollno),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              int? a = data.id;
                              deleteStudent(a!);
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          'Successfully deleted a Student'),
                                      backgroundColor: Colors.red));
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
        onPressed: () => _studentsDetailsForm(null, null, null, null),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      backgroundColor: const Color.fromARGB(255, 242, 243, 248),
    );
  }

  Future<void> addStudentButtonClicked() async {
    final _name = _nameController.text.trim();
    final _age = _ageController.text.trim();
    final _rollno = _rollnoController.text.trim();
    int? id;

    if (_name.isEmpty || _age.isEmpty || _rollno.isEmpty) {
      k = 1;
      return print('Please provide the details');
    }
    final _studentdata =
        StudentModel(id: id, name: _name, age: _age, rollno: _rollno);
    addStudent(_studentdata);
  }

  Future<void> _updateStudentDetails(int id) async {
    await updateStudent(
        id, _nameController.text, _ageController.text, _rollnoController.text);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
          content: Text('Successfully updated a Student'),
          backgroundColor: Colors.blue),
    );
    getAllStudentsDetails();
  }

  signOut(BuildContext ctx) {
    FirebaseAuth.instance.signOut().then((value) => Navigator.of(context)
        .pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const LoginScreen()),
            (Route<dynamic> route) => false));
  }
}
