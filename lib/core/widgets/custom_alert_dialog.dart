import 'package:flutter/material.dart';

class CustomAlertDialog {
  static void showLoading({
    required BuildContext context,
    required String loadingText,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).focusColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        content: Row(
          children: [
            CircularProgressIndicator(color: Theme.of(context).canvasColor),
            SizedBox(width: 20),
            Text(loadingText, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }

  static void hideLoading(BuildContext context) {
    Navigator.of(context).pop();
  }

  static void showMessage({
    bool barrierDismissible = true,
    required BuildContext context,
    required String message,
    String? title,
    String? postActionName,
    Function? onPostActionPressed,
    String? negActionName,
    Function? onNegActionPressed,
  }) {
    List<Widget> actions = [];

    if (postActionName != null) {
      actions.add(
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            if (onPostActionPressed != null) {
              onPostActionPressed.call();
            }
          },
          child: Text(
            postActionName,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      );
    }

    if (negActionName != null) {
      actions.add(
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            if (onNegActionPressed != null) {
              onNegActionPressed.call();
            }
          },
          child: Text(
            negActionName,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      );
    }

    showDialog(
      barrierDismissible: barrierDismissible,
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).focusColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(title ?? "", style: Theme.of(context).textTheme.bodyMedium),
        content: Text(message, style: Theme.of(context).textTheme.bodyMedium),
        actions: actions,
      ),
    );
  }
}
