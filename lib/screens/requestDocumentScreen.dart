import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:securing_documents/models/reg_documents_model.dart';
import 'package:securing_documents/models/user_document_model.dart';
import 'package:securing_documents/models/user_model.dart';
import 'package:securing_documents/services/common_data.dart';
import 'package:securing_documents/services/database_services.dart';
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

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 1200;
    return Scaffold(
      appBar: AppBar(),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width:
                      isDesktop ? 1200 : MediaQuery.of(context).size.width - 20,
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(18.0),
                        child: Text(
                          "Request New Document",
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 8.0,
                                    horizontal: 20.0,
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
                                                getDataRow("Business Name",
                                                    user.name ?? ""),
                                                getDataRow("Business Email",
                                                    user.email ?? ""),
                                                getDataRow("Contact Number",
                                                    user.contactNo ?? ""),
                                                getDataRow("Business Address",
                                                    user.address ?? ""),
                                                getDataRow("Business Type",
                                                    user.type ?? ""),
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
                            Expanded(
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8.0, horizontal: 20.0),
                                  child: Column(
                                    children: [
                                      //dropdown for selecting the type of document to generate
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 5),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 5),
                                              decoration: BoxDecoration(
                                                  color:
                                                      const Color(0x0C000000),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child:
                                                  DropdownButton<DocumentModel>(
                                                focusColor: Colors.transparent,
                                                value: _selectedOption,
                                                items: documents.map(
                                                    (DocumentModel option) {
                                                  return DropdownMenuItem<
                                                      DocumentModel>(
                                                    value: option,
                                                    child:
                                                        Text(option.name ?? ""),
                                                  );
                                                }).toList(),
                                                onChanged:
                                                    (DocumentModel? newValue) {
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
                                                DataColumn(
                                                    label:
                                                        Text("Document Name")),
                                                DataColumn(
                                                    label: Text("Download")),
                                                DataColumn(
                                                    label: Text(
                                                        "Upload Document")),
                                              ],
                                              rows:
                                                  _selectedOption
                                                      .requiredDocuments
                                                      .map(
                                                        (DocumentRequirementModel
                                                                document) =>
                                                            DataRow(
                                                          cells: [
                                                            DataCell(Container(
                                                                child: Text(
                                                                    document.title ??
                                                                        ""))),
                                                            DataCell(
                                                              (document.downloadUrl ??
                                                                          "")
                                                                      .isNotEmpty
                                                                  ? IconButton(
                                                                      onPressed:
                                                                          () {
                                                                        launchUrlString(
                                                                            document.downloadUrl);
                                                                      },
                                                                      icon: const Icon(
                                                                          Icons
                                                                              .download),
                                                                    )
                                                                  : const Text(
                                                                      "--"),
                                                            ),
                                                            DataCell(
                                                              (document
                                                                      .uploading)
                                                                  ? CircularProgressIndicator()
                                                                  : (document.url ??
                                                                              "")
                                                                          .isNotEmpty
                                                                      ? Row(
                                                                          children: [
                                                                            IconButton(
                                                                              onPressed: () {},
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
                                                                                CupertinoIcons.delete_simple,
                                                                                color: Colors.red,
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        )
                                                                      : IconButton(
                                                                          // ? ElevatedButton(onPressed: (){}, child: Text("View Uploaded")) : IconButton(
                                                                          onPressed:
                                                                              () {
                                                                            uploadImage(document);
                                                                          },
                                                                          icon:
                                                                              const Icon(Icons.upload),
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
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "Please confirm your data before applying for the document",
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ElevatedButton(
                              onPressed: () {}, child: Text("Apply")),
                          const SizedBox(
                            width: 10.0,
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.red)),
                            child: Text("Clear"),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                    ],
                  ),
                )
              ],
            ),
    );
  }

  Future<void> uploadImage(DocumentRequirementModel document) async {
    document.uploading = true;
    setState(() {});
    await Future.delayed(Duration(seconds: 2));
    document.url = "uploaded";
    document.uploading = false;
    setState(() {});
  }

  removeImage(DocumentRequirementModel document) async {
    document.uploading = true;
    setState(() {});
    await Future.delayed(Duration(seconds: 1));
    document.url = "";
    document.uploading = false;
    setState(() {});
  }
}
