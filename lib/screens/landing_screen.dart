import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:page_transition/page_transition.dart';
import 'package:securing_documents/screens/top_nav.dart';
import 'package:securing_documents/screens/user_dash.dart';
import '../admin/screens/admin_dash_screen.dart';
import '../services/auth_services.dart';
import '../services/database_services.dart';
import 'login_screen.dart';
import 'new_register.dart';

class DashBar extends StatefulWidget {
  @override
  State<DashBar> createState() => _DashBarState();
}

class _DashBarState extends State<DashBar> {
  TextEditingController emailAddressController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool passwordVisibility = false;
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _authServices = AuthServices();
  final _db = DatabaseServices();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    emailAddressController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  signIn() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      _authServices
          .signInWithEmail(emailAddressController.text, passwordController.text)
          .then((credentials) {
        try {
          String uid = credentials.user!.uid;
          _db.validateUser(uid).then((value) {
            if (value["admin"]) {
              Navigator.pushAndRemoveUntil(
                  context,
                  PageTransition(
                    type: PageTransitionType.scale,
                    alignment: Alignment.center,
                    duration: const Duration(milliseconds: 500),
                    child: const AdminDashScreen(),
                  ),
                  (route) => false);
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Admin User Logged in")));
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("User logged in.")));
              Navigator.pushAndRemoveUntil(
                  context,
                  PageTransition(
                    type: PageTransitionType.scale,
                    alignment: Alignment.center,
                    duration: const Duration(milliseconds: 500),
                    child: const user_dash(),
                  ),
                  (route) => false);
            }
            setState(() {
              _isLoading = false;
            });
          }).catchError((e) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text("Error :- $e")));
            setState(() {
              _isLoading = false;
            });
          });
        } catch (e) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("User not exists")));
          setState(() {
            _isLoading = false;
          });
        }
      }).catchError((e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Error:-$e")));
        setState(() {
          _isLoading = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController pageController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.white10,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.all(20),
                  child: Row(children: const <Widget>[
                    Icon(
                      Icons.business,
                      size: 35,
                    ),
                    Text("  Business Manager",
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.black45,
                        ))
                  ]),
                ),

                Container(
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.all(20),
                  child: GNav(
                      rippleColor: Colors.black45, // tab button ripple color when pressed
                      haptic: true, // haptic feedback
                      curve: Curves.easeOutExpo, // tab animation curves
                      // duration:
                      // const Duration(milliseconds: 100),
                      gap: 8, // the tab button gap between icon and text
                      color: Colors.grey[800], // unselected icon color
                      activeColor: Colors
                          .black, // selected icon and text color
                      iconSize: 35, // tab button icon size
                      tabBackgroundColor: Colors.grey
                          .withOpacity(0.1), // selected tab background color
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 5), // navigation bar padding
                      tabs:  [

                        GButton(
                          icon: Icons.arrow_right,
                          text: 'Register',
                          onPressed: (){
                            Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                const new_registration()),
                          );},
                        )
                      ]),
                ),
              ],
            ),
            Row(
              children: [

                Expanded(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: Image.asset(
                      'assets/images/12345.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const Expanded(child: LoginScreen()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
