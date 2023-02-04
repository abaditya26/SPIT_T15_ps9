import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:securing_documents/admin/admin_dash_screen.dart';
import 'package:securing_documents/firebase_options.dart';
import 'package:securing_documents/screens/dashboard_screen.dart';
import 'package:securing_documents/screens/login_screen.dart';
import 'package:securing_documents/screens/splash_screen.dart';
import 'screens/business_register.dart';

// Future<void> main() async {
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: DashboardScreen(),
//     );
//   }
// }


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
      home: user == "false"
          ? LoginScreen(
      )
          : user == "admin"
          ? AdminDashScreen()
          : DashboardScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

