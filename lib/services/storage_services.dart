// import 'dart:io';
//
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/foundation.dart';
// import 'package:image_picker/image_picker.dart';
//
// class StorageServices {
//   final _storage = FirebaseStorage.instance;
//
//   updateProfileImage(
//       File file,
//       String uid,
//       void Function(double) updateProgress,
//       void Function(String) updateData) async {
//     Uint8List imageData = await XFile(file.path).readAsBytes();
//     final uploadTask = _storage.ref("users/$uid").putData(imageData);
//     uploadTask.snapshotEvents.listen((event) async {
//       switch (event.state) {
//         case TaskState.running:
//           final progress = 100.0 * (event.bytesTransferred / event.totalBytes);
//           updateProgress(progress);
//           break;
//         case TaskState.paused:
//           break;
//         case TaskState.canceled:
//           break;
//         case TaskState.error:
//           break;
//         case TaskState.success:
//           String downloadUrl =
//               await _storage.ref("users/$uid").getDownloadURL();
//           updateData(downloadUrl);
//           break;
//       }
//     });
//   }
// }

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:securing_documents/models/user_document_model.dart';
import 'package:securing_documents/services/auth_services.dart';

class StorageServices {
  final storageRef = FirebaseStorage.instance;
  final _picker = ImagePicker();
  final uid = AuthServices().getUid();

  uploadDocument(DocumentRequirementModel document, BuildContext context,
      Function(DocumentRequirementModel document) uploadImage) async {
    //select document
    try {

      final XFile? file = await _picker.pickImage(source: ImageSource.gallery);

      assert(file!=null);
      //upload document
      Uint8List imageData = await XFile(file!.path).readAsBytes();
      document.fileName = file.name;
      UploadTask uploadTask = storageRef
          .ref("documents/$uid/${document.title}_${file.name}")
          .putData(imageData);
      uploadTask.snapshotEvents.listen((event) async {
        switch (event.state) {
          case TaskState.running:
            // updateProgress(progress);
            break;
          case TaskState.paused:
            break;
          case TaskState.canceled:
            break;
          case TaskState.error:
            break;
          case TaskState.success:
            //Document uploaded to firestore
            document.url = await storageRef
                .ref("documents/$uid/${document.title}_${file.name}")
                .getDownloadURL();
            print(document.fileName);
            uploadImage(document);
            break;
        }
      });
    } catch (e) {
      print("inasasd");
      uploadImage(document);
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Image fetch failed")));
    }
  }

  Future<void> removeImage(DocumentRequirementModel document) async {
    try {
      await storageRef
          .ref("documents/$uid/${document.title}_${document.fileName}")
          .delete();
    } catch (e) {}
  }
}
