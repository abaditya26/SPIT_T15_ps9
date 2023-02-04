import 'package:flutter/material.dart';
import 'package:securing_documents/models/documentStatus_model.dart';

import '../services/auth_services.dart';
import '../services/database_services.dart';

class CertificateStatus extends StatefulWidget {
  const CertificateStatus({Key? key}) : super(key: key);

  @override
  State<CertificateStatus> createState() => _CertificateStatusState();
}

class _CertificateStatusState extends State<CertificateStatus> {
  final _auth = AuthServices();
  final _db = DatabaseServices();

  final List<Service> services = [
    Service(
      id: '123456',
      name: 'John Doe',
      serviceName: 'Service A',
      currentStatus: 'Pending',
      maxDays: '15',
      expectedDate: '10/10/2022',
      status: 'Rejected', uid: '',
    ),
    Service(
        id: '123456',
        name: 'Jane Doe',
        serviceName: 'Service B',
        currentStatus: 'Approved',
        maxDays: '10',
        expectedDate: '07/05/2011',
        status: 'Not Rejected',
        uid: ''),
  ];
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          const Text(
            'Your Transaction History',
            style: TextStyle(fontSize: 26),
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
                    label: Text('Application Status'),
                    numeric: false,
                    tooltip: 'Status of the service',
                  ),
                  DataColumn(
                    label: Text('Download Certificate'),
                    numeric: false,
                    tooltip: 'Download certificate of the service',
                  ),
                ],
                rows: services
                    .map((service) => DataRow(
                          cells: [
                            DataCell(Text(service.id)),
                            DataCell(Text(service.name)),
                            DataCell(Text(service.serviceName)),
                            DataCell(Text(service.currentStatus)),
                            DataCell(Text(service.maxDays.toString())),
                            DataCell(Text(service.expectedDate.toString())),
                            DataCell(Text(service.status)),
                            DataCell(
                              ElevatedButton(
                                child: const Text('Download'),
                                onPressed: () {},
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
