import 'package:flutter/material.dart';

class ReusableSnackbar {
  // Generalized showSnackBar method
  static void showSnackBar({
    required BuildContext context,
    required String title,
    required String description,
    Color backgroundColor = Colors.redAccent,
    IconData icon = Icons.alarm,
    Color iconColor = Colors.white,
    Color textColor = Colors.black,
    Duration duration = const Duration(seconds: 3),
    SnackBarBehavior behavior = SnackBarBehavior.floating,
    EdgeInsetsGeometry margin =
        const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: behavior,
        duration: duration,
        margin: margin,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        backgroundColor: backgroundColor,
        content: Row(
          children: [
            Icon(icon, color: iconColor),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    description,
                    style: TextStyle(
                      color: textColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Success Snackbar Helper Method
  static void showSuccessSnackbar({
    required BuildContext context,
    required String description,
  }) {
    showSnackBar(
      context: context,
      title: "Success",
      description: description,
      backgroundColor: Colors.green,
      icon: Icons.check_circle,
      iconColor: Colors.greenAccent,
      textColor: Colors.white,
    );
  }

  // Error Snackbar Helper Method
  static void showErrorSnackbar({
    required BuildContext context,
    required String description,
  }) {
    showSnackBar(
      context: context,
      title: "Error",
      description: description,
      backgroundColor: Colors.red,
      icon: Icons.error,
      iconColor: Colors.redAccent,
      textColor: Colors.white,
    );
  }
}
