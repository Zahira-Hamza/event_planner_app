import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../view_model/providers/Language_Provider/app_language_provider.dart';

class LanguageBottomSheet extends StatelessWidget {
  const LanguageBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<AppLanguageProvider>(context);
    final current = languageProvider.appLanguage;

    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 32.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
            width: 40.w,
            height: 4.h,
            margin: EdgeInsets.only(bottom: 20.h),
            decoration: BoxDecoration(
              color: Colors.grey.shade400,
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          _LanguageOption(
            title: tr('english'),
            subtitle: 'English',
            isSelected: current == 'en',
            onTap: () async {
              await languageProvider.changeLanguage('en');
              if (context.mounted) {
                context.setLocale(const Locale('en'));
                Navigator.pop(context);
              }
            },
          ),
          SizedBox(height: 12.h),
          _LanguageOption(
            title: tr('arabic'),
            subtitle: 'العربية',
            isSelected: current == 'ar',
            onTap: () async {
              await languageProvider.changeLanguage('ar');
              if (context.mounted) {
                context.setLocale(const Locale('ar'));
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
    );
  }
}

class _LanguageOption extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool isSelected;
  final VoidCallback onTap;

  const _LanguageOption({
    required this.title,
    required this.subtitle,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = isSelected
        ? AppColors.bluePrimaryColor
        : Theme.of(context).textTheme.bodyMedium?.color;

    return ListTile(
      onTap: onTap,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
        side: BorderSide(
          color: isSelected ? AppColors.bluePrimaryColor : Colors.grey.shade400,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: textColor,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          fontSize: 16.sp,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(color: textColor?.withOpacity(0.6), fontSize: 13.sp),
      ),
      trailing: isSelected
          ? Icon(Icons.check_circle, color: AppColors.bluePrimaryColor)
          : null,
    );
  }
}
