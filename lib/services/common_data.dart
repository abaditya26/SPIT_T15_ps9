import 'package:securing_documents/models/reg_documents_model.dart';
import 'package:securing_documents/models/user_document_model.dart';

class CommonData {
  static List<DocumentModel> documents = [
    DocumentModel(
        id: '1',
        name: 'Trade License',
        requiredDocuments: [
          DocumentRequirementModel(
              id: '1',
              title: 'Application Form',
              isRequired: true,
              downloadUrl:
                  'https://example.com/trade-license-application-form.pdf'),
          DocumentRequirementModel(
              id: '2',
              title: 'Identity Proof of Proprietor',
              isRequired: true,
              downloadUrl: 'https://example.com/identity-proof-template.pdf'),
          DocumentRequirementModel(
            id: '3',
            title: 'Address Proof of Business Place',
            isRequired: false,
          )
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
            title: 'Building Plan Drawing',
            isRequired: true,
          ),
          DocumentRequirementModel(
              id: '2',
              title: 'Ownership Proof of Land',
              downloadUrl:
                  'https://example.com/land-ownership-proof-template.pdf',
              isRequired: true,),
          DocumentRequirementModel(
            id: '3',
            title: 'NOC from Local Authorities',
            isRequired: true,
          )
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
              id: '1', title: 'Application Form', isRequired: true),
          DocumentRequirementModel(
            id: '2',
            title: 'Proof of Factory Land Ownership',
            isRequired: true,
          ),
          DocumentRequirementModel(
            id: '3',
            title: 'NOC from Pollution Control Board',
            isRequired: true,
          ),
        ],
        charge: 2500,
        timeRequired: 15,
        description:
            'A factory license is required to operate a factory legally.'),
  ];
}
