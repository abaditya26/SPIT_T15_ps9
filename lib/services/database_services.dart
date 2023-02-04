import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:securing_documents/models/user_model.dart';
import 'package:securing_documents/services/auth_services.dart';

class DatabaseServices {
  final _db = FirebaseFirestore.instance;

  Future<void> addUserData(UserModel user) {
    return _db.collection("users").doc(user.uid).set(user.toMap());
  }

  Future<Map<String, dynamic>> validateUser(String uid) async {

    DocumentSnapshot documentSnapshot =
        await _db.collection("users").doc(uid).get();
    if (documentSnapshot.exists) {
      try {
        if (documentSnapshot.get("role") == "admin") {
          return {
            "admin": true,
          };
        }else {
          return {
            "admin": false,
          };
        }
      } catch (e) {
        return {"admin": false};
      }
    } else {
      return {
        "admin": false,
      };
    }
  }

  Future<UserModel> getUserData() async {
    String uid = AuthServices().getUid();
    DocumentSnapshot snap = await _db.collection("users").doc(uid).get();
    return UserModel(
      uid: snap["uid"],
      email: snap["email"],
      name: snap["name"],
      contactNo: snap["contactNo"],
      address: snap["address"],
      type: snap["type"],
      role: snap["role"],
    );
  }

  Future<void> updateUserData(UserModel user) async {
    return _db.collection("users").doc(user.uid).update(user.toMap());
  }

  Stream<QuerySnapshot> getUsers() {
    return _db.collection("users").orderBy("name").snapshots();
  }
  Future<void> addTransactions(UserModel user) {
    return _db.collection("transactions").doc(user.uid).set(user.toMap());
  }
  Stream<QuerySnapshot> getTransaction() {
    return _db.collection("transactions").orderBy("id").snapshots();
  }
}
