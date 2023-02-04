import 'package:flutter/material.dart';
import 'package:securing_documents/admin/models/request_model.dart';
import 'package:securing_documents/admin/widgets/admin_dash_widgets.dart';

class AdminDashScreen extends StatefulWidget {
  const AdminDashScreen({Key? key}) : super(key: key);

  @override
  State<AdminDashScreen> createState() => _AdminDashScreenState();
}

class _AdminDashScreenState extends State<AdminDashScreen> {
  final dashWidget = AdminDashWidgets();
  List<AdminRequestModel> requests = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 1200;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0.0,
        title: Row(
          children: [
            Text("App Name Here"),
          ],
        ),
        actions: [
          dashWidget.getAppBarOptions(
            text: "Requests",
            color: Colors.black,
            icon: Icons.list,
          ),
          dashWidget.getAppBarOptions(
            text: "Logout",
            color: Colors.red,
            icon: Icons.exit_to_app,
          ),
        ],
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: isDesktop ? 1200 : MediaQuery.of(context).size.width - 20,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.all(10.0),
                          color: Colors.grey,
                          height: 250.0,
                          child: Text("Chart"),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.all(10.0),
                          color: Colors.grey,
                          height: 250.0,
                          child: Text("Chart"),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.all(16.0),
                    child: Text(
                      "Recent Requests",
                      style: TextStyle(fontSize: 22.0),
                    ),
                  ),
                  DataTable(
                    columns: const [
                      DataColumn(label: Text("#")),
                      DataColumn(label: Text("Request ID")),
                      DataColumn(label: Text("User Name")),
                      DataColumn(label: Text("Document Type")),
                      DataColumn(label: Text("Status")),
                      DataColumn(label: Text("Actions")),
                    ],
                    rows: requests
                        .map(((AdminRequestModel request) => DataRow(
                              cells: [
                                DataCell(
                                  Text(request.id ?? ""),
                                ),
                                DataCell(
                                  Text(request.requestId ?? ""),
                                ),
                                DataCell(
                                  Text(request.businessName ?? ""),
                                ),
                                DataCell(
                                  Text(request.documentType ?? ""),
                                ),
                                DataCell(
                                  Text(request.status ?? ""),
                                ),
                                DataCell(Row(
                                  children: [
                                    ElevatedButton(
                                        onPressed: () {},
                                        child: const Text("View")),
                                    const SizedBox(
                                      width: 10.0,
                                    ),
                                    ElevatedButton(
                                      onPressed: () {},
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.green),
                                      ),
                                      child: const Text("Approve"),
                                    ),
                                    const SizedBox(
                                      width: 10.0,
                                    ),
                                    ElevatedButton(
                                      onPressed: () {},
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.red),
                                      ),
                                      child: const Text("Deny"),
                                    ),
                                  ],
                                )),
                              ],
                            )))
                        .toList(),
                    // rows: [
                    //   dashWidget.getDashRequestRows(),
                    //   dashWidget.getDashRequestRows(),
                    //   dashWidget.getDashRequestRows(),
                    //   dashWidget.getDashRequestRows(),
                    //   dashWidget.getDashRequestRows(),
                    // ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}