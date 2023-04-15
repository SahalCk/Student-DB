import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_db/db/function/db_functions.dart';

import '../db/model/student_model.dart';

File? _image;

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
    String name = students.value[widget.index].name;
    _namecontroller = TextEditingController(text: name);
    String age = students.value[widget.index].age;
    _agecontroller = TextEditingController(text: age);
    String phone = students.value[widget.index].number;
    _phonecontroller = TextEditingController(text: phone);
    String mark = students.value[widget.index].mark;
    _markcontroller = TextEditingController(text: mark);
    String profile = students.value[widget.index].profpic;
    _image = File(profile);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit ${students.value[widget.index].name}"),
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
                    Align(
                        alignment: Alignment.topCenter,
                        child: _image?.path == null
                            ? const CircleAvatar(
                                backgroundImage:
                                    AssetImage('assets/images/gallery.png'),
                                radius: 65,
                              )
                            : CircleAvatar(
                                radius: 65,
                                backgroundImage: FileImage(
                                  File(_image!.path),
                                ),
                              )),
                    SizedBox(
                      height: 10,
                    ),
                    ElevatedButton.icon(
                        onPressed: () {
                          getImage();
                        },
                        icon: Icon(Icons.photo),
                        label: Text("Add Photo")),
                    SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      controller: _namecontroller,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          label: Text("Student's Name"),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          prefixIcon: Icon(Icons.person)),
                      validator: (value) {
                        if (_namecontroller.text.isEmpty) {
                          return 'Name Field is Empty';
                        }
                      },
                    ),
                    SizedBox(
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
                      },
                    ),
                    SizedBox(
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
                      },
                    ),
                    SizedBox(
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
                      },
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                                fixedSize: Size(130, 50),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                backgroundColor: Colors.red),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: Icon(Icons.cancel),
                            label: Text("Cancel")),
                        ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                                fixedSize: Size(130, 50),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                backgroundColor: Colors.green[600]),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                if (_image?.path == null) {
                                  addingFailed();
                                } else {
                                  updateSuccess(widget.index);
                                }
                              }
                            },
                            icon: Icon(Icons.send),
                            label: Text("Submit")),
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

  Future<void> getImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) {
      return;
    }

    final imageTemporary = File(image.path);

    setState(() {
      _image = imageTemporary;
    });
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
    Student st = Student(
        name: _namecontroller.text.trim(),
        age: _agecontroller.text.trim(),
        number: _phonecontroller.text.trim(),
        mark: _markcontroller.text.trim(),
        profpic: _image!.path);
    editStudent(index, st);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("${_namecontroller.text}'s details edittted successfully!"),
      backgroundColor: Colors.green,
      margin: EdgeInsets.all(10),
      behavior: SnackBarBehavior.floating,
      showCloseIcon: true,
      closeIconColor: Colors.white,
      duration: Duration(seconds: 2),
    ));
    _image = null;
    Navigator.of(context).pop();
  }
}