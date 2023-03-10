
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:securing_documents/admin/screens/admin_dash_screen.dart';
import 'package:securing_documents/screens/new_register.dart';
import 'package:securing_documents/screens/user_dash.dart';
import '../services/auth_services.dart';
import '../services/database_services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
    return Column(
      children: [
        Container(
          // width: double.infinity,
          height: 400,
          decoration: const BoxDecoration(
            color: Color(0xFFFFFFFF),
            boxShadow: [
              // BoxShadow(
              //   blurRadius: 7,
              //   color: Color(0x4D090F13),
              //   offset: Offset(0, 3),
              // )
            ],
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(16),
              bottomRight: Radius.circular(16),
              topLeft: Radius.circular(0),
              topRight: Radius.circular(0),
            ),
          ),
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
                    padding: EdgeInsetsDirectional.fromSTEB(0, 56, 0, 0),
                  ),
                  Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 4),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome Back,',
                          style: GoogleFonts.urbanist(
                            color: const Color(0xFF14181B),
                            fontWeight: FontWeight.w600,
                            fontSize: 24,
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
                              controller: emailAddressController,
                              validator: (value) {
                                return value != null
                                    ? RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                            .hasMatch(value)
                                        ? null
                                        : "Enter valid email"
                                    : "Email required";
                              },
                              obscureText: false,
                              decoration: InputDecoration(
                                labelText: 'Email Address',
                                labelStyle: GoogleFonts.urbanist(
                                  color: const Color(0xFF95A1AC),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                                hintText: 'Enter your email here...',
                                hintStyle: GoogleFonts.urbanist(
                                  color: const Color(0xFF95A1AC),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color(0xFFE1EDF9),
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color(0xFFE1EDF9),
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color(0x00000000),
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color(0x00000000),
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                filled: true,
                                fillColor: const Color(0xFFFFFFFF),
                                contentPadding:
                                    const EdgeInsetsDirectional.fromSTEB(
                                        16, 24, 0, 24),
                              ),
                              style: GoogleFonts.urbanist(
                                color: const Color(0xFF14181B),
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              )),
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
                            controller: passwordController,
                            validator: (value) {
                              return value != null
                                  ? value.length >= 6
                                      ? null
                                      : value.isEmpty
                                          ? "Enter Password"
                                          : "Minimum password length is 6"
                                  : "Enter Password";
                            },
                            obscureText: !passwordVisibility,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              labelStyle: GoogleFonts.urbanist(
                                color: const Color(0xFF95A1AC),
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                              hintText: 'Enter your password here...',
                              hintStyle: GoogleFonts.urbanist(
                                color: const Color(0xFF95A1AC),
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color(0xFFE1EDF9),
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color(0xFFE1EDF9),
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color(0x00000000),
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color(0x00000000),
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              filled: true,
                              fillColor: const Color(0xFFFFFFFF),
                              contentPadding:
                                  const EdgeInsetsDirectional.fromSTEB(
                                      16, 24, 24, 24),
                              suffixIcon: InkWell(
                                onTap: () => setState(
                                  () => passwordVisibility =
                                      !passwordVisibility,
                                ),
                                focusNode: FocusNode(skipTraversal: true),
                                child: Icon(
                                  passwordVisibility
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                  color: const Color(0xFF95A1AC),
                                  size: 22,
                                ),
                              ),
                            ),
                            style: GoogleFonts.urbanist(
                              color: const Color(0xFF14181B),
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
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
                            // await Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) =>
                            //         ForgotPasswordWidget(),
                            //   ),
                            // );
                          },
                          style: TextButton.styleFrom(
                            fixedSize: const Size(170, 30),
                            textStyle: GoogleFonts.lexend(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF14181B),
                            ),
                            elevation: 0,
                          ),
                          child: const Text(
                            'Forgot Password?',
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
                                    signIn();
                                  },
                                  style: ElevatedButton.styleFrom(
                                      shape: const StadiumBorder(),
                                      backgroundColor:
                                          const Color(0xFF4B39EF)),
                                  child: const Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        25, 12, 25, 12),
                                    child: FittedBox(
                                      child: Text(
                                        'Login',
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white70,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an Account?"),
                      TextButton(
                        style: TextButton.styleFrom(
                          textStyle: const TextStyle(fontSize: 16),
                        ),
                        onPressed: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => new_registration(),
                            ),
                          );
                        },

                        child: const Text('Create Account'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
