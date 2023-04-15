import 'dart:io';

import 'package:flutter/material.dart';
import 'package:student_db/db/function/db_functions.dart';
import 'package:student_db/db/model/student_model.dart';
import '../screens/screen_profile.dart';

class Search extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: ValueListenableBuilder(
        valueListenable: students,
        builder:
            (BuildContext context, List<Student> studentlist, Widget? child) {
          return ListView.builder(
              itemBuilder: (context, index) {
                final data = studentlist[index];
                if (data.name
                    .toLowerCase()
                    .contains(query.toLowerCase().trim())) {
                  return Column(
                    children: [
                      ListTile(
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
                          backgroundImage: FileImage(
                            File(data.profpic),
                          ),
                        ),
                        title: Text(data.name, style: TextStyle(fontSize: 20)),
                      ),
                      const Divider()
                    ],
                  );
                } else {
                  return const Text('');
                }
              },
              itemCount: studentlist.length);
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: ListView.separated(
          itemBuilder: (context, index) {
            return Expanded(
              child: ListTile(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                    return ProfileScreen(
                      index: index,
                    );
                  }));
                },
                leading: CircleAvatar(
                    radius: 40,
                    backgroundImage:
                        FileImage(File(students.value[index].profpic))),
                title: Text(students.value[index].name,
                    style: TextStyle(fontSize: 20)),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return const Divider();
          },
          itemCount: students.value.length),
    );
  }
}
