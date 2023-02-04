import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:securing_documents/admin/models/document_model.dart';
import 'package:securing_documents/admin/models/responded_model.dart';

class AdminRequestModel {
  String? id,
      requestId,
      businessName,
      documentType,
      status,
      comments,
      responseComment;
  int? assignedTo;
  int? requiredLevels;
  List<DocumentModel>? documentList;
  List<String>? respondedList;

  AdminRequestModel({
    this.id,
    this.requestId,
    this.businessName,
    this.documentType,
    this.status,
    this.comments,
    this.responseComment,
    this.documentList,
    this.assignedTo,
    this.requiredLevels,
    this.respondedList,
  });

  // AdminRequestModel.fromMap(Map<String, dynamic> map) {
  //   id = map.containsKey("id") ? map["id"] : null;
  //   requestId = map.containsKey("requestId") ? map["requestId"] : null;
  //   businessName = map.containsKey("businessName") ? map["businessName"] : null;
  //   documentType = map.containsKey("documentType") ? map["documentType"] : null;
  //   status = map.containsKey("status") ? map["status"] : null;
  //   comments = map.containsKey("comments") ? map["comments"] : null;
  //   assignedTo = map.containsKey("assignedTo") ? map["assignedTo"] : null;
  //   responseComment =
  //       map.containsKey("responseComment") ? map["responseComment"] : null;
  // }

  AdminRequestModel.fromSnapshot(QueryDocumentSnapshot snap) {
    id = snap.get("id");
    requestId = snap.get("requestId");
    businessName = snap.get("businessName");
    documentType = snap.get("documentType");
    status = snap.get("status");
    responseComment = snap.get("responseComment");
    comments = snap.get("comments");
    assignedTo = snap.get("assignedTo");
    requiredLevels = snap.get("requiredLevels");
    respondedList = snap.get("respondedList");

    //get responded list
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "requestId": requestId,
      "businessName": businessName,
      "documentType": documentType,
      "status": status,
      "comments": comments,
      "responseComment": responseComment,
      "assignedTo": assignedTo,
      "respondedList": respondedList,
    };
  }
}
