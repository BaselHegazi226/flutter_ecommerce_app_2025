import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app_2025/core/helper/const.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_text.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/extensions_of_s_localization.dart';
import 'package:flutter_e_commerce_app_2025/generated/l10n.dart';

import 'check_password_overlay.dart';
import 'custom_pass_strenght.dart';
import 'custom_password_strength.dart';

class PasswordWithOverlayBody extends StatefulWidget {
  const PasswordWithOverlayBody({
    super.key,
    required this.controller,
    required this.labelText,
    required this.hintText,
    this.validator,
    this.onSaved,
  });

  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;

  @override
  State<PasswordWithOverlayBody> createState() =>
      _PasswordWithOverlayBodyState();
}

class _PasswordWithOverlayBodyState extends State<PasswordWithOverlayBody> {
  late FocusNode _focusNode;
  late LayerLink _layerLink;
  late CheckPasswordOverlay _overlayController;

  final ValueNotifier<StrengthEnum?> _strengthNotifier = ValueNotifier(
    StrengthEnum.empty,
  );

  final ValueNotifier<bool> _obscureNotifier = ValueNotifier(true);

  @override
  void initState() {
    super.initState();

    _focusNode = FocusNode();
    _layerLink = LayerLink();

    /// 👇 حساب أولي لو فيه قيمة جاهزة
    _strengthNotifier.value = CustomPassStrength.calculate(
      password: widget.controller.text,
    );

    /// 👇 إنشاء Overlay Controller
    _overlayController = CheckPasswordOverlay(
      layerLink: _layerLink,
      passNotifier: _strengthNotifier,
      controller: widget.controller,
      focusNode: _focusNode,
    );
  }

  @override
  void dispose() {
    _overlayController.dispose();
    _focusNode.dispose();
    _strengthNotifier.dispose();
    _obscureNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CompositedTransformTarget(
          link: _layerLink,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),

              Row(
                children: [
                  const Icon(Icons.password_outlined, size: 16),
                  const SizedBox(width: 8),
                  CustomText(
                    text: S.of(context).authPassword,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),

              const SizedBox(height: 8),

              ValueListenableBuilder<bool>(
                valueListenable: _obscureNotifier,
                builder: (context, obscure, _) {
                  return TextFormField(
                    controller: widget.controller,
                    focusNode: _focusNode,
                    obscureText: obscure,
                    onSaved: widget.onSaved,
                    validator: widget.validator,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 16),
                      fillColor: Theme.of(context).scaffoldBackgroundColor,
                      hintText: widget.hintText,
                      hintStyle: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: kGreyColor,
                      ),
                      suffixIcon: TextButton(
                        onPressed: () {
                          _obscureNotifier.value = !obscure;
                        },
                        child: Icon(
                          obscure
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          size: 18,
                          color: isDark ? Colors.grey.shade50 : Colors.black,
                        ),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).primaryColor.withAlpha(100),
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      errorBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: kPrimaryWrongColor),
                      ),
                      focusedErrorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                    onChanged: (value) {
                      _strengthNotifier.value = CustomPassStrength.calculate(
                        password: value,
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),

        const SizedBox(height: 12),

        /// 🔥 Generate Password Button
        ElevatedButton.icon(
          onPressed: () {
            final generatedPassword = CustomPasswordStrength.generatePassword()
                .generate();

            widget.controller.text = generatedPassword;

            _strengthNotifier.value = CustomPassStrength.calculate(
              password: generatedPassword,
            );
          },
          icon: const Icon(Icons.auto_fix_high_rounded),
          label: Text(S.of(context).authGeneratePassword),
        ),
      ],
    );
  }
}
