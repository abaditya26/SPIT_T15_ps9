import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

import 'business_register.dart';

class new_registration extends StatefulWidget {
  const new_registration({Key? key}) : super(key: key);

  @override
  State<new_registration> createState() => _new_registrationState();
}

class _new_registrationState extends State<new_registration> {
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
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.all(20),
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
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.all(20),
                child: GNav(
                    rippleColor: Colors
                        .black45, // tab button ripple color when pressed
                    haptic: true, // haptic feedback
                    tabBorderRadius: 15,
                    tabActiveBorder: Border.all(
                        color: Colors.grey, width: 1), // tab button border
                    curve: Curves.easeOutExpo, // tab animation curves
                    duration:
                    Duration(milliseconds: 200), // tab animation duration
                    gap: 8, // the tab button gap between icon and text
                    color: Colors.grey[800], // unselected icon color
                    activeColor: Colors
                        .lightBlueAccent, // selected icon and text color
                    iconSize: 35, // tab button icon size
                    tabBackgroundColor: Colors.lightBlueAccent
                        .withOpacity(0.1), // selected tab background color
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 5), // navigation bar padding
                    tabs: const [
                      GButton(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        icon: LineIcons.home,
                        text: 'Home',
                        padding: EdgeInsets.symmetric(horizontal: 10),
                      ),
                      GButton(
                        icon: Icons.arrow_left,
                        text: 'Revert',
                        style: GnavStyle.oldSchool,
                        margin: EdgeInsets.symmetric(horizontal: 10),
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
          SizedBox(height: 40,),
        ],
      ),
    );
  }
}
