import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:securing_documents/admin/models/request_model.dart';
import 'package:securing_documents/admin/services/admin_database_services.dart';
import 'package:securing_documents/admin/widgets/common_widgets.dart';
import 'package:securing_documents/services/auth_services.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AdminViewRequest extends StatefulWidget {
  final AdminRequestModel requestData;

  const AdminViewRequest({super.key, required this.requestData});
  @override
  State<AdminViewRequest> createState() => _AdminViewRequestState();
}

class _AdminViewRequestState extends State<AdminViewRequest> {
  bool isLoading = true;
  final databaseMethods = AdminDatabaseServices();

  @override
  void initState() {
    super.initState();
    //load the data for the documents
    databaseMethods.getDocumentList(widget.requestData).then((value) {
      widget.requestData.documentList = value;
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 1200;
    return Scaffold(
      appBar: AdminCommonWidgets().adminAppBar(context, "adminViewRequest"),
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
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.all(16.0),
                          child: const Text(
                            "Requests Details",
                            style: TextStyle(fontSize: 22.0),
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                                child: DetailsContainer(
                              requestData: widget.requestData,
                            )),
                            Expanded(
                                child: DocumentsContainer(
                              requestData: widget.requestData,
                            )),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
    );
  }
}

class DetailsContainer extends StatefulWidget {
  final AdminRequestModel requestData;

  DetailsContainer({super.key, required this.requestData});

  @override
  State<DetailsContainer> createState() => _DetailsContainerState();
}

class _DetailsContainerState extends State<DetailsContainer> {
  final commentController = TextEditingController();

  final databaseMethods = AdminDatabaseServices();

  bool isLoading = false;

  String uid = AuthServices().getUid();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text("Business Details"),
              Row(
                children: [
                  Expanded(
                    child: DataTable(
                      columns: [
                        const DataColumn(label: Text("Title")),
                        const DataColumn(label: Text("Values")),
                      ],
                      rows: [
                        DataRow(cells: [
                          const DataCell(
                            Text("Request Id"),
                          ),
                          DataCell(Text("${widget.requestData.requestId}"))
                        ]),
                        DataRow(cells: [
                          const DataCell(
                            Text("Business Name"),
                          ),
                          DataCell(Text(widget.requestData.businessName ?? ""))
                        ]),
                        DataRow(cells: [
                          const DataCell(
                            Text("Document Name"),
                          ),
                          DataCell(Text(widget.requestData.documentName ?? ""))
                        ]),
                        DataRow(cells: [
                          const DataCell(
                            Text("Business Type"),
                          ),
                          DataCell(Text(widget.requestData.businessType ?? ""))
                        ]),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(
                            labelText:
                                "Enter comments for business(optional)."),
                        minLines: 1,
                        maxLines: 5,
                      ),
                      const SizedBox(
                        height: 12.0,
                      ),
                      isLoading
                          ? const CircularProgressIndicator()
                          : (widget.requestData.respondedList ?? [])
                                  .contains(uid)
                              ? const Text("Already Responded")
                              : Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        approveRequest();
                                      },
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.green),
                                      ),
                                      child: const Text("Approve"),
                                    ),
                                    const SizedBox(
                                      width: 10.0,
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        denyRequest();
                                      },
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.red),
                                      ),
                                      child: const Text("Deny"),
                                    ),
                                  ],
                                )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void denyRequest() {
    isLoading = true;
    setState(() {});
    widget.requestData.responseComment = commentController.text;
    widget.requestData.respondedList ??= [];
    widget.requestData.respondedList!.add(uid);
    databaseMethods.rejectRequest(widget.requestData).then((value) {
      isLoading = false;
      setState(() {});
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Confirmation"),
          content: const Text("You have rejected this request/"),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("OK"),
            )
          ],
        ),
      );
    });
  }

  void approveRequest() {
    isLoading = true;
    setState(() {});
    widget.requestData.responseComment = commentController.text;
    widget.requestData.respondedList ??= [];
    String uid = AuthServices().getUid();
    widget.requestData.respondedList!.add(uid);
    databaseMethods.approveRequest(widget.requestData).then(
      (value) {
        isLoading = false;
        setState(() {});
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Confirmation"),
            content: const Text("You have approved this request"),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("OK"),
              )
            ],
          ),
        );
      },
    );
  }
}

class DocumentsContainer extends StatelessWidget {
  final AdminRequestModel requestData;

  const DocumentsContainer({super.key, required this.requestData});

  @override
  Widget build(BuildContext context) {
    print(requestData.documentList?.length);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text("Submitted Document List"),
              Row(
                children: [
                  Expanded(
                    child: DataTable(
                      columns: const [
                        // DataColumn(label: Text("#")),
                        DataColumn(label: Text("Document Title")),
                        DataColumn(label: Text("View")),
                      ],
                      rows: (requestData.documentList ?? [])
                          .map((request) => DataRow(cells: [
                                // DataCell(Text(request.id)),
                                DataCell(
                                  Container(
                                    child: Text(
                                      request.title,
                                      textDirection: TextDirection.ltr,
                                      softWrap: true,
                                    ),
                                  ),
                                ),
                                DataCell(
                                  request.url.isNotEmpty
                                      ? ElevatedButton(
                                          onPressed: () {
                                            launchUrlString(request.url);
                                          },
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: const [
                                              Icon(
                                                CupertinoIcons.eye,
                                                size: 18.0,
                                              ),
                                              SizedBox(
                                                width: 10.0,
                                              ),
                                              Text("View"),
                                            ],
                                          ),
                                        )
                                      : const Text("Not Uploaded"),
                                ),
                              ]))
                          .toList(),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
