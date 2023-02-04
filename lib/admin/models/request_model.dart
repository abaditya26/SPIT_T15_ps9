class AdminRequestModel {
  String? id,
      requestId,
      businessName,
      documentType,
      status,
      comments,
      responseComment;
  List<String>? documentList;
  bool responded = false;

  AdminRequestModel(
      {this.id,
      this.requestId,
      this.businessName,
      this.documentType,
      this.status,
      this.comments,
      this.responseComment,
      this.documentList,
      this.responded = false});

  AdminRequestModel.fromMap(Map<String, dynamic> map) {
    id = map.containsKey("id") ? map["id"] : null;
    requestId = map.containsKey("requestId") ? map["requestId"] : null;
    businessName = map.containsKey("businessName") ? map["businessName"] : null;
    documentType = map.containsKey("documentType") ? map["documentType"] : null;
    status = map.containsKey("status") ? map["status"] : null;
    comments = map.containsKey("comments") ? map["comments"] : null;
    responseComment =
        map.containsKey("responseComment") ? map["responseComment"] : null;
    try {
      responded = map.containsKey("responded") ? map["responded"] : false;
    } catch (e) {
      responded = false;
    }
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
      "responded": responded,
    };
  }
}
