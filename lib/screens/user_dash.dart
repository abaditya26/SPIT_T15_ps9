import 'package:securing_documents/screens/requestDocumentScreen.dart';

import 'checkTras_screen.dart';
import 'side_nav.dart';
import 'top_nav.dart';
import 'package:flutter/material.dart';
import 'package:image_card/image_card.dart';

class user_dash extends StatefulWidget {
  const user_dash({Key? key}) : super(key: key);

  @override
  State<user_dash> createState() => _user_dashState();
}

class _user_dashState extends State<user_dash> {
  @override
  Widget build(BuildContext context) {
    print("in");
    return Scaffold(
        body: Row(
          children: [
            Container(
              child: const AdminDrawer(page: "userDash"),
            ),
            Expanded(
              child: Column(
                children: [
                  Container(
                    child: AppBar(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      elevation: 0.0,
                      title: Text("Dashboard"),
                      centerTitle: true,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(20),
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 30,
                        ),
                        InkWell(
                          onTap: () {
                            //   Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) =>
                            //       const CheckTransScreen()),
                            // );
                          },
                          child: const TransparentImageCard(
                            width: 250,
                            imageProvider:
                                AssetImage('assets/images/documents.jpg'),
                            title: Text(
                              'Documents',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const RequestDocumentScreen()),
                            );
                          },
                          child: const TransparentImageCard(
                            width: 250,
                            imageProvider:
                                AssetImage('assets/images/request.jpg'),
                            title: Text(
                              'Request Certification',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const CheckTransScreen()),
                            );
                          },
                          child: const TransparentImageCard(
                            width: 250,
                            imageProvider:
                                AssetImage('assets/images/application.jpg'),
                            title: Text(
                              'Check Application History',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      );
  }

  title({required Color color}) {}
}
