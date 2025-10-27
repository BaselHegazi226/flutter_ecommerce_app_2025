import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app_2025/core/helper/const.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_button.dart';
import 'package:go_router/go_router.dart';

void customAwesomeDialogTrueOrFalse({
  required BuildContext context,
  required bool isSuccess, // Add a parameter to indicate success or failure
  final bool needCancel = false,
  final String title = 'Success process',
  final String description = 'You are in active mode',
  final String buttonText = 'ok',
  final Color dialogStateColor = kPrimaryColor,
  final Color dialogBackgroundColor = Colors.white10,
  final Color dialogBorderColor = Colors.white10,
  final Color titleColor = kPrimaryColor,
  final double titleSize = 24,
  final Color descriptionColor = Colors.white54,
  final double descriptionSize = 18,
  required void Function()? onPressed,
}) {
  // Set success or failure icon and title dynamically
  final iconColor = isSuccess ? kPrimaryColor : kPrimaryWrongColor;
  final dialogTitle = isSuccess ? 'Success process' : 'Failure process';
  final dialogDescription = isSuccess
      ? 'Process completed successfully'
      : 'Process did n\'t complete';
  final dialogButtonColor = isSuccess ? kPrimaryColor : kPrimaryWrongColor;

  AwesomeDialog(
    context: context,
    dialogType: DialogType.noHeader,
    customHeader: Icon(Icons.check_circle, color: iconColor, size: 65),
    dialogBackgroundColor: dialogBackgroundColor,
    width: double.infinity,
    buttonsBorderRadius: BorderRadius.circular(
      MediaQuery.sizeOf(context).width * .02,
    ),
    dismissOnTouchOutside: true,
    dismissOnBackKeyPress: true,
    headerAnimationLoop: false,
    animType: AnimType.scale,
    title: title.isEmpty ? dialogTitle : title,
    desc: description.isEmpty ? dialogDescription : description,
    showCloseIcon: true,
    borderSide: BorderSide(color: dialogBorderColor, width: 2),
    btnOk: CustomButton(
      onPressed: () {
        if (isSuccess) {
          GoRouter.of(context).pop();
        }
        if (onPressed != null) {
          onPressed();
        }
      },
      backgroundColor: dialogButtonColor,
      text: buttonText,
    ),
  ).show();
}

void warningAwesomeDialog(
  BuildContext context, {
  required String title,
  required String description,
  required String buttonAcceptText,
  required String buttonCancelText,
  required void Function()? onPressed,
  void Function()? cancelOnPressed,
  Color okButtonColor = kPrimaryWrongColor,
}) {
  AwesomeDialog(
    context: context,
    dialogType: DialogType.warning,
    animType: AnimType.scale,
    title: title,
    desc: description,
    btnCancelOnPress:
        cancelOnPressed ??
        () {
          GoRouter.of(context).pop();
        },
    btnOkOnPress: onPressed,
    btnOkText: buttonAcceptText,
    btnCancelText: buttonCancelText,
    btnOkColor: okButtonColor,
    btnCancelColor: const Color(0xffFEB800).withAlpha(200),
  ).show();
}

void customAwesomeDialog({
  required BuildContext context,
  final bool needCancel = false,
  final String title = 'Success process',
  final String description = 'You are in active mode',
  final String buttonText = 'ok',
  final Color dialogStateColor = kPrimaryColor,
  final Color dialogBackgroundColor = Colors.white10,
  final Color dialogBorderColor = Colors.white10,
  final Color titleColor = kPrimaryColor,
  final double titleSize = 24,
  final Color descriptionColor = Colors.white54,
  final Color buttonColor = Colors.white54,
  final double descriptionSize = 18,
  final Color iconColor = kPrimaryColor,
  final IconData icon = Icons.check_circle,
  required void Function()? onPressed,
}) {
  // Set success or failure icon and title dynamically

  AwesomeDialog(
    context: context,
    dialogType: DialogType.noHeader,
    customHeader: Icon(icon, color: iconColor, size: 65),
    dialogBackgroundColor: dialogBackgroundColor,
    width: double.infinity,
    buttonsBorderRadius: BorderRadius.circular(
      MediaQuery.sizeOf(context).width * .02,
    ),
    dismissOnTouchOutside: true,
    dismissOnBackKeyPress: true,
    headerAnimationLoop: false,
    animType: AnimType.scale,
    title: title,
    desc: description,
    showCloseIcon: true,
    borderSide: BorderSide(color: dialogBorderColor, width: 2),
    btnOk: CustomButton(
      onPressed: onPressed,
      backgroundColor: buttonColor,
      text: buttonText,
    ),
  ).show();
}
