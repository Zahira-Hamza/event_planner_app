import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/Firebase-Firestore/firebase_auth_utils.dart';
import '../../core/Firebase-Firestore/firebase_utils.dart';
import '../../core/Firebase-Firestore/models/user_model.dart';

class UserProvider extends ChangeNotifier {
  UserModel? currentUser;
  bool isUploadingPhoto = false;

  Future<void> fetchCurrentUser() async {
    final uid = FirebaseAuthUtils.getCurrentUser()?.uid;
    if (uid != null) {
      currentUser = await FirebaseUtils.getUserFromFireStore(uid);
      notifyListeners();
    }
  }

  Future<void> pickAndUploadPhoto() async {
    final picker = ImagePicker();
    final XFile? picked = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 60, // keep well under Firestore 1MB doc limit
      maxWidth: 400, // ~400px is plenty for a profile avatar
    );
    if (picked == null) return;

    final uid = FirebaseAuthUtils.getCurrentUser()?.uid;
    if (uid == null) return;

    isUploadingPhoto = true;
    notifyListeners();

    try {
      // Read bytes → encode as base64 string
      final bytes = await File(picked.path).readAsBytes();
      final base64String = base64Encode(bytes);

      // Prefix with mime type so we can decode it back to an image
      final dataUrl = 'data:image/jpeg;base64,$base64String';

      // Save to Firestore (no Storage needed)
      await FirebaseUtils.updateUserPhoto(uid, dataUrl);

      // Clear Flutter's image cache so the old avatar is evicted immediately
      PaintingBinding.instance.imageCache.clear();
      PaintingBinding.instance.imageCache.clearLiveImages();

      // Replace the whole currentUser object — triggers Consumer rebuild
      currentUser = UserModel(
        id: currentUser!.id,
        name: currentUser!.name,
        email: currentUser!.email,
        location: currentUser!.location,
        photoUrl: dataUrl,
      );
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
