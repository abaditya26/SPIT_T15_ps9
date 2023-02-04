import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:securing_documents/admin/admin_dash_screen.dart';
import 'package:securing_documents/firebase_options.dart';
import 'package:securing_documents/screens/dashboard_screen.dart';

Future<void> main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DashboardScreen(),
    );
  }
}
