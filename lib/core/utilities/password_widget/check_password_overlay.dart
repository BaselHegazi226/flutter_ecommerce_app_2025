import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_text.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/password_widget/custom_pass_strenght.dart';
import 'package:flutter_e_commerce_app_2025/generated/l10n.dart';

import 'check_item.dart';
import 'custom_password_strength.dart';

class CheckPasswordOverlay {
  OverlayEntry? _overlayEntry;

  final LayerLink layerLink;
  final ValueNotifier<StrengthEnum?> passNotifier;
  final TextEditingController controller;
  final FocusNode focusNode;

  late final VoidCallback _focusListener;

  CheckPasswordOverlay({
    required this.layerLink,
    required this.passNotifier,
    required this.controller,
    required this.focusNode,
  }) {
    _initListener();
  }

  void _initListener() {
    _focusListener = () {
      if (focusNode.hasFocus) {
        _showOverlay();
      } else {
        _hideOverlay();
      }
    };

    focusNode.addListener(_focusListener);
  }

  void _showOverlay() {
    if (_overlayEntry != null) return;

    final context = focusNode.context;
    if (context == null) return;

    final size = MediaQuery.sizeOf(context);

    _overlayEntry = OverlayEntry(
      builder: (context) {
        return Positioned.fill(
          child: Stack(
            children: [
              /// 👇 Tap خارج الحقل → unfocus
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () => focusNode.unfocus(),
              ),

              /// 👇 الـ Overlay نفسه
              CompositedTransformFollower(
                link: layerLink,
                showWhenUnlinked: false,
                offset: Offset(0, -(size.height * 0.3)),
                child: Material(
                  color: Colors.transparent,
                  elevation: 4,
                  child: IntrinsicHeight(
                    child: Container(
                      width: size.width * .8,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xffD8D8DC),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 8,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// 🔥 نسبة القوة
                          ValueListenableBuilder<TextEditingValue>(
                            valueListenable: controller,
                            builder: (context, value, _) {
                              final strengthPercentage =
                                  CustomPasswordStrength.calculatePasswordStrength(
                                    password: value.text,
                                  );

                              return CustomText(
                                color: Colors.black87,
                                text:
                                    '${S.of(context).password_strength}: $strengthPercentage%',
                                fontSize: 10,
                              );
                            },
                          ),

                          const SizedBox(height: 8),

                          /// 🔥 الشريط
                          CustomPasswordStrengthBar(
                            strengthNotifier: passNotifier,
                          ),

                          const SizedBox(height: 8),

                          CustomText(
                            color: Colors.black87,
                            text: S.of(context).password_requirement,
                            fontSize: 10,
                          ),

                          const SizedBox(height: 8),

                          /// 🔥 الشروط
                          ValueListenableBuilder<TextEditingValue>(
                            valueListenable: controller,
                            builder: (context, value, _) {
                              final password = value.text;

                              final has8 = password.length >= 8;
                              final hasUpper = RegExp(
                                r'[A-Z]',
                              ).hasMatch(password);
                              final hasLower = RegExp(
                                r'[a-z]',
                              ).hasMatch(password);
                              final hasNumber = RegExp(
                                r'[0-9]',
                              ).hasMatch(password);
                              final hasSpecial = RegExp(
                                r'[!@#$%^&*(),.?":{}|<>]',
                              ).hasMatch(password);

                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CheckItem(
                                    itemText: S
                                        .of(context)
                                        .at_least_8_character,
                                    isValid: has8,
                                  ),
                                  CheckItem(
                                    itemText: S
                                        .of(context)
                                        .at_least_1_uppercase_letter,
                                    isValid: hasUpper,
                                  ),
                                  CheckItem(
                                    itemText: S
                                        .of(context)
                                        .at_least_1_lowercase_letter,
                                    isValid: hasLower,
                                  ),
                                  CheckItem(
                                    itemText: S.of(context).at_least_1_number,
                                    isValid: hasNumber,
                                  ),
                                  CheckItem(
                                    itemText: S
                                        .of(context)
                                        .at_least_1_special_character,
                                    isValid: hasSpecial,
                                  ),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );

    Overlay.of(context, rootOverlay: true).insert(_overlayEntry!);
  }

  void _hideOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void dispose() {
    focusNode.removeListener(_focusListener);
    _hideOverlay();
  }
}

class CustomPasswordStrengthBar extends StatelessWidget {
  const CustomPasswordStrengthBar({
    super.key,
    required this.strengthNotifier,
    this.height = 8,
    this.animationDuration = const Duration(milliseconds: 400),
    this.showStatus = true,
  });

  final ValueNotifier<StrengthEnum?> strengthNotifier;
  final double height;
  final Duration animationDuration;
  final bool showStatus;

  @override
  Widget build(BuildContext context) {
    final helper = CustomPassStrength();

    return ValueListenableBuilder<StrengthEnum?>(
      valueListenable: strengthNotifier,
      builder: (_, strength, __) {
        final double widthFactor = _getWidthFactor(strength);
        final Color color = strength != null
            ? helper.customStatusColor(strength)
            : Colors.grey;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedContainer(
              duration: animationDuration,
              height: height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.grey.shade300,
              ),
              child: LayoutBuilder(
                builder: (_, constraints) {
                  return AnimatedContainer(
                    duration: animationDuration,
                    width: constraints.maxWidth * widthFactor,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: color,
                    ),
                  );
                },
              ),
            ),

            if (showStatus && strength != null) ...[
              const SizedBox(height: 8),
              helper.buildStatusWidget(context, strength),
            ],
          ],
        );
      },
    );
  }

  double _getWidthFactor(StrengthEnum? strength) {
    switch (strength) {
      case StrengthEnum.empty:
        return 0.05;
      case StrengthEnum.weak:
        return 0.25;
      case StrengthEnum.medium:
        return 0.5;
      case StrengthEnum.strong:
        return 0.75;
      case StrengthEnum.secure:
        return 1.0;
      default:
        return 0.0;
    }
  }
}
