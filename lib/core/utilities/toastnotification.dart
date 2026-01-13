import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app_2025/core/helper/const.dart';
import 'package:toastification/toastification.dart';

class ToastNotification {
  static void minimalToastNotificationService({
    ToastificationType toastNotificationType = ToastificationType.success,
    String title = 'Hello , World!',
    String description = 'This is a sample toast message.',
    bool languageIsArabic = false,
    required Function(ToastificationItem)? onAutoCompleteCompleted,
  }) {
    toastification.show(
      //      context: context, // optional if you use ToastificationWrapper
      type: toastNotificationType,
      style: ToastificationStyle.minimal,
      autoCloseDuration: const Duration(seconds: 3),
      title: Text(
        title,
        style: TextStyle(
          color: _colorByState(toastNotificationType: toastNotificationType),
          fontSize: 16,
        ),
      ),
      progressBarTheme: ProgressIndicatorThemeData(
        color: _colorByState(toastNotificationType: toastNotificationType),
        linearMinHeight: 2,
      ),
      // you can also use RichText widget for title and description parameters
      description: RichText(
        text: TextSpan(
          text: description,
          style: const TextStyle(color: Colors.black, fontSize: 12),
        ),
      ),
      direction: languageIsArabic ? TextDirection.rtl : TextDirection.ltr,
      animationDuration: const Duration(milliseconds: 300),
      animationBuilder: (context, animation, alignment, child) {
        return FadeTransition(opacity: animation, child: child);
      },
      icon: Icon(
        _iconByState(toastNotificationType: toastNotificationType),
        color: _colorByState(toastNotificationType: toastNotificationType),
      ),
      showIcon: true,
      // show or hide the icon
      primaryColor: _colorByState(toastNotificationType: toastNotificationType),
      backgroundColor: Colors.white,
      foregroundColor: _colorByState(
        toastNotificationType: toastNotificationType,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      borderRadius: BorderRadius.circular(12),
      boxShadow: const [
        BoxShadow(
          color: Color(0x07000000),
          blurRadius: 16,
          offset: Offset(0, 16),
          spreadRadius: 0,
        ),
      ],
      showProgressBar: true,
      closeButton: ToastCloseButton(
        showType: CloseButtonShowType.onHover,
        buttonBuilder: (context, onClose) {
          return OutlinedButton.icon(
            onPressed: onClose,
            icon: const Icon(Icons.close, size: 20),
            label: const Text('Close'),
          );
        },
      ),
      closeOnClick: false,
      pauseOnHover: true,
      dragToClose: true,
      //applyBlurEffect: true,
      callbacks: ToastificationCallbacks(
        onAutoCompleteCompleted: onAutoCompleteCompleted,
      ),
    );
  }

  static void flatToastNotificationService({
    ToastificationType toastNotificationType = ToastificationType.success,
    String title = 'Hello , World!',
    String description = 'This is a sample toast message.',
    bool languageIsArabic = false,
    required Function(ToastificationItem)? onAutoCompleteCompleted,
  }) {
    toastification.show(
      //      context: context, // optional if you use ToastificationWrapper
      type: toastNotificationType,
      style: ToastificationStyle.flat,
      autoCloseDuration: const Duration(seconds: 3),
      title: Text(
        title,
        style: TextStyle(
          color: _colorByState(toastNotificationType: toastNotificationType),
        ),
      ),
      progressBarTheme: ProgressIndicatorThemeData(
        color: _colorByState(toastNotificationType: toastNotificationType),
        linearMinHeight: 2,
      ),
      // you can also use RichText widget for title and description parameters
      description: RichText(
        text: TextSpan(
          text: description,
          style: const TextStyle(color: Colors.black),
        ),
      ),
      direction: languageIsArabic ? TextDirection.rtl : TextDirection.ltr,
      animationDuration: const Duration(milliseconds: 300),
      animationBuilder: (context, animation, alignment, child) {
        return FadeTransition(opacity: animation, child: child);
      },
      icon: Icon(
        _iconByState(toastNotificationType: toastNotificationType),
        color: _colorByState(toastNotificationType: toastNotificationType),
      ),
      showIcon: true,
      // show or hide the icon
      primaryColor: _colorByState(toastNotificationType: toastNotificationType),
      backgroundColor: Colors.white,
      foregroundColor: _colorByState(
        toastNotificationType: toastNotificationType,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      borderRadius: BorderRadius.circular(12),
      boxShadow: const [
        BoxShadow(
          color: Color(0x07000000),
          blurRadius: 16,
          offset: Offset(0, 16),
          spreadRadius: 0,
        ),
      ],
      showProgressBar: true,
      closeButton: ToastCloseButton(
        showType: CloseButtonShowType.onHover,
        buttonBuilder: (context, onClose) {
          return OutlinedButton.icon(
            onPressed: onClose,
            icon: const Icon(Icons.close, size: 20),
            label: const Text('Close'),
          );
        },
      ),
      closeOnClick: false,
      pauseOnHover: true,
      dragToClose: true,
      //applyBlurEffect: true,
      callbacks: ToastificationCallbacks(
        onAutoCompleteCompleted: onAutoCompleteCompleted,
      ),
    );
  }

  static void fillColoredToastNotificationService({
    ToastificationType toastNotificationType = ToastificationType.success,
    String title = 'Hello , World!',
    String description = 'This is a sample toast message.',
    bool languageIsArabic = false,
    required Function(ToastificationItem)? onAutoCompleteCompleted,
  }) {
    toastification.show(
      //      context: context, // optional if you use ToastificationWrapper
      type: toastNotificationType,
      style: ToastificationStyle.fillColored,
      autoCloseDuration: const Duration(seconds: 3),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      progressBarTheme: const ProgressIndicatorThemeData(
        color: Colors.white,
        linearTrackColor: Colors.white30,
        linearMinHeight: 2,
      ),
      // you can also use RichText widget for title and description parameters
      description: RichText(
        text: TextSpan(
          text: description,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      direction: languageIsArabic ? TextDirection.rtl : TextDirection.ltr,
      animationDuration: const Duration(milliseconds: 300),
      animationBuilder: (context, animation, alignment, child) {
        return FadeTransition(opacity: animation, child: child);
      },
      icon: Icon(
        _iconByState(toastNotificationType: toastNotificationType),
        color: Colors.white,
      ),
      showIcon: true,
      // show or hide the icon
      primaryColor: _colorByState(
        toastNotificationType: toastNotificationType,
      ).withAlpha(124),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      borderRadius: BorderRadius.circular(12),
      boxShadow: const [
        BoxShadow(
          color: Color(0x07000000),
          blurRadius: 16,
          offset: Offset(0, 16),
          spreadRadius: 0,
        ),
      ],
      showProgressBar: true,

      closeButton: ToastCloseButton(
        showType: CloseButtonShowType.onHover,
        buttonBuilder: (context, onClose) {
          return OutlinedButton.icon(
            onPressed: onClose,
            icon: const Icon(Icons.close, size: 20),
            label: const Text('Close'),
          );
        },
      ),
      closeOnClick: false,
      pauseOnHover: true,
      dragToClose: true,
      applyBlurEffect: true,
      callbacks: ToastificationCallbacks(
        onAutoCompleteCompleted: onAutoCompleteCompleted,
      ),
    );
  }

  static void flatColoredToastNotificationService({
    ToastificationType toastNotificationType = ToastificationType.success,
    String title = 'Hello , World!',
    String description = 'This is a sample toast message.',
    bool languageIsArabic = false,
    required Function(ToastificationItem)? onAutoCompleteCompleted,
  }) {
    toastification.show(
      //      context: context, // optional if you use ToastificationWrapper
      type: toastNotificationType,
      style: ToastificationStyle.flatColored,
      autoCloseDuration: const Duration(seconds: 3),
      title: Text(
        title,
        style: TextStyle(
          color: _colorByState(toastNotificationType: toastNotificationType),
        ),
      ),
      progressBarTheme: ProgressIndicatorThemeData(
        color: _colorByState(toastNotificationType: toastNotificationType),
        linearMinHeight: 2,
      ),
      // you can also use RichText widget for title and description parameters
      description: RichText(
        text: TextSpan(
          text: description,
          style: const TextStyle(color: Colors.black),
        ),
      ),
      direction: languageIsArabic ? TextDirection.rtl : TextDirection.ltr,
      animationDuration: const Duration(milliseconds: 300),
      animationBuilder: (context, animation, alignment, child) {
        return FadeTransition(opacity: animation, child: child);
      },
      icon: Icon(
        _iconByState(toastNotificationType: toastNotificationType),
        color: _colorByState(toastNotificationType: toastNotificationType),
      ),
      showIcon: true,
      // show or hide the icon
      primaryColor: _colorByState(toastNotificationType: toastNotificationType),
      backgroundColor: Colors.white,
      foregroundColor: _colorByState(
        toastNotificationType: toastNotificationType,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      borderRadius: BorderRadius.circular(12),
      boxShadow: const [
        BoxShadow(
          color: Color(0x07000000),
          blurRadius: 16,
          offset: Offset(0, 16),
          spreadRadius: 0,
        ),
      ],
      showProgressBar: true,
      closeButton: ToastCloseButton(
        showType: CloseButtonShowType.onHover,
        buttonBuilder: (context, onClose) {
          return OutlinedButton.icon(
            onPressed: onClose,
            icon: const Icon(Icons.close, size: 20),
            label: const Text('Close'),
          );
        },
      ),
      closeOnClick: false,
      pauseOnHover: true,
      dragToClose: true,
      //applyBlurEffect: true,
      callbacks: ToastificationCallbacks(
        onAutoCompleteCompleted: onAutoCompleteCompleted,
      ),
    );
  }

  static IconData _iconByState({
    required ToastificationType toastNotificationType,
  }) {
    if (toastNotificationType == ToastificationType.success) {
      return Icons.check_circle_outline_outlined;
    } else if (toastNotificationType == ToastificationType.info) {
      return Icons.error_outline;
    } else if (toastNotificationType == ToastificationType.warning) {
      return Icons.warning_amber;
    } else if (toastNotificationType == ToastificationType.error) {
      return Icons.cancel_outlined;
    }
    return Icons.check_circle_outline_outlined;
  }

  static Color _colorByState({
    required ToastificationType toastNotificationType,
  }) {
    if (toastNotificationType == ToastificationType.success) {
      return kPrimaryColor;
    } else if (toastNotificationType == ToastificationType.info) {
      return Colors.brown;
    } else if (toastNotificationType == ToastificationType.warning) {
      return kPrimaryWrongColor;
    } else if (toastNotificationType == ToastificationType.error) {
      return kPrimaryWrongColor;
    }
    return kPrimaryColor;
  }
}
