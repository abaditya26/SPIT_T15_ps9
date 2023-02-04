import 'package:intl/intl.dart';


class UserModel {
  final String email;
  String uid, name, contactNo, role, address,type;
  UserModel(
      {required this.uid,
        required this.email,
        required this.name,
        required this.contactNo,
        required this.address,
        required this.type,
        this.role = "user",
      });

  Map<String, dynamic> toMap() {
    return {
      "email": email,
      "uid": uid,
      "name": name,
      "contactNo": contactNo,
      "address": address,
      "type": type,
      "role": role,
        };
  }
}
