import 'package:flutter/material.dart';

void showSafeSnackBar(BuildContext context, String snackText, Color color) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: color.withAlpha(225),
        elevation: 8.0,
        margin: const EdgeInsets.all(10.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        content: Text(
          snackText,
          maxLines: 1,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
            fontFamily: 'cairo',
          ),
        ),
        action: SnackBarAction(
          label: 'Close',
          onPressed: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
          textColor: color,
          backgroundColor: Colors.white,
        ),
      ),
    );
  });
}
