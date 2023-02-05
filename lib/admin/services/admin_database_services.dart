import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:securing_documents/admin/models/document_model.dart';
import 'package:securing_documents/admin/models/request_model.dart';

class AdminDatabaseServices {
  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;

  Future<List<AdminRequestModel>> getRecentRequests() async {
    List<AdminRequestModel> requests = [];
    try {
      String uid = auth.currentUser!.uid;
      QuerySnapshot requestsSnapshot = await db
          .collection("requests")
          .where("assignedTo", isEqualTo: 1)
          // .where("status", isNotEqualTo: "Approved")
          .limit(10)
          .get();
      for (QueryDocumentSnapshot requestSnapshot in requestsSnapshot.docs) {
        try {
          requests.add(AdminRequestModel.fromSnapshot(requestSnapshot));
        } catch (e) {
          print(e);
        }
      }
    } catch (e1) {}
    print(requests.length);
    return requests;
  }

  Future<List<AdminRequestModel>> getRequests() async {
    List<AdminRequestModel> requests = [];
    try {
      String uid = auth.currentUser!.uid;
      QuerySnapshot requestsSnapshot = await db
          .collection("requests")
          // .where("respondedList", whereNotIn: [uid])
          // .where("status", isNotEqualTo: "Approved")
          .where("assignedTo", isEqualTo: 1)
          .orderBy("requestId")
          .get();
      for (QueryDocumentSnapshot requestSnapshot in requestsSnapshot.docs) {
        try {
          requests.add(AdminRequestModel.fromSnapshot(requestSnapshot));
        } catch (e) {}
      }
    } catch (e1) {}
    return requests;
  }

  Future<void> approveRequest(AdminRequestModel requestModel) async {
    //get the current id
    try {
      requestModel.assignedTo = (requestModel.assignedTo ?? 0) + 1;
      if ((requestModel.assignedTo ?? 0) >=
          (requestModel.requiredLevels ?? -1)) {
        requestModel.status = "Approved";
      } else {
        requestModel.status =
            "Forwarded for approval level ${requestModel.assignedTo}";
      }
      await db.collection("requests").doc(requestModel.id).update({
        "assignedTo": requestModel.assignedTo,
        "respondedList": requestModel.respondedList,
        "status": requestModel.status,
        "responseComment": requestModel.responseComment
      });
    } catch (e) {}
  }

  rejectRequest(AdminRequestModel requestModel) {
    //get the current id
    try {
      requestModel.status = "Rejected";
      requestModel.assignedTo = -1;
      db.collection("requests").doc(requestModel.id).update({
        "assignedTo": requestModel.assignedTo,
        "respondedList": requestModel.respondedList,
        "status": requestModel.status,
        "responseComment": requestModel.responseComment
      });
    } catch (e) {}
  }

  Future<List<DocumentRequirementModel>> getDocumentList(AdminRequestModel requestData) async {
    QuerySnapshot snap = await db
        .collection("requests")
        .doc(requestData.id)
        .collection("documents")
        .get();
    requestData.documentList = [];
    for (QueryDocumentSnapshot snapshot in snap.docs) {
      requestData.documentList!.add(
        DocumentRequirementModel(
          id: snapshot.get("id"),
          title: snapshot.get("title"),
          downloadUrl: snapshot.get("downloadUrl"),
          url: snapshot.get("url"),
        ),
      );
    }
    return requestData.documentList ?? [];
  }
}
