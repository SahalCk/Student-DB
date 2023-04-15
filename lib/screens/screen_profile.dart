import 'dart:io';

import 'package:flutter/material.dart';
import 'package:student_db/db/function/db_functions.dart';

import 'edit_student.dart';

class ProfileScreen extends StatelessWidget {
  int index;
  ProfileScreen({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Profile of ${students.value[index].name}'),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 80,
                      width: 100,
                      child: Image.network(
                          'https://i.pinimg.com/originals/09/29/1f/09291f53e8d07c54e117c3abbf704f35.png'),
                    ),
                    FittedBox(
                      child: Card(
                        shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.greenAccent),
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: ValueListenableBuilder(
                            valueListenable: students,
                            builder: (context, value, child) {
                              return Column(
                                children: [
                                  CircleAvatar(
                                    backgroundImage: FileImage(
                                        File(students.value[index].profpic)),
                                    radius: 65,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 150,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: 30,
                                            ),
                                            Text(
                                              "Student's Name",
                                              style: TextStyle(fontSize: 17),
                                            ),
                                            SizedBox(
                                              height: 30,
                                            ),
                                            Text(
                                              "Student's Age",
                                              style: TextStyle(fontSize: 17),
                                            ),
                                            SizedBox(
                                              height: 30,
                                            ),
                                            Text("Guardian's Phone",
                                                style: TextStyle(fontSize: 17)),
                                            SizedBox(
                                              height: 30,
                                            ),
                                            Text("Total Mark",
                                                style: TextStyle(fontSize: 17)),
                                          ],
                                        ),
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 30,
                                          ),
                                          Text(
                                            ":",
                                            style: TextStyle(fontSize: 17),
                                          ),
                                          SizedBox(
                                            height: 30,
                                          ),
                                          Text(
                                            ":",
                                            style: TextStyle(fontSize: 17),
                                          ),
                                          SizedBox(
                                            height: 30,
                                          ),
                                          Text(":",
                                              style: TextStyle(fontSize: 17)),
                                          SizedBox(
                                            height: 30,
                                          ),
                                          Text(":",
                                              style: TextStyle(fontSize: 17)),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 150,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: 30,
                                            ),
                                            Text(
                                              students.value[index].name,
                                              style: TextStyle(fontSize: 17),
                                            ),
                                            SizedBox(
                                              height: 30,
                                            ),
                                            Text(
                                              students.value[index].age,
                                              style: TextStyle(fontSize: 17),
                                            ),
                                            SizedBox(
                                              height: 30,
                                            ),
                                            Text(students.value[index].number,
                                                style: TextStyle(fontSize: 17)),
                                            SizedBox(
                                              height: 30,
                                            ),
                                            Text(students.value[index].mark,
                                                style: TextStyle(fontSize: 17)),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue[800]),
                        onPressed: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return EditStudent(index: index);
                          }));
                        },
                        icon: Icon(Icons.edit),
                        label: Text("Edit Proile"))
                  ]),
            ),
          ),
        ));
  }
}
