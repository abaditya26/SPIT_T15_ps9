import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:securing_documents/models/user_document_model.dart';
import 'package:securing_documents/models/user_model.dart';
import 'package:securing_documents/services/auth_services.dart';

import '../admin/models/request_model.dart';

class DatabaseServices {
  final _db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;


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
        } else {
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

  Future<List<AdminRequestModel>> getRequests() async {
    List<AdminRequestModel> requests = [];
    try {
      String uid = _auth.currentUser!.uid;
      print(uid);
      QuerySnapshot requestsSnapshot = await _db
          .collection("requests")
          .where("uid", isEqualTo: uid)
          .get();
      for (QueryDocumentSnapshot requestSnapshot in requestsSnapshot.docs) {
        try {
          requests.add(AdminRequestModel.fromSnapshot(requestSnapshot));
        } catch (e) {
          print(e);
        }
      }
    } catch (e1) {}
    return requests;
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

  Future<void> createRequest(
      UserModel user, DocumentModel selectedOption) async {
    //get request count
    int nextId = 0;

    // Get the latest reference ID from Firestore
    QuerySnapshot snapshot = await _db
        .collection('requests')
        .orderBy('requestId', descending: true)
        .limit(1)
        .get();
    if (snapshot.docs.length > 0) {
      nextId = snapshot.docs[0]['requestId'] + 1;
      // nextId = snapshot.docs[0].data()['requestId'] + 1;
    }
    DocumentReference ref =
        await _db.collection("requests").add(user.toMap(otherData: {
              "id": "",
              "requestId": nextId,
              "documentType": "",
              "status": "Forwarded to desk 1",
              "responseComment": "",
              "comments": "",
              "assignedTo": 1,
              "requiredLevels": selectedOption.levelsCount,
              "respondedList": [],
              "documentId": selectedOption.id,
              "documentName": selectedOption.name,
              "documentCharge": selectedOption.charge,
              "documentTimeRequired": selectedOption.timeRequired,
              "documentDescription": selectedOption.description,
              "timestamp": Timestamp.now(),
            }));
    await _db.collection("requests").doc(ref.id).update({"id": ref.id});
    for (var doc in selectedOption.requiredDocuments) {
      //upload all documents to cloud
      DocumentReference ref1 = await _db
          .collection("requests")
          .doc(ref.id)
          .collection("documents")
          .add(doc.toMap());
      await _db
          .collection("requests")
          .doc(ref.id)
          .collection("documents")
          .doc(ref1.id)
          .update({"id": ref.id});
    }
  }
}
