import 'package:flutter/material.dart';

import '../utils/app_styles.dart';

typedef OnValidator = String? Function(String?)?;

class CustomTextFormField extends StatelessWidget {
  Color borderColor;
  String? hintText;
  String? labelText;
  TextStyle? hintStyle;
  TextStyle? labelStyle;
  int? maxLines;
  Widget? prefixIcon;

  ///we make it of type widget to have the freedom to send it as icon or image
  Widget? suffixIcon;

  ///we make it of type widget to have the freedom to send it as icon or image
  OnValidator? validator;
  TextInputType keyboardType;
  bool obscureText;
  String? obscuringCharacter;
  TextEditingController textEditingController;
  CustomTextFormField(
      {super.key,
      this.borderColor = Colors.grey,
      this.hintText,
      this.hintStyle,
      this.labelText,
      this.labelStyle,
      this.maxLines,
      this.prefixIcon,
      this.suffixIcon,
      this.validator,
      this.obscureText = false,
      this.obscuringCharacter,
      required this.textEditingController,
      this.keyboardType = TextInputType.text});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: Theme.of(context).textTheme.bodyMedium,
      maxLines: maxLines ?? 1,
      decoration: InputDecoration(
        enabledBorder: builtDecorationBorder(borderColor: borderColor),
        focusedBorder: builtDecorationBorder(borderColor: borderColor),
        errorBorder: builtDecorationBorder(borderColor: Colors.red),
        focusedErrorBorder: builtDecorationBorder(borderColor: Colors.red),
        hintText: hintText,
        hintStyle: hintStyle ?? AppStyles.medium16gray,
        labelText: labelText,
        labelStyle: labelStyle ?? AppStyles.medium16gray,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        errorStyle:
            AppStyles.medium16blue.copyWith(color: Colors.red, fontSize: 14),
      ),
      validator: validator,
      controller: textEditingController,
      keyboardType: keyboardType,
      obscureText: obscureText,
    );
  }

  OutlineInputBorder builtDecorationBorder({borderColor}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(
        color: borderColor,
        width: 1.0,
      ),
    );
  }
}
