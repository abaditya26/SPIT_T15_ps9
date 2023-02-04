import 'package:flutter/material.dart';
import 'package:securing_documents/admin/models/request_model.dart';
import 'package:securing_documents/admin/services/admin_database_services.dart';
import 'package:securing_documents/admin/widgets/common_widgets.dart';

class AdminRequestsScreen extends StatefulWidget {
  AdminRequestsScreen({Key? key}) : super(key: key);

  @override
  State<AdminRequestsScreen> createState() => _AdminRequestsScreenState();
}

class _AdminRequestsScreenState extends State<AdminRequestsScreen> {
  List<AdminRequestModel> requests = [];
  bool isLoading = true;
  final databaseMethods = AdminDatabaseServices();

  @override
  void initState() {
    super.initState();
    //getRequests
    databaseMethods.getRequests().then((requests) {
      this.requests = requests;
      isLoading = false;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 1200;
    return Scaffold(
      appBar: AdminCommonWidgets().adminAppBar(context, "adminRequests"),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width:
                      isDesktop ? 1200 : MediaQuery.of(context).size.width - 20,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.all(16.0),
                          child: const Text(
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
