import 'package:flutter/material.dart';

class AdminDashWidgets {
  DataRow getDashRequestRows() {
    return DataRow(
      cells: [
        DataCell(
          Text("1"),
        ),
        DataCell(
          Text("req_id"),
        ),
        DataCell(
          Text("user_name"),
        ),
        DataCell(
          Text("document_type"),
        ),
        DataCell(
          Text("status"),
        ),
        DataCell(Row(
          children: [
            ElevatedButton(onPressed: () {}, child: const Text("View")),
            const SizedBox(
              width: 10.0,
            ),
            ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.green),
              ),
              child: const Text("Approve"),
            ),
            const SizedBox(
              width: 10.0,
            ),
            ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.red),
              ),
              child: const Text("Deny"),
            ),
          ],
        )),
      ],
    );
  }

  getAppBarOptions(
      {required String text, required Color color, required IconData icon}) {
    return InkWell(
      onTap: () {},
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
