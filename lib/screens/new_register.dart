import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'business_register.dart';

class new_registration extends StatelessWidget {
  const new_registration({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white10,
      body: Column(
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
                    curve: Curves.easeOutExpo, // tab animation curves
                    gap: 8, // the tab button gap between icon and text
                    color: Colors.grey[800], // unselected icon color
                    activeColor: Colors.black, // selected icon and text color
                    iconSize: 35, // tab button icon size
                    tabBackgroundColor: Colors.grey
                        .withOpacity(0.1), // selected tab background color
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 5), // navigation bar padding
                    tabs: [
                      GButton(
                        icon: Icons.arrow_left,
                        text: 'Login',
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      )
                    ]),
              ),
            ],
          ),
          Expanded(
            child: Row(
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
                Expanded(child: RegistrationWidget()),
              ],
            ),
          ),
          const SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }
}
