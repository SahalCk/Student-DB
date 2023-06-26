import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:student_db/db/model/student_model.dart';
import 'package:student_db/db/providers/student_provider.dart';
import 'package:student_db/db/providers/temp_image_provider.dart';
import 'package:student_db/screens/screen_home.dart';

Future<void> main() async {
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(StudentAdapter().typeId)) {
    Hive.registerAdapter(StudentAdapter());
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => StudentProvider()),
        ChangeNotifierProvider(create: (context) => TempImageProvider())
      ],
      child: MaterialApp(
        theme: ThemeData(primarySwatch: Colors.teal),
        home: const HomeScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
