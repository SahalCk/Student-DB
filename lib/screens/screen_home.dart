import 'dart:io';

import 'package:flutter/material.dart';
import 'package:student_db/db/function/db_functions.dart';
import 'package:student_db/screens/add_student.dart';
import 'package:student_db/screens/edit_student.dart';
import 'package:student_db/screens/screen_profile.dart';
import 'package:student_db/widgets/screen_search.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    getAllStudents();
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(onPressed: () {}, icon: Icon(Icons.home)),
          title: Text("Student List"),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  showSearch(context: context, delegate: Search());
                },
                icon: Icon(Icons.search))
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return AddStudentScreen();
            }));
          },
          label: Text(
            "Add Student",
            style: TextStyle(fontSize: 20),
          ),
          icon: Icon(
            Icons.add,
            size: 30,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: ValueListenableBuilder(
              valueListenable: students,
              builder: (context, studentlist, child) {
                return ListView.separated(
                    itemBuilder: (context, index) {
                      return Expanded(
                        child: ListTile(
                          onTap: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (ctx) {
                              return ProfileScreen(
                                index: index,
                              );
                            }));
                          },
                          leading: CircleAvatar(
                              radius: 40,
                              backgroundImage:
                                  FileImage(File(studentlist[index].profpic))),
                          title: Text(studentlist[index].name,
                              style: TextStyle(fontSize: 20)),
                          trailing: FittedBox(
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) {
                                      return EditStudent(index: index);
                                    }));
                                  },
                                  icon: Icon(Icons.edit),
                                  color: Colors.grey,
                                ),
                                IconButton(
                                  onPressed: () {
                                    showAlert(context, index);
                                  },
                                  icon: Icon(Icons.delete),
                                  color: Colors.red,
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const Divider();
                    },
                    itemCount: students.value.length);
              },
            ),
          ),
        ));
  }

  void showAlert(BuildContext context, int index) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Text('Do you want to delete ${students.value[index].name}'),
            content: const Text(
                'All the related datas will be cleared from the database'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: Text("No")),
              TextButton(
                  onPressed: () {
                    deleteStudent(index);
                    Navigator.of(ctx).pop();
                  },
                  child: Text("Yes"))
            ],
          );
        });
  }
}
