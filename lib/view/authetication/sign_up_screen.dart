import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/Firebase-Firestore/firebase_auth_utils.dart';
import '../../core/Firebase-Firestore/firebase_utils.dart';
import '../../core/Firebase-Firestore/models/user_model.dart';
import '../../core/utils/app_assets.dart';
import '../../core/utils/app_colors.dart';
import '../../core/utils/app_routes.dart';
import '../../core/utils/app_styles.dart';
import '../../core/utils/validators.dart';
import '../../core/widgets/custom_alert_dialog.dart';
import '../../core/widgets/custom_elavated button.dart';
import '../../core/widgets/custom_text_form_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController rePasswordController = TextEditingController();
  final TextEditingController locationController = TextEditingController();

  bool _isPasswordHidden = true;
  bool _isRePasswordHidden = true;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    rePasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Register".tr(),
          style: AppStyles.medium16blue.copyWith(fontSize: 20.sp),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back, color: AppColors.bluePrimaryColor),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 12.h),
                Image.asset(AppAssets.auth_logo, height: 180.h, width: 180.w),
                SizedBox(height: 24.h),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      CustomTextFormField(
                        textEditingController: nameController,
                        hintText: "Name".tr(),
                        prefixIcon: Icon(
                          Icons.person,
                          color: Colors.grey,
                          size: 22.sp,
                        ),
                        validator: Validators.validateUsername,
                      ),
                      SizedBox(height: 16.h),
                      CustomTextFormField(
                        textEditingController: emailController,
                        hintText: "Email".tr(),
                        prefixIcon: Icon(
                          Icons.email,
                          color: Colors.grey,
                          size: 22.sp,
                        ),
                        validator: Validators.validateEmail,
                      ),
                      SizedBox(height: 16.h),
                      CustomTextFormField(
                        hintText: 'Location'.tr(),
                        prefixIcon: const Icon(
                          Icons.location_on,
                          color: Colors.grey,
                        ),
                        validator: (value) =>
                            Validators.validateField(value, 'Location'),
                        textEditingController: locationController,
                      ),
                      SizedBox(height: 16.h),
                      CustomTextFormField(
                        textEditingController: passwordController,
                        hintText: "Password".tr(),
                        obscureText: _isPasswordHidden,
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Colors.grey,
                          size: 22.sp,
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
                        validator: Validators.validatePassword,
                      ),
                      SizedBox(height: 16.h),
                      CustomTextFormField(
                        textEditingController: rePasswordController,
                        hintText: "Re Password".tr(),
                        obscureText: _isRePasswordHidden,
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Colors.grey,
                          size: 22.sp,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () => setState(
                            () => _isRePasswordHidden = !_isRePasswordHidden,
                          ),
                          icon: Icon(
                            _isRePasswordHidden
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.grey,
                          ),
                        ),
                        validator: (val) => Validators.validateConfirmPassword(
                          val,
                          passwordController.text,
                        ),
                      ),
                      SizedBox(height: 24.h),
                      SizedBox(
                        width: double.infinity,
                        height: 56.h,
                        child: CustomElevatedButton(
                          onPressed: signUp,
                          buttonText: Text(
                            "Create Account".tr(),
                            style: AppStyles.bold20white.copyWith(
                              fontSize: 20.sp,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already Have Account ? ".tr(),
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => Navigator.pushNamed(
                              context,
                              AppRoutes.signInRoute,
                            ),
                            child: Text(
                              "Login".tr(),
                              style: AppStyles.medium16blue.copyWith(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),
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

  void signUp() async {
    if (formKey.currentState!.validate()) {
      CustomAlertDialog.showLoading(
        context: context,
        loadingText: 'loading...',
      );
      try {
        // 1. Create Auth Account
        UserCredential userCredential = await FirebaseAuthUtils.signUp(
          email: emailController.text,
          password: passwordController.text,
        );

        // 2. Create User Model
        UserModel newUser = UserModel(
          id: userCredential.user!.uid,
          name: nameController.text,
          email: emailController.text,
          location: locationController.text, // From the new field
        );

        // 3. Save to Firestore
        await FirebaseUtils.addUserToFireStore(newUser);

        CustomAlertDialog.hideLoading(context);
        Navigator.pushReplacementNamed(context, AppRoutes.signInRoute);
      } on FirebaseAuthException catch (e) {
        CustomAlertDialog.hideLoading(context);
        CustomAlertDialog.showMessage(
          context: context,
          message: e.message ?? "Error",
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
}
