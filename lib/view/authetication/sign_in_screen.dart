import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/Firebase-Firestore/firebase_auth_utils.dart';
import '../../core/utils/app_assets.dart';
import '../../core/utils/app_colors.dart';
import '../../core/utils/app_routes.dart';
import '../../core/utils/app_styles.dart';
import '../../core/utils/validators.dart';
import '../../core/widgets/custom_alert_dialog.dart';
import '../../core/widgets/custom_elavated button.dart';
import '../../core/widgets/custom_text_form_field.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
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
          padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset(AppAssets.auth_logo, height: 180.h, width: 180.w),
                SizedBox(height: 24.h),
                Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CustomTextFormField(
                        textEditingController: emailController,
                        validator: Validators.validateEmail,
                        hintText: "Email".tr(),
                        prefixIcon: Icon(
                          Icons.email,
                          color: Colors.grey,
                          size: 20.sp,
                        ),
                      ),
                      SizedBox(height: 16.h),
                      CustomTextFormField(
                        textEditingController: passwordController,
                        validator: Validators.validatePassword,
                        obscureText: _isPasswordHidden,
                        hintText: "Password".tr(),
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Colors.grey,
                          size: 20.sp,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () => setState(
                            () => _isPasswordHidden = !_isPasswordHidden,
                          ),
                          icon: Icon(
                            _isPasswordHidden
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () => Navigator.pushNamed(
                            context,
                            AppRoutes.forgetPasswordRoute,
                          ),
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
                            style: AppStyles.bold20white.copyWith(
                              fontSize: 20.sp,
                            ),
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
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pushNamed(
                              context,
                              AppRoutes.signUpRoute,
                            ),
                            child: Text(
                              "Create Account".tr(),
                              style: AppStyles.medium16blue.copyWith(
                                fontSize: 16.sp,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.h),
                        child: Row(
                          children: [
                            const Expanded(child: Divider()),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              child: Text(
                                "Or".tr(),
                                style: TextStyle(fontSize: 14.sp),
                              ),
                            ),
                            const Expanded(child: Divider()),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: loginWithGoogle,
                        child: Container(
                          height: 56.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(
                              color: AppColors.bluePrimaryColor,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(AppAssets.google_icon, height: 24.h),
                              SizedBox(width: 12.w),
                              Text(
                                "Login With Google".tr(),
                                style: AppStyles.medium16blue.copyWith(
                                  fontSize: 18.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
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

  void login() async {
    if (formKey.currentState!.validate()) {
      CustomAlertDialog.showLoading(
        context: context,
        loadingText: 'loading...',
      );
      try {
        await FirebaseAuthUtils.login(
          email: emailController.text,
          password: passwordController.text,
        );
        CustomAlertDialog.hideLoading(context);
        CustomAlertDialog.showMessage(
          context: context,
          message: 'Login Success',
          title: 'Success',
          postActionName: 'ok',
          onPostActionPressed: () =>
              Navigator.pushReplacementNamed(context, AppRoutes.homeRoute),
        );
      } on FirebaseAuthException catch (e) {
        CustomAlertDialog.hideLoading(context);
        String errorMsg = "An error occurred";
        if (e.code == 'invalid-credential')
          errorMsg = 'Invalid email or password';
        if (e.code == 'network-request-failed')
          errorMsg = 'Network request failed.';

        CustomAlertDialog.showMessage(
          context: context,
          message: errorMsg,
          title: 'Error',
        );
      } catch (e) {
        CustomAlertDialog.hideLoading(context);
        CustomAlertDialog.showMessage(
          context: context,
          message: e.toString(),
          title: 'Error',
        );
      }
    }
  }

  void loginWithGoogle() async {
    CustomAlertDialog.showLoading(context: context, loadingText: 'loading...');

    try {
      final userCredential = await FirebaseAuthUtils.signInWithGoogle();

      CustomAlertDialog.hideLoading(context);

      if (userCredential != null) {
        CustomAlertDialog.showMessage(
          context: context,
          message: 'Login Success',
          title: 'Success',
          postActionName: 'ok',
          onPostActionPressed: () =>
              Navigator.pushReplacementNamed(context, AppRoutes.homeRoute),
        );
      }
    } on FirebaseAuthException catch (e) {
      CustomAlertDialog.hideLoading(context);
      CustomAlertDialog.showMessage(
        context: context,
        message: e.message ?? "An error occurred during Google Sign-In",
        title: 'Error',
      );
    } catch (e) {
      CustomAlertDialog.hideLoading(context);
      // Handle user cancelling the picker (e will be null or specific error)
      if (e.toString() != "null") {
        CustomAlertDialog.showMessage(
          context: context,
          message: e.toString(),
          title: 'Error',
        );
      }
    }
  }
}
