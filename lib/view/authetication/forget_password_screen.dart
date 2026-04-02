import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/utils/app_colors.dart';
import '../../core/utils/app_styles.dart';
import '../../core/utils/validators.dart';
import '../../core/widgets/custom_elavated button.dart';
import '../../core/widgets/custom_text_form_field.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Forget Password".tr(),
          style: AppStyles.medium16blue.copyWith(fontSize: 20.sp),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back, color: AppColors.bluePrimaryColor),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(
                "assets/images/forget_password_image.png",
                height: 280.h,
                fit: BoxFit.contain,
              ),
              SizedBox(height: 16.h),
              Text(
                "Enter your email to receive a password reset link.".tr(),
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20.h),
              CustomTextFormField(
                textEditingController: emailController,
                hintText: "Email".tr(),
                prefixIcon: Icon(Icons.email, color: Colors.grey, size: 20.sp),
                validator: Validators.validateEmail,
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 24.h),
              SizedBox(
                width: double.infinity,
                height: 56.h,
                child: CustomElevatedButton(
                  onPressed: _resetPassword,
                  buttonText: Text(
                    "Reset Password".tr(),
                    style: AppStyles.bold20white.copyWith(fontSize: 20.sp),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  void _resetPassword() async {
    if (formKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(
          email: emailController.text.trim(),
        );
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Reset link sent! Check your email.".tr()),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context);
      } on FirebaseAuthException catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.message ?? "An error occurred".tr()),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}
