import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/utils/app_assets.dart';
import '../../core/utils/app_colors.dart';
import '../../core/utils/app_routes.dart';
import '../../core/utils/app_styles.dart';
import '../../core/widgets/custom_elavated button.dart';
import '../../core/widgets/custom_text_field.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<SignInScreen> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _isPasswordHidden = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 20.h, // Scaled absolute pixels
            horizontal: 20.w,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset(
                  AppAssets.auth_logo,
                  height: 180.h,
                  width: 180.w,
                ),
                SizedBox(height: 24.h),
                Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CustomTextFormField(
                        textEditingController: emailController,
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return "Email is required".tr();
                          }
                          return null;
                        },
                        hintText: "Email".tr(),
                        prefixIcon:
                            Icon(Icons.email, color: Colors.grey, size: 20.sp),
                      ),
                      SizedBox(height: 16.h),

                      CustomTextFormField(
                        textEditingController: passwordController,
                        validator: (text) {
                          if (text == null || text.trim().isEmpty)
                            return "Password is required".tr();
                          return null;
                        },
                        obscureText: _isPasswordHidden,
                        hintText: "Password".tr(),
                        prefixIcon:
                            Icon(Icons.lock, color: Colors.grey, size: 20.sp),
                        suffixIcon: IconButton(
                          onPressed: () => setState(
                              () => _isPasswordHidden = !_isPasswordHidden),
                          icon: Icon(
                              _isPasswordHidden
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.grey),
                        ),
                      ),

                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, AppRoutes.forgetPasswordRoute);
                          },
                          child: Text(
                            "Forget Password?".tr(),
                            style: AppStyles.medium16blue.copyWith(
                              fontSize: 14.sp,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.h),

                      SizedBox(
                        width: double.infinity,
                        height: 56.h,
                        child: CustomElevatedButton(
                          onPressed: login,
                          buttonText: Text(
                            "Login".tr(),
                            style:
                                AppStyles.bold20white.copyWith(fontSize: 20.sp),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.h),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don’t Have Account ?".tr(),
                            style: TextStyle(
                                fontSize: 16.sp, fontWeight: FontWeight.w500),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pushNamed(
                                context, AppRoutes.signUpRoute),
                            child: Text(
                              "Create Account".tr(),
                              style: AppStyles.medium16blue
                                  .copyWith(fontSize: 16.sp),
                            ),
                          )
                        ],
                      ),

                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.h),
                        child: Row(
                          children: [
                            const Expanded(child: Divider()),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              child: Text("Or".tr(),
                                  style: TextStyle(fontSize: 14.sp)),
                            ),
                            const Expanded(child: Divider()),
                          ],
                        ),
                      ),

                      /// Google login button
                      InkWell(
                        onTap: () {},
                        child: Container(
                          height: 56.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            border:
                                Border.all(color: AppColors.bluePrimaryColor),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(AppAssets.google_icon, height: 24.h),
                              SizedBox(width: 12.w),
                              Text(
                                "Login With Google".tr(),
                                style: AppStyles.medium16blue
                                    .copyWith(fontSize: 18.sp),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),

                /// Language Toggle (Simplified Placeholder for the UI at the bottom)
                Container(
                  padding: EdgeInsets.all(4.r),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.bluePrimaryColor),
                    borderRadius: BorderRadius.circular(25.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(radius: 15.r, child: const Text("🇺🇸")),
                      SizedBox(width: 8.w),
                      CircleAvatar(radius: 15.r, child: const Text("🇪🇬")),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void login() {
    if (formKey.currentState!.validate()) {
      Navigator.pushReplacementNamed(context, AppRoutes.homeRoute);
    }
  }
}
