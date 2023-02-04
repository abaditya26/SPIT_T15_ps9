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
    return MaterialApp(
      home: Scaffold(
        body: Row(
          children: [
            Container(
              child: AdminDrawer(),
            ),
            Expanded(
              child: Column(
                children: [
                  Container(
                    child: DashboardScreen(),
                  ),
                  Container(
                    margin: EdgeInsets.all(20),
                    padding: EdgeInsets.all(20),
                    child: Row(
                      children: const [
                        SizedBox(width: 30,),
                        TransparentImageCard(
                            width: 250,
                            imageProvider:
                                AssetImage('assets/images/12345.png'),
                            tags: [Text('Product')],
                            title: Text(
                              'tmep',
                              style: TextStyle(color: Colors.white),
                            ),
                            ),
                        SizedBox(width: 30,),
                        TransparentImageCard(
                            width: 250,
                            imageProvider:
                                AssetImage('assets/images/12345.png'),
                            tags: [Text('Product')],
                            title: Text(
                              'Request Certification',
                              style: TextStyle(color: Colors.white),
                            ),
                            ),
                        SizedBox(width: 30,),
                        TransparentImageCard(
                            width: 250,
                            imageProvider:
                                AssetImage('assets/images/12345.png'),
                            tags: [Text('Product')],
                            title: Text(
                              'Check Transaction History',
                              style: TextStyle(color: Colors.white),
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
      ),
    );
  }

  title({required Color color}) {}
}
