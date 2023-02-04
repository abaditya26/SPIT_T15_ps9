import 'package:flutter/material.dart';
import 'package:securing_documents/admin/screens/admin_dash_screen.dart';
import 'package:securing_documents/admin/screens/admin_requests_screen.dart';
import 'package:securing_documents/services/auth_services.dart';

class AdminCommonWidgets {
  AppBar adminAppBar(BuildContext context, String page) {
    return AppBar(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      elevation: 0.0,
      title: Row(
        children: const [
          Text("App Name Here"),
        ],
      ),
      actions: [
        getAppBarOptions(
            text: "Dashboard",
            color: Colors.black,
            icon: Icons.dashboard_outlined,
            onTap: () {
              if (page != "adminDash") {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AdminDashScreen()),
                    (route) => false);
              }
            }),
        getAppBarOptions(
            text: "Requests",
            color: Colors.black,
            icon: Icons.list,
            onTap: () {
              if (page != "adminRequests") {
                if (page == "adminViewRequest") {
                  Navigator.pop(context);
                } else {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AdminRequestsScreen()));
                }
              }
            }),
        getAppBarOptions(
            text: "Logout",
            color: Colors.red,
            icon: Icons.exit_to_app,
            onTap: () {
              //log out screen
              AuthServices().signOutUser(context);
            }),
      ],
    );
  }

  getAppBarOptions(
      {required String text,
      required Color color,
      required IconData icon,
      required void Function() onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 4.0,
          horizontal: 10.0,
        ),
        child: Row(
          children: [
            Icon(icon, color: color),
            const SizedBox(
              width: 10.0,
            ),
            Text(
              text,
              style: TextStyle(
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
