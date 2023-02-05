class DocumentRequirementModel {
  final String id;
  final String title;
  String downloadUrl;
  String url;
  String fileName;
  bool uploading = false;
  final bool isRequired;

  DocumentRequirementModel(
      {required this.id,
      required this.title,
      this.downloadUrl = '',
      this.url = '',
      this.uploading = false,
      this.fileName = '',
      required this.isRequired});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'downloadUrl': downloadUrl,
      'url': url,
      'fileName': fileName,
      'uploading': uploading,
    };
  }
}

class DocumentModel {
  final String id;
  final String name;
  final List<DocumentRequirementModel> requiredDocuments;
  final int charge;
  final int timeRequired;
  final String description;
  final int levelsCount = 1;

  DocumentModel(
      {required this.id,
      required this.name,
      required this.requiredDocuments,
      required this.charge,
      required this.timeRequired,
      required this.description});
}
