import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../services/auth_services.dart';
import 'user_dash.dart';

class AdminDrawer extends StatelessWidget {

  const AdminDrawer({super.key, });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
      return Container(
        child: Drawer(
          child: SingleChildScrollView(
            child: Column(
              children: [
                 UserAccountsDrawerHeader(
                  decoration: const BoxDecoration(
                    color: Color(0x06000000),
                  ),
                  accountName:  Text(
                    "Welcome User",
                      style: GoogleFonts.urbanist(
                        color:  const Color(0xFF14181B),
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                  ),
                  // accountEmail: Text(
                  //   _auth.getEmail(),
                  //   style: const TextStyle(color: Colors.black),
                  // ),
                  otherAccountsPictures: [
                    // CircleAvatar(
                    //   child: Padding(
                    //     padding: const EdgeInsets.all(8.0),
                    //     child: Text("Other User", style: TextStyle(fontSize: 10.0)),
                    //   ),
                    // ),
                    IconButton(
                        onPressed: () {
                          AuthServices().signOutUser(context);
                        },
                        icon: const Icon(
                          CupertinoIcons.square_arrow_right,
                          color: Colors.red,
                        )),
                  ],
                  currentAccountPicture: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100.0),
                        border: Border.all(color: const Color(0x21000000))),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100.0),
                      child: Image.asset(
                        "assets/images/12345.png",
                        width: 100.0,
                        height: 100.0,
                        // fit: BoxFit.cover,
                      ),
                    ),
                  ), accountEmail: Text("user@gmail.com",style: GoogleFonts.urbanist(
        color:  const Color(0xFF14181B),
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),),
                ),
                ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                          const user_dash()),
                    );
                  },
                  title: const Text("Dashboard"),
                  leading: const Icon(Icons.dashboard_outlined),
                ),
                ListTile(
                  onTap: () {
                    //changeScreen(1, web, false);
                  },
                  title: const Text("Profile"),
                  leading: const Icon(Icons.category_outlined),
                ),
                ListTile(
                  onTap: () {
                    //changeScreen(2, web, false);
                  },
                  title: const Text("Documents"),
                  leading: const Icon(Icons.list_alt_outlined),
                ),
              ],
            ),
          ),

        ),
      );
  }
}
