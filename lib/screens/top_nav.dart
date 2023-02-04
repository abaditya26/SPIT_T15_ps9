import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return
      SafeArea(
        child: Card(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children:  [
                Row(
                  children: [
                    IconButton(onPressed: (){}, icon: const Icon(Icons.settings), iconSize: 30,),
                    IconButton(onPressed: (){}, icon: const Icon(Icons.notifications_active), iconSize: 30,),
                    const Divider(color: Colors.black26,),
                    IconButton(onPressed: (){}, icon: const Icon(Icons.account_circle),iconSize: 30,),
                  ],
                ),
              ],
            ),
          ),
      );

  }
}
