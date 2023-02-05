import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:securing_documents/models/documentStatus_model.dart';
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
}
