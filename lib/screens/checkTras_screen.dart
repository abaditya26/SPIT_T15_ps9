import 'package:flutter/material.dart';
import 'package:image_card/image_card.dart';
import 'package:securing_documents/screens/side_nav.dart';
import 'package:securing_documents/screens/top_nav.dart';

import 'doc_details_widget.dart';

class CheckTransScreen extends StatefulWidget {
  const CheckTransScreen({Key? key}) : super(key: key);

  @override
  State<CheckTransScreen> createState() => _CheckTransScreenState();
}

class _CheckTransScreenState extends State<CheckTransScreen> {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: Scaffold(
        body: Row(
          children: [
            Container(
              child: const AdminDrawer(page: "transactions",),
            ),
            Expanded(
              child: Column(
                children: [
                  Container(
                    child: DashboardScreen(),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: CertificateStatus(),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
