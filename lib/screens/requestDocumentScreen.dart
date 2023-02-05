import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:securing_documents/models/reg_documents_model.dart';
import 'package:securing_documents/models/user_document_model.dart';
import 'package:securing_documents/models/user_model.dart';
import 'package:securing_documents/screens/side_nav.dart';
import 'package:securing_documents/services/common_data.dart';
import 'package:securing_documents/services/database_services.dart';
import 'package:securing_documents/services/storage_services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class RequestDocumentScreen extends StatefulWidget {
  const RequestDocumentScreen({Key? key}) : super(key: key);

  @override
  State<RequestDocumentScreen> createState() => _RequestDocumentScreenState();
}

class _RequestDocumentScreenState extends State<RequestDocumentScreen> {
  bool isLoading = true;
  List<DocumentModel> documents = CommonData.documents;
  late DocumentModel _selectedOption;
  final databaseMethods = DatabaseServices();
  late UserModel user;
  bool isUploading = false;

  getUserData() {
    databaseMethods.getUserData().then((value) {
      user = value;
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  void initState() {
    _selectedOption = documents[0];
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 1200;
    return Scaffold(
      body: SafeArea(
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Row(
                children: [
                  const AdminDrawer(page: "requestDocument",),
                  Expanded(
                    child: Column(
                      children: [
                        AppBar(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          elevation: 0.0,
                          title: Text("Request New Document"),
                          centerTitle: true,
                        ),
                        Expanded(
                          child: SizedBox(
                            width:
                                isDesktop ? 1200 : MediaQuery.of(context).size.width - 20,
                            child: Column(
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Card(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 8.0,
                                              horizontal: 10.0,
                                            ),
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: DataTable(
                                                        columns: const [
                                                          DataColumn(
                                                              label: Text("Title")),
                                                          DataColumn(
                                                              label: Text("Value")),
                                                        ],
                                                        rows: [
                                                          getDataRow(
                                                              "Business Name", user.name),
                                                          getDataRow("Business Email",
                                                              user.email),
                                                          getDataRow("Contact Number",
                                                              user.contactNo),
                                                          getDataRow("Business Address",
                                                              user.address),
                                                          getDataRow(
                                                              "Business Type", user.type),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      documentsListContainer(),
                                    ],
                                  ),
                                ),
                                const Text(
                                  "Please confirm your data before applying for the document",
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                isUploading
                                    ? const CircularProgressIndicator()
                                    : Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          ElevatedButton(
                                              onPressed: () {
                                                applyForCertificates();
                                              },
                                              child: const Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 10.0, horizontal: 20.0),
                                                child: Text("Apply"),
                                              )),
                                          const SizedBox(
                                            width: 10.0,
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              clearDocuments();
                                            },
                                            style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        Colors.red)),
                                            child: const Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 10.0, horizontal: 20.0),
                                              child: Text("Clear"),
                                            ),
                                          ),
                                        ],
                                      ),
                                const SizedBox(
                                  height: 20.0,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
      ),
    );
  }

  DataRow getDataRow(String title, String value) {
    return DataRow(cells: [
      DataCell(
        Text(title),
      ),
      DataCell(
        Text(value),
      ),
    ]);
  }

  documentsListContainer() => Expanded(
        child: Card(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
            child: Column(
              children: [
                //dropdown for selecting the type of document to generate
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                            color: const Color(0x0C000000),
                            borderRadius: BorderRadius.circular(10)),
                        child: DropdownButton<DocumentModel>(
                          focusColor: Colors.transparent,
                          value: _selectedOption,
                          items: documents.map((DocumentModel option) {
                            return DropdownMenuItem<DocumentModel>(
                              value: option,
                              child: Text(option.name),
                            );
                          }).toList(),
                          onChanged: (DocumentModel? newValue) {
                            setState(() {
                              _selectedOption = newValue!;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: DataTable(
                        columns: const [
                          DataColumn(label: Text("Document Name")),
                          DataColumn(label: Text("Download")),
                          DataColumn(label: Text("Upload Document")),
                        ],
                        rows: _selectedOption.requiredDocuments
                            .map(
                              (DocumentRequirementModel document) => DataRow(
                                cells: [
                                  DataCell(Container(
                                      child: Text(
                                          "${document.isRequired ? "* " : ""}${document.title}"))),
                                  DataCell(
                                    (document.downloadUrl).isNotEmpty
                                        ? IconButton(
                                            onPressed: () {
                                              launchUrlString(
                                                  document.downloadUrl);
                                            },
                                            icon: const Icon(Icons.download),
                                          )
                                        : const Text("--"),
                                  ),
                                  DataCell(
                                    (document.uploading)
                                        ? const CircularProgressIndicator()
                                        : (document.url).isNotEmpty
                                            ? Row(
                                                children: [
                                                  IconButton(
                                                    onPressed: () {
                                                      launchUrlString(
                                                          document.url);
                                                    },
                                                    icon: const Icon(
                                                      CupertinoIcons.eye,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 10.0,
                                                  ),
                                                  IconButton(
                                                    onPressed: () {
                                                      removeImage(document);
                                                    },
                                                    icon: const Icon(
                                                      CupertinoIcons
                                                          .delete_simple,
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                ],
                                              )
                                            : IconButton(
                                                onPressed: () {
                                                  uploadImage(document);
                                                },
                                                icon: const Icon(Icons.upload),
                                              ),
                                  ),
                                ],
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10.0,
                ),
                const Text("* represents compulsory fields"),
              ],
            ),
          ),
        ),
      );

  final storageServices = StorageServices();

  Future<void> uploadImage(DocumentRequirementModel document) async {
    document.uploading = true;
    setState(() {});
    storageServices.uploadDocument(document, context, uploadedImage);
  }

  uploadedImage(DocumentRequirementModel document) {
    document.uploading = false;
    setState(() {});
  }

  removeImage(DocumentRequirementModel document) async {
    document.uploading = true;
    setState(() {});
    await storageServices.removeImage(document);
    document.url = "";
    document.fileName = "";
    document.uploading = false;
    setState(() {});
  }

  void clearDocuments() {
    for (var doc in _selectedOption.requiredDocuments) {
      if (doc.fileName.isNotEmpty) {
        removeImage(doc);
      }
    }
  }

  void applyForCertificates() {
    //first check for upload
    for (var doc in _selectedOption.requiredDocuments) {
      if (doc.isRequired && doc.url.isEmpty) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Document Required"),
            content: Container(
              child: const Text("Please upload all the required documents."),
            ),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("OK"))
            ],
          ),
        );
        return;
      }
    }
    //get confirmation
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("Confirmation"),
              content: Container(
                child: const Text(
                    "Invalid inputs may lead to rejection of document. Please do confirm details before applying.\n\nHave you confirmed it?"),
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    uploadData();
                  },
                  child: const Text("Confirmed"),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.red)),
                  child: const Text("Go Back"),
                )
              ],
            ));
  }

  void uploadData() {
    //check if all data uploaded

    isUploading = true;
    setState(() {});

    databaseMethods.createRequest(user, _selectedOption).then((value) {
      isUploading = false;
      setState(() {});
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text("Request Sent"),
                content: const Text(
                    "Document Request Sent. You shall receive confirmation mail shortly."),
                actions: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("OK"))
                ],
              ));
      for (var doc in _selectedOption.requiredDocuments) {
        if (doc.fileName.isNotEmpty) {
          doc.url = "";
          doc.fileName = "";
          doc.uploading = false;
          setState(() {});
        }
      }
    }).catchError((e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error :- ${e}")));
      isUploading = false;
      setState(() {});
    });
  }
}
