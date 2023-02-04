class DocumentRequirementModel {
  final String id;
  final String title;
  String downloadUrl;
  String url;
  bool uploading = false;

  DocumentRequirementModel(
      {required this.id,
      required this.title,
      this.downloadUrl = '',
      this.url = '', this.uploading = false});
}

class DocumentModel {
  final String id;
  final String name;
  final List<DocumentRequirementModel> requiredDocuments;
  final int charge;
  final int timeRequired;
  final String description;

  DocumentModel(
      {required this.id,
      required this.name,
      required this.requiredDocuments,
      required this.charge,
      required this.timeRequired,
      required this.description});
}
