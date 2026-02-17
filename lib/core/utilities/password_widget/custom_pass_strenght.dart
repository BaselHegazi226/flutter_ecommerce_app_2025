import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/bx.dart';
import 'package:iconify_flutter/icons/material_symbols.dart';

import '../../../generated/l10n.dart';
import 'custom_password_strength.dart';

enum StrengthEnum { empty, weak, medium, strong, secure }

class CustomPassStrength {
  /// 🔥 ترجع النص حسب اللغة الحالية
  String getStatus(BuildContext context, StrengthEnum strengthEnum) {
    switch (strengthEnum) {
      case StrengthEnum.empty:
        return S.of(context).empty_password;
      case StrengthEnum.weak:
        return S.of(context).weak_password;
      case StrengthEnum.medium:
        return S.of(context).medium_password;
      case StrengthEnum.strong:
        return S.of(context).strong_password;
      case StrengthEnum.secure:
        return S.of(context).secure_password;
    }
  }

  /// 🔥 Widget ديناميكي حسب اللغة
  Widget buildStatusWidget(BuildContext context, StrengthEnum strengthEnum) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Iconify(
          _getIcon(strengthEnum),
          color: customStatusColor(strengthEnum),
          size: 18,
        ),
        const SizedBox(width: 6),
        Text(
          getStatus(context, strengthEnum),
          style: TextStyle(
            color: customStatusColor(strengthEnum),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  String _getIcon(StrengthEnum strengthEnum) {
    switch (strengthEnum) {
      case StrengthEnum.empty:
        return MaterialSymbols.hourglass_empty_rounded; // widget;
      case StrengthEnum.weak:
        return Bx.error_circle;
      case StrengthEnum.medium:
        return Bx.bxs_adjust;
      case StrengthEnum.strong:
        return Bx.check_circle;
      case StrengthEnum.secure:
        return Bx.lock;
    }
  }

  Color customStatusColor(StrengthEnum strengthEnum) {
    switch (strengthEnum) {
      case StrengthEnum.empty:
        return Colors.blue;
      case StrengthEnum.weak:
        return Colors.red;
      case StrengthEnum.medium:
        return Colors.orange;
      case StrengthEnum.strong:
        return Colors.green;
      case StrengthEnum.secure:
        return const Color(0xFF0B6C0E);
    }
  }

  static StrengthEnum calculate({required String password}) {
    if (password.isEmpty) {
      return StrengthEnum.empty;
    }

    final int strength = CustomPasswordStrength.calculatePasswordStrength(
      password: password,
    );

    if (strength > 90) {
      return StrengthEnum.secure;
    } else if (strength >= 75) {
      return StrengthEnum.strong;
    } else if (strength >= 50) {
      return StrengthEnum.medium;
    } else {
      return StrengthEnum.weak;
    }
  }
}
