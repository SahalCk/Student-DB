import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_db/db/providers/student_provider.dart';
import 'package:student_db/db/providers/temp_image_provider.dart';

import '../db/model/student_model.dart';

// ignore: must_be_immutable
class EditStudent extends StatefulWidget {
  int index;
  EditStudent({super.key, required this.index});

  @override
  State<EditStudent> createState() => _EditStudentState();
}

class _EditStudentState extends State<EditStudent> {
  TextEditingController _namecontroller = TextEditingController();

  TextEditingController _agecontroller = TextEditingController();

  TextEditingController _phonecontroller = TextEditingController();

  TextEditingController _markcontroller = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    final studentProvider =
        Provider.of<StudentProvider>(context, listen: false);

    String name = studentProvider.students[widget.index].name;
    _namecontroller = TextEditingController(text: name);
    String age = studentProvider.students[widget.index].age;
    _agecontroller = TextEditingController(text: age);
    String phone = studentProvider.students[widget.index].number;
    _phonecontroller = TextEditingController(text: phone);
    String mark = studentProvider.students[widget.index].mark;
    _markcontroller = TextEditingController(text: mark);
    String profile = studentProvider.students[widget.index].profpic;
    final tempImageProvider =
        Provider.of<TempImageProvider>(context, listen: false);
    tempImageProvider.tempImagePath = profile;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_namecontroller.text),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Consumer<TempImageProvider>(
                        builder: (context, value2, child) {
                      return Column(
                        children: [
                          Align(
                              alignment: Alignment.topCenter,
                              child: value2.tempImagePath == null
                                  ? const CircleAvatar(
                                      backgroundImage: AssetImage(
                                          'assets/images/gallery.png'),
                                      radius: 65,
                                    )
                                  : CircleAvatar(
                                      radius: 65,
                                      backgroundImage: FileImage(
                                        File(value2.tempImagePath!),
                                      ),
                                    )),
                          const SizedBox(
                            height: 10,
                          ),
                          ElevatedButton.icon(
                              onPressed: () {
                                getImage(value2);
                              },
                              icon: const Icon(Icons.photo),
                              label: const Text("Add Photo")),
                        ],
                      );
                    }),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      controller: _namecontroller,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                          label: Text("Student's Name"),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          prefixIcon: Icon(Icons.person)),
                      validator: (value) {
                        if (_namecontroller.text.isEmpty) {
                          return 'Name Field is Empty';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      controller: _agecontroller,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          label: Text("Student's Age"),
                          prefixIcon: Icon(Icons.star)),
                      validator: (value) {
                        if (_agecontroller.text.isEmpty) {
                          return 'Age Field is Empty';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      controller: _phonecontroller,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          label: Text("Guardian's Phone"),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          prefixIcon: Icon(Icons.phone)),
                      maxLength: 10,
                      validator: (value) {
                        if (_phonecontroller.text.isEmpty) {
                          return 'Phone Field is Empty';
                        } else if (_phonecontroller.text.length < 10) {
                          return 'Enter a valid Phone number';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      controller: _markcontroller,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          label: Text("Total Mark"),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          prefixIcon: Icon(Icons.score)),
                      validator: (value) {
                        if (_markcontroller.text.isEmpty) {
                          return 'Total Mark Field is Empty';
                        } else if (int.parse(_markcontroller.text) > 100) {
                          return 'Enter a valid Mark';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                                fixedSize: const Size(130, 50),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                backgroundColor: Colors.red),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: const Icon(Icons.cancel),
                            label: const Text("Cancel")),
                        ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                                fixedSize: const Size(130, 50),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                backgroundColor: Colors.green[600]),
                            onPressed: () {
                              final tempImageProvider =
                                  Provider.of<TempImageProvider>(context,
                                      listen: false);
                              if (_formKey.currentState!.validate()) {
                                if (tempImageProvider.tempImagePath == null) {
                                  addingFailed();
                                } else {
                                  updateSuccess(widget.index);
                                }
                              }
                            },
                            icon: const Icon(Icons.send),
                            label: const Text("Submit")),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void getImage(TempImageProvider value) async {
    await value.getImage();
  }

  void addingFailed() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Please add the pofile picture!"),
      backgroundColor: Colors.red,
      margin: EdgeInsets.all(10),
      behavior: SnackBarBehavior.floating,
      showCloseIcon: true,
      closeIconColor: Colors.white,
      duration: Duration(seconds: 2),
    ));
  }

  void updateSuccess(int index) {
    final value = Provider.of<StudentProvider>(context, listen: false);
    final value2 = Provider.of<TempImageProvider>(context, listen: false);
    Student st = Student(
        name: _namecontroller.text.trim(),
        age: _agecontroller.text.trim(),
        number: _phonecontroller.text.trim(),
        mark: _markcontroller.text.trim(),
        profpic: value2.tempImagePath!);
    value.editStudent(index, st);
    value2.tempImagePath = null;
    value2.notify();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("${_namecontroller.text}'s details edittted successfully!"),
      backgroundColor: Colors.green,
      margin: const EdgeInsets.all(10),
      behavior: SnackBarBehavior.floating,
      showCloseIcon: true,
      closeIconColor: Colors.white,
      duration: const Duration(seconds: 2),
    ));
    value2.tempImagePath = null;
    Navigator.of(context).pop();
  }
}
