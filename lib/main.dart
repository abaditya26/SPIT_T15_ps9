import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:securing_documents/admin/admin_dash_screen.dart';
import 'package:securing_documents/firebase_options.dart';
import 'package:securing_documents/screens/dash.dart';
import 'package:securing_documents/screens/dashboard_screen.dart';
import 'package:securing_documents/screens/login_screen.dart';
import 'package:securing_documents/screens/splash_screen.dart';
import 'screens/business_register.dart';
import 'screens/dashboard_screen.dart';
import 'screens/dash.dart';
import 'screens/temp.dart';
import 'screens/new_register.dart';

import 'services/auth_services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  String? err;

  MainApp({super.key, this.err});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final _auth = AuthServices();
  String user = "false";

  @override
  void initState() {
    super.initState();
    _auth.isUserLoggedIn(context).then((value) {
      if ((value["message"] as String).isNotEmpty) {
        widget.err = value["message"];
      }
      setState(() {
        user = value["role"];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new_registration(),
      // home: user == "false"
      //     ? DashBar(
      // )
      //     : user == "admin"
      //     ? AdminDashScreen()
      //     : DashboardScreen(),
      // debugShowCheckedModeBanner: false,
      // theme: ThemeData(
      //   primarySwatch: Colors.blue,
      // ),
    );
  }
}

