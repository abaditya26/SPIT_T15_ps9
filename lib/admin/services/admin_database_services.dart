import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
          .where("respondedList", whereNotIn: [uid])
          .where("assignedTo", isEqualTo: 1)
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
    return requests;
  }

  Future<List<AdminRequestModel>> getRequests() async {
    List<AdminRequestModel> requests = [];
    try {
      String uid = auth.currentUser!.uid;
      QuerySnapshot requestsSnapshot = await db
          .collection("requests")
          .where("respondedList", whereNotIn: [uid])
          .where("assignedTo", isEqualTo: 1)
          .get();
      for (QueryDocumentSnapshot requestSnapshot in requestsSnapshot.docs) {
        try {
          requests.add(AdminRequestModel.fromSnapshot(requestSnapshot));
        } catch (e) {}
      }
    } catch (e1) {}
    return requests;
  }

  approveRequest(AdminRequestModel requestModel) {
    //get the current id
    try {
      String uid = auth.currentUser!.uid;
      requestModel.respondedList!.add(uid);
      requestModel.assignedTo = (requestModel.assignedTo ?? 0) + 1;
      if ((requestModel.assignedTo ?? 0) ==
          (requestModel.requiredLevels ?? -1)) {
        requestModel.status = "Approved";
      } else {
        requestModel.status =
            "Forwarded for approval level ${requestModel.assignedTo}";
      }
      db.collection("requests").doc(requestModel.id).update({
        "assignedTo":requestModel.assignedTo,
        "respondedList": requestModel.respondedList,
        "status": requestModel.status
      });
    } catch (e) {}
  }

  rejectRequest(AdminRequestModel requestModel) {
    //get the current id
    try {
      String uid = auth.currentUser!.uid;
      requestModel.respondedList!.add(uid);
      requestModel.status = "Rejected";
      requestModel.assignedTo = -1;
      db.collection("requests").doc(requestModel.id).update({
        "assignedTo":requestModel.assignedTo,
        "status": requestModel.status,
        "responseComment": requestModel.responseComment
      });
    } catch (e) {}
  }
}
