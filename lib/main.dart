import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:securing_documents/admin/screens/admin_dash_screen.dart';
import 'package:securing_documents/firebase_options.dart';
import 'package:securing_documents/screens/top_nav.dart';
import 'package:securing_documents/screens/login_screen.dart';
import 'package:securing_documents/screens/requestDocumentScreen.dart';
import 'package:securing_documents/screens/splash_screen.dart';
import 'screens/business_register.dart';

import 'screens/top_nav.dart';
import 'screens/dash.dart';
import 'screens/temp.dart';
import 'screens/new_register.dart';

import 'screens/user_dash.dart';
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
  bool isLoading = true;
  String user = "false";

  @override
  void initState() {
    super.initState();
    _auth.isUserLoggedIn(context).then((value) {
      if ((value["message"] as String).isNotEmpty) {
        widget.err = value["message"];
      }
      setState(() {
        isLoading = false;
        user = value["role"];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
        return MaterialApp(
      home: isLoading
          ? Scaffold(
              body: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    CircularProgressIndicator(),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      "Loading...",
                      style: TextStyle(fontSize: 22.0),
                    ),
                  ],
                ),
              ),
            )
          : user == "false"
              ? DashBar()
              : user == "admin"
                  ? AdminDashScreen()
                  : user_dash(),
      debugShowCheckedModeBanner: false,
    );
  }
}
