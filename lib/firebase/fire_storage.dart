// ignore_for_file: avoid_print

import 'dart:io';
import 'package:chat_app/firebase/fire_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FireStorage {
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  Future<void> sendImage({
    required File file,
    required String roomId,
    required String myUid,
  }) async {
    try {
      String ext = file.path.split('.').last;
      final ref = firebaseStorage.ref().child(
          'images/$roomId/${DateTime.now().millisecondsSinceEpoch}.$ext');

      // Upload the file to Firebase Storage
      UploadTask uploadTask = ref.putFile(file);

      // Wait for the upload to complete and get the download URL
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
      String imageUrl = await taskSnapshot.ref.getDownloadURL();

      await FireData().sendMessage(
        myUid,
        imageUrl,
        roomId,
        type: 'image',
      );
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateProfilePic({
    required File file,
  }) async {
    try {
      String myUid = FirebaseAuth.instance.currentUser!.uid;
      String ext = file.path.split('.').last;
      final ref = firebaseStorage
          .ref()
          .child('profilePic/$myUid/${DateTime.now().millisecondsSinceEpoch}.$ext');

      // Upload the file to Firebase Storage
      UploadTask uploadTask = ref.putFile(file);

      // Wait for the upload to complete and get the download URL
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
      String imageUrl = await taskSnapshot.ref.getDownloadURL();
      FirebaseFirestore.instance
          .collection('users')
          .doc(myUid)
          .update({'image': imageUrl});
    } catch (e) {
      print(e);
    }
  }
}
