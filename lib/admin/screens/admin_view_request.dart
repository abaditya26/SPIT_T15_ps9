import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:securing_documents/admin/widgets/common_widgets.dart';

class AdminViewRequest extends StatefulWidget {
  @override
  State<AdminViewRequest> createState() => _AdminViewRequestState();
}

class _AdminViewRequestState extends State<AdminViewRequest> {
  bool isLoading = false;

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
                            Expanded(child: DetailsContainer()),
                            Expanded(child: DocumentsContainer()),
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

class DetailsContainer extends StatelessWidget {
  const DetailsContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text("Business Details"),
            Row(
              children: [
                Expanded(
                  child: DataTable(
                    columns: [
                      DataColumn(label: Text("Title")),
                      DataColumn(label: Text("Values")),
                    ],
                    rows: [
                      DataRow(cells: [
                        DataCell(
                          Text("Request Id"),
                        ),
                        DataCell(Text("req_id"))
                      ]),
                      DataRow(cells: [
                        DataCell(
                          Text("Business Name"),
                        ),
                        DataCell(Text("business_name"))
                      ]),
                      DataRow(cells: [
                        DataCell(
                          Text("Document Type"),
                        ),
                        DataCell(Text("document_type"))
                      ]),
                      DataRow(cells: [
                        DataCell(
                          Text("Status"),
                        ),
                        DataCell(Text("status"))
                      ]),
                      DataRow(cells: [
                        DataCell(
                          Text("Comments by business"),
                        ),
                        DataCell(Text("comments_by_business"))
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
                          labelText: "Enter comments for business(optional)."),
                      minLines: 1,
                      maxLines: 5,
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.green),
                          ),
                          child: const Text("Approve"),
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.red),
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
    );
  }
}

class DocumentsContainer extends StatelessWidget {
  const DocumentsContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text("SubmittedDocument List"),
            Row(
              children: [
                Expanded(
                  child: DataTable(
                    columns: [
                      DataColumn(label: Text("#")),
                      DataColumn(label: Text("Document Title")),
                      DataColumn(label: Text("View")),
                    ],
                    rows: [
                      DataRow(cells: [
                        DataCell(Text("1")),
                        DataCell(
                          Container(
                            child: Text(
                              'This is a very long text that should wrap into multiple lines',
                              textDirection: TextDirection.ltr,
                              softWrap: true,
                            ),
                          ),
                        ),
                        DataCell(ElevatedButton(
                          onPressed: () {},
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
                        )),
                      ])
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
