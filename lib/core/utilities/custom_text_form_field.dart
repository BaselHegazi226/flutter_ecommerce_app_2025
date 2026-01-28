import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app_2025/core/helper/const.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_text.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.text,
    required this.hintText,
    required this.onSaved,
    required this.validator,
    required this.textEditingController,
  });

  final String text, hintText;
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: text,
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        TextFormField(
          onSaved: onSaved,
          validator: validator,
          controller: textEditingController,
          decoration: InputDecoration(
            fillColor: Theme.of(context).scaffoldBackgroundColor,
            hintText: hintText,
            hintStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: kGreyColor,
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).primaryColor.withAlpha(100),
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColor),
            ),
          ),
        ),
      ],
    );
  }
}
