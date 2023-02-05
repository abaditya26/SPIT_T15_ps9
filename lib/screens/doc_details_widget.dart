import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:securing_documents/models/documentStatus_model.dart';
import 'package:securing_documents/screens/progress_tracker.dart';
import '../admin/models/request_model.dart';
import '../services/auth_services.dart';
import '../services/database_services.dart';

class CertificateStatus extends StatefulWidget {
  const CertificateStatus({Key? key}) : super(key: key);

  @override
  State<CertificateStatus> createState() => _CertificateStatusState();
}

class _CertificateStatusState extends State<CertificateStatus> {
  late AdminRequestModel document;

  List<AdminRequestModel> services = [];
  bool _isVisible = false;
  final _auth = AuthServices();
  final _db = DatabaseServices();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _db.getRequests().then((requests) {
      this.services = requests;
      isLoading = false;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Your Transaction History',
              style: GoogleFonts.urbanist(
                color: const Color(0xFF14181B),
                fontWeight: FontWeight.w600,
                fontSize: 26,
              ),
            ),
          ),
          Card(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const [
                  DataColumn(
                    label: Text('ID'),
                    numeric: true,
                    tooltip: 'Name of ID',
                  ),
                  DataColumn(
                    label: Text('Name'),
                    numeric: false,
                    tooltip: 'Name of the service',
                  ),
                  DataColumn(
                    label: Text('Service Name'),
                    numeric: false,
                    tooltip: 'Name of the service',
                  ),
                  DataColumn(
                    label: Text('Current Status'),
                    numeric: false,
                    tooltip: 'Current status of the service',
                  ),
                  DataColumn(
                    label: Text('Maximum Days'),
                    numeric: false,
                    tooltip: 'Maximum days for issuing certificate',
                  ),
                  DataColumn(
                    label: Text('Expected Date'),
                    numeric: false,
                    tooltip: 'Expected days for issuing certificate',
                  ),
                  DataColumn(
                    label: Text('View Certificate'),
                    numeric: false,
                    tooltip: 'View certificate of the service',
                  ),
                ],
                rows: services
                    .map((service) => DataRow(
                          cells: [
                            DataCell(Text(service.documentId ?? "")),
                            DataCell(Text(service.businessName ?? "")),
                            DataCell(Text(service.documentName ?? "")),
                            DataCell(Text(service.status ?? "")),
                            DataCell(
                                Text(service.documentTimeRequired.toString())),
                            DataCell(Text(
                                "${DateTime.fromMillisecondsSinceEpoch(service.timestamp!.millisecondsSinceEpoch).add(Duration(days: service.documentTimeRequired ?? 2))}")),
                            DataCell(
                              ElevatedButton(
                                child: const Text('View Status'),
                                onPressed: () {
                                  showPopupDialog(service);
                                },
                              ),
                            ),
                          ],
                        ))
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future showPopupDialog(AdminRequestModel service) {
    List<Map<String, String>> desks = [];
    for (int i = 0; i < (service.requiredLevels ?? 0); i++) {
      desks.add({
        "Desk ${i + 1}": ((service.assignedTo ?? 0) <= 0
            ? "Rejected"
            : i < ((service.assignedTo ?? 0) - 1)
                ? "Approved"
                : "Pending")
      });
    }
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Row(
                children: [
                  const Expanded(child: Text("Request Status")),
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.close)),
                ],
              ),
              content: Column(
                children: [
                  Text("Current Status :- ${service.status}"),
                  progress_tracker(
                    progressValue: ((((service.assignedTo ?? 1) - 1) < 0
                            ? 0
                            : ((service.assignedTo ?? 1) - 1) /
                                (service.requiredLevels ?? 1))) *
                        100,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: DataTable(
                      columns: const [
                        DataColumn(
                          label: Text("Desk"),
                        ),
                        DataColumn(label: Text("Status"))
                      ],
                      rows: desks
                          .map(
                            (Map<String, String> desk) => DataRow(cells: [
                              DataCell(Text(desk.keys.first)),
                              DataCell(Text(desk.values.first)),
                            ]),
                          )
                          .toList(),
                    ),
                  ),
                ],
              ),
            ));
  }
}
