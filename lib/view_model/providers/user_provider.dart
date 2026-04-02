import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/Firebase-Firestore/firebase_auth_utils.dart';
import '../../core/Firebase-Firestore/firebase_utils.dart';
import '../../core/Firebase-Firestore/models/user_model.dart';

class UserProvider extends ChangeNotifier {
  UserModel? currentUser;
  bool isUploadingPhoto = false;

  Future<void> fetchCurrentUser() async {
    String? uid = FirebaseAuthUtils.getCurrentUser()?.uid;
    if (uid != null) {
      currentUser = await FirebaseUtils.getUserFromFireStore(uid);
      notifyListeners();
    }
  }

  Future<void> pickAndUploadPhoto() async {
    final picker = ImagePicker();
    final XFile? picked = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 70,
      maxWidth: 512,
    );
    if (picked == null) return;

    final uid = FirebaseAuthUtils.getCurrentUser()?.uid;
    if (uid == null) return;

    isUploadingPhoto = true;
    notifyListeners();

    try {
      final ref = FirebaseStorage.instance
          .ref()
          .child('profile_photos')
          .child('$uid.jpg');

      await ref.putFile(File(picked.path));
      final url = await ref.getDownloadURL();

      await FirebaseUtils.updateUserPhoto(uid, url);
      currentUser = currentUser?.copyWith(photoUrl: url);
    } catch (e) {
      debugPrint('Photo upload error: $e');
    } finally {
      isUploadingPhoto = false;
      notifyListeners();
    }
  }

  void resetUser() {
    currentUser = null;
    notifyListeners();
  }
}
