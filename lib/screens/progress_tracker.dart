import 'package:flutter/material.dart';


class progress_tracker extends StatelessWidget {
  final double progressValue;

  const progress_tracker({super.key, required this.progressValue});

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
                value: progressValue*0.01,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text('Progress: ${(progressValue * 1).round()}%'),
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