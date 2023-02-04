import 'package:flutter/material.dart';


class progress_tracker extends StatefulWidget {
  @override
  _progress_tracker createState() => _progress_tracker();
}

class _progress_tracker extends State<progress_tracker> {
  final double _progressValue = 4.0;


  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width * 0.4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20.0),
              child: LinearProgressIndicator(
                backgroundColor: Colors.grey,
                color: Colors.lightBlueAccent,
                value: _progressValue*0.01,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text('Progress: ${(_progressValue * 1).round()}%'),
            ),


            // Padding(
            //   padding: EdgeInsets.all(20.0),
            //   child: ElevatedButton(
            //     onPressed: () {
            //       setState(() {
            //         _progressValue += 0.1;
            //         if (_progressValue > 1.0) {
            //           _progressValue = 0.0;
            //         }
            //       });
            //     },
            //     child: Text('Update Progress'),
            //   ),
            // ),
          ],
        ),
      );

  }
}