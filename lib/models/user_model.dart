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

  Map<String, dynamic> toMap({Map<String, dynamic> otherData = const {}}) {
    Map<String, dynamic> map =  {
      "businessEmail": email,
      "uid": uid,
      "businessName": name,
      "businessContact": contactNo,
      "businessAddress": address,
      "businessType": type,
      "role": role,
        };
    map.addAll(otherData);
    return map;
  }
}
