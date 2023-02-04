import 'package:securing_documents/services/database_services.dart';

import '../services/auth_services.dart';

class Service {
  final String id;
  final String uid ;
  final String name;
  final String serviceName;
  final String currentStatus;
  final String maxDays;
  final String expectedDate;
  final String status;

  Service({
    required this.id,
     required this.uid,
    required this.name,
    required this.serviceName,
    required this.currentStatus,
    required this.maxDays,
    required this.expectedDate,
    required this.status,
  });
  Map<String, dynamic> toMap() {
    return {
      "id":id,
      "uid": uid,
      "name": name,
      "serviceName": serviceName,
      "currentStatus": currentStatus,
      "maxDays": maxDays,
      "expectedDate": expectedDate,
      "status": status,
    };
  }
}