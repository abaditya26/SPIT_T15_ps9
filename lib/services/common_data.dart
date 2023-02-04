import 'package:securing_documents/models/reg_documents_model.dart';
import 'package:securing_documents/models/user_document_model.dart';

class CommonData {
  static
  List<DocumentModel> documents = [
    DocumentModel(
        id: '1',
        name: 'Trade License',
        requiredDocuments: [
          DocumentRequirementModel(
              id: '1',
              title: 'Application Form',
              downloadUrl:
              'https://example.com/trade-license-application-form.pdf'),
          DocumentRequirementModel(
              id: '2',
              title: 'Identity Proof of Proprietor',
              downloadUrl: 'https://example.com/identity-proof-template.pdf'),
          DocumentRequirementModel(
              id: '3',
              title: 'Address Proof of Business Place',)
        ],
        charge: 1000,
        timeRequired: 7,
        description:
        'A trade license is required to legally operate a business in the city.'),
    DocumentModel(
        id: '2',
        name: 'Building Plan Approval',
        requiredDocuments: [
          DocumentRequirementModel(
              id: '1',
              title: 'Building Plan Drawing',),
          DocumentRequirementModel(
              id: '2',
              title: 'Ownership Proof of Land',
              downloadUrl:
              'https://example.com/land-ownership-proof-template.pdf',
              url: 'https://example.com/noc-from-local-authorities-instructions'),
          DocumentRequirementModel(
              id: '3',
              title: 'NOC from Local Authorities',)
        ],
        charge: 5000,
        timeRequired: 30,
        description:
        'Building plan approval is required to construct a building legally.'),
    DocumentModel(
        id: '3',
        name: 'Factory License',
        requiredDocuments: [
          DocumentRequirementModel(
              id: '1',
              title: 'Application Form',),
          DocumentRequirementModel(
              id: '2',
              title: 'Proof of Factory Land Ownership',),
          DocumentRequirementModel(
              id: '3',
              title: 'NOC from Pollution Control Board',),
        ],
        charge: 2500,
        timeRequired: 15,
        description:
        'A factory license is required to operate a factory legally.'),
  ];


}
