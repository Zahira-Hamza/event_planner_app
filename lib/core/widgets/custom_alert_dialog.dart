import 'package:flutter/material.dart';

class CustomAlertDialog {
  static const Color _blue = Color(0xff5669FF);

  // ─── Loading dialog ───────────────────────────────────────────────────────
  static void showLoading({
    required BuildContext context,
    required String loadingText,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        final isDark = Theme.of(ctx).brightness == Brightness.dark;
        return AlertDialog(
          backgroundColor: isDark ? const Color(0xff1E2040) : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          content: Row(
            children: [
              const CircularProgressIndicator(color: _blue),
              const SizedBox(width: 20),
              Text(
                loadingText,
                style: TextStyle(
                  color: isDark ? Colors.white : const Color(0xff1C1C1C),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static void hideLoading(BuildContext context) {
    Navigator.of(context).pop();
  }

  // ─── Message dialog ───────────────────────────────────────────────────────
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
    // Determine dialog type from title to drive icon + accent color
    final titleLower = (title ?? '').toLowerCase();
    final isSuccess = titleLower.contains('success');
    final isError = titleLower.contains('error');

    final Color accent = isSuccess
        ? const Color(0xFF4CAF50)
        : isError
        ? const Color(0xFFEF5350)
        : _blue;

    final IconData icon = isSuccess
        ? Icons.check_circle_rounded
        : isError
        ? Icons.error_rounded
        : Icons.info_rounded;

    showDialog(
      barrierDismissible: barrierDismissible,
      context: context,
      builder: (ctx) {
        final isDark = Theme.of(ctx).brightness == Brightness.dark;
        final bgColor = isDark ? const Color(0xff1E2040) : Colors.white;
        final textColor = isDark ? Colors.white : const Color(0xff1C1C1C);
        final subTextColor = isDark ? Colors.white70 : Colors.grey.shade600;

        return Dialog(
          backgroundColor: bgColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 28, 24, 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Icon badge
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: accent.withOpacity(0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: accent, size: 36),
                ),
                const SizedBox(height: 16),

                // Title
                if (title != null && title.isNotEmpty)
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: textColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                const SizedBox(height: 8),

                // Message
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: subTextColor,
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 24),

                // Action buttons
                Row(
                  children: [
                    if (negActionName != null) ...[
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.of(ctx).pop();
                            onNegActionPressed?.call();
                          },
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: accent),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          child: Text(
                            negActionName,
                            style: TextStyle(
                              color: accent,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                    ],
                    if (postActionName != null)
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(ctx).pop();
                            onPostActionPressed?.call();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: accent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            elevation: 0,
                          ),
                          child: Text(
                            postActionName,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    // If no buttons at all, show a default close button
                    if (postActionName == null && negActionName == null)
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => Navigator.of(ctx).pop(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: accent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            elevation: 0,
                          ),
                          child: const Text(
                            'OK',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
