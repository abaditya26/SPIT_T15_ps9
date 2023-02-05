import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:securing_documents/models/user_model.dart';
import 'package:securing_documents/screens/landing_screen.dart';
import 'package:securing_documents/screens/top_nav.dart';
import 'package:securing_documents/screens/login_screen.dart';
import 'package:securing_documents/screens/user_dash.dart';
import 'package:securing_documents/services/database_services.dart';
import '../services/auth_services.dart';
import 'form_components.dart';
import 'dropdowntype.dart';

class RegistrationWidget extends StatefulWidget {
  // String? errMessage;

  RegistrationWidget({
    super.key,
    // this.errMessage
  });

  @override
  _RegistrationWidget createState() => _RegistrationWidget();
}

class _RegistrationWidget extends State<RegistrationWidget> {
  TextEditingController emailAddressController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _auth = AuthServices();
  final _db = DatabaseServices();
  bool passwordVisibility = false;
  String phone = "";
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String? b_size;
  String selectedType = 'Select Type';

  List<String> list = [
    "Select Type",
    "GST Registration",
    "FSSAI Registration",
    "Shop and Establishment License",
    "Factory License",
    "MSME Registration",
    "Merchandise Business",
    "Non Profit Organization"
  ];
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    emailAddressController.dispose();
    contactController.dispose();
    nameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future signUp() async {
    setState(() {
      _isLoading = true;
    });
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddressController.text, password: passwordController.text);
    // add user details
    addUser();
  }

  addUser() {
    final userModel = UserModel(
      uid: _auth.getUid(),
      email: emailAddressController.text,
      type: selectedType,
      name: nameController.text,
      contactNo: contactController.text,
      address: addressController.text,
    );
    _db.addUserData(userModel).then((value) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("SignUp Successful")));
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const user_dash()),
          (route) => false);
    }).catchError((e) {
      print(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   key: scaffoldKey,
    //   backgroundColor: const Color(0xFFFFFFFF),
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Text('Business',
            //     style: GoogleFonts.dancingScript(
            //         color: Colors.lightBlue, fontSize: 55.0)),
            // Text('Manager',
            //     style: GoogleFonts.dancingScript(
            //         color: Colors.lightBlue, fontSize: 55.0)),
            Container(
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                      ),

                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: TextFormField(
                                autofocus: true,
                                controller: nameController,
                                validator: (value) {
                                  return value != null
                                      ? RegExp(r"^[\\p{L} .'-]+$")
                                              .hasMatch(value)
                                          ? null
                                          : "Enter valid Name"
                                      : "Name required";
                                },
                                obscureText: false,
                                decoration: inputDecoration(
                                    labelText: 'Business Name',
                                    hintText: 'Enter business name here...'),
                                style: textStyle(),
                              ),
                            ),
                          ],
                        ),
                      ),

                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: TextFormField(
                                autofocus: true,
                                controller: contactController,
                                validator: (value) {
                                  return value != null
                                      ? RegExp(r"^[6-9]\d{9}$").hasMatch(value)
                                          ? null
                                          : "Enter valid contact"
                                      : "Contact required";
                                },
                                obscureText: false,
                                decoration: inputDecoration(
                                    labelText: 'Contact Number',
                                    hintText: 'Enter contact number here...'),
                                style: textStyle(),
                                onChanged: (value) {
                                  phone = value;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),

                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: TextFormField(
                                maxLines: 7,
                                autofocus: true,
                                controller: addressController,
                                validator: (value) {
                                  return value != null
                                      ? RegExp(r"^[\\p{L} .'-]+$")
                                              .hasMatch(value)
                                          ? null
                                          : "Enter valid Name"
                                      : "Name required";
                                },
                                obscureText: false,
                                decoration: inputDecoration(
                                    labelText: 'Business Address',
                                    hintText: 'Enter business address here...'),
                                style: textStyle(),
                              ),
                            ),
                          ],
                        ),
                      ),

                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: TextFormField(
                                autofocus: true,
                                controller: emailAddressController,
                                validator: (value) {
                                  return value != null
                                      ? RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                              .hasMatch(value)
                                          ? null
                                          : "Enter valid email"
                                      : "Email required";
                                },
                                obscureText: false,
                                decoration: inputDecoration(
                                    labelText: 'Company Email Address',
                                    hintText:
                                        'Enter company email address here...'),
                                style: textStyle(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: TextFormField(
                                autofocus: true,
                                controller: passwordController,
                                validator: (value) {
                                  return value != null
                                      ? RegExp(r"^.{8,}$").hasMatch(value)
                                          ? null
                                          : "Enter at-least 6 character password"
                                      : "Password required";
                                },
                                obscureText: true,
                                decoration: inputDecoration(
                                    labelText: 'Password',
                                    hintText: 'Enter password here...'),
                                style: textStyle(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(20, 20, 0, 10),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Type of Business: ",
                              style: textStyle(),
                              textAlign: TextAlign.left,
                            )
                          ],
                        ),
                      ),

                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: DropdownButtonFormField<String>(
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(
                                        width: 3, color: Color(0xFFF1F4F8)),
                                  ),
                                  prefixIcon: const Icon(Icons.business_sharp),
                                ),
                                validator: (value) {
                                  if (selectedType == 'Select Type')
                                    return 'Select your Company Type';
                                  return null;
                                },
                                value: selectedType,
                                items: list
                                    .map((item) => DropdownMenuItem<String>(
                                          value: item,
                                          child: Text(item,
                                              style: const TextStyle(
                                                  fontSize: 14)),
                                        ))
                                    .toList(),
                                onChanged: (item) => setState(
                                    () => selectedType = item ?? list[0]),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                              onPressed: () async {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DashBar()),
                                    (route) => false);
                              },
                              style: TextButton.styleFrom(
                                textStyle: GoogleFonts.lexend(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xFF14181B),
                                ),
                                elevation: 0,
                              ),
                              child: const Text(
                                'Already a user? Login',
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 0, 4, 0),
                              child: _isLoading
                                  ? const Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          25, 12, 25, 12),
                                      child: Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    )
                                  : ElevatedButton(
                                      onPressed: () {
                                        signUp();
                                      },
                                      style: ElevatedButton.styleFrom(
                                          shape: const StadiumBorder(),
                                          backgroundColor: Colors.lightBlue),
                                      child: const Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            25, 12, 25, 12),
                                        child: FittedBox(
                                          child: Text(
                                            'Sign Up',
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                            )
                          ],
                        ),
                      ),
                      // Text(widget.errMessage ?? ""),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
