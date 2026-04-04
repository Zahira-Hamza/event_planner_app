import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';

/// Displays the user profile photo from a base64 data URL stored in Firestore.
/// Falls back to the default profile asset when [dataUrl] is null or invalid.
class UserAvatar extends StatelessWidget {
  final String? dataUrl;
  final double radius;
  final bool showUploadingSpinner;

  const UserAvatar({
    super.key,
    required this.radius,
    this.dataUrl,
    this.showUploadingSpinner = false,
  });

  /// Decode the base64 data URL → raw bytes.
  /// Returns null if [dataUrl] is null, empty, or malformed.
  static Uint8List? _decode(String? dataUrl) {
    if (dataUrl == null || dataUrl.isEmpty) return null;
    try {
      // Strip the "data:image/jpeg;base64," prefix
      final comma = dataUrl.indexOf(',');
      if (comma == -1) return null;
      return base64Decode(dataUrl.substring(comma + 1));
    } catch (_) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final bytes = _decode(dataUrl);

    return CircleAvatar(
      key: ValueKey(dataUrl), // new dataUrl → new widget → no stale cache
      radius: radius,
      backgroundColor: Colors.white,
      child: ClipOval(
        child: SizedBox(
          width: radius * 2,
          height: radius * 2,
          child: showUploadingSpinner
              ? const CircularProgressIndicator(
                  color: Color(0xff5669FF),
                  strokeWidth: 2.5,
                )
              : bytes != null
              // Base64 image from Firestore
              ? Image.memory(
                  bytes,
                  fit: BoxFit.cover,
                  width: radius * 2,
                  height: radius * 2,
                  gaplessPlayback: true, // no flicker on rebuild
                )
              // Default placeholder asset
              : Image.asset(
                  'assets/images/profile.png',
                  fit: BoxFit.cover,
                  width: radius * 2,
                  height: radius * 2,
                ),
        ),
      ),
    );
  }
}
