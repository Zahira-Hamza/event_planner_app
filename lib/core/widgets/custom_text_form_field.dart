import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_styles.dart';

typedef OnValidator = String? Function(String?)?;

class CustomTextFormField extends StatelessWidget {
  final Color borderColor;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final OnValidator? validator;
  final bool obscureText;
  final TextEditingController textEditingController;
  final TextInputType keyboardType;

  const CustomTextFormField({
    super.key,
    this.borderColor = Colors.grey,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.obscureText = false,
    required this.textEditingController,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      validator: validator,
      obscureText: obscureText,
      keyboardType: keyboardType,
      style: AppStyles.medium16black,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: AppStyles.medium16gray,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        // Error style helps text stay visible
        errorStyle: const TextStyle(color: Colors.red),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        enabledBorder: builtDecorationBorder(borderColor: borderColor),
        focusedBorder: builtDecorationBorder(
          borderColor: Theme.of(context).primaryColor,
        ),
        errorBorder: builtDecorationBorder(borderColor: Colors.red),
        focusedErrorBorder: builtDecorationBorder(borderColor: Colors.red),
      ),
    );
  }

  OutlineInputBorder builtDecorationBorder({required Color borderColor}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.r), // Scaled radius
      borderSide: BorderSide(color: borderColor, width: 1.0),
    );
  }
}
