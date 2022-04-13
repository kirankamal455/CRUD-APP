import 'package:crud_app_flutter/database/database_functions.dart';
import 'package:crud_app_flutter/model/data_model.dart';
import 'package:flutter/material.dart';

int k = 0;
bool chekid = false;
final TextEditingController _nameController = TextEditingController();
final TextEditingController _ageController = TextEditingController();
final TextEditingController _rollnoController = TextEditingController();

class BottomUpSheet {
  int? id;
  final String? name;
  final String? age;
  final String? rollno;
  final BuildContext context;
  final bool? checkid;

  BottomUpSheet({
    this.name,
    this.id,
    this.checkid,
    this.age,
    this.rollno,
    required this.context,
  });

// This function will be working  when the floating button is pressed
// It will also be working when you want to update an student
  void studentsDetailsForm() async {
    // if checkid != true -> create new student
    //  if  id == true -> update an existing student
    if (checkid != true) {
      _nameController.text = name!;
      _ageController.text = age!;
      _rollnoController.text = rollno!;
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
                    height: 10,
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
                          _updateStudentDetails(id!); //null check rewrited
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

  Future<void> addStudentButtonClicked() async {
    final _name = _nameController.text.trim();
    final _age = _ageController.text.trim();
    final _rollno = _rollnoController.text.trim();
    int? id;

    if (_name.isEmpty || _age.isEmpty || _rollno.isEmpty) {
      k = 1;
      return;
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
}
