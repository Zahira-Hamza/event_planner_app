import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../view_model/providers/Theme_Provider/app_theme_provider.dart';

class ThemeBottomSheet extends StatelessWidget {
  const ThemeBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<AppThemeProvider>(context);
    final isDark = themeProvider.isDark;

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
          _buildOption(
            context,
            title: tr("light"),
            isSelected: !isDark,
            icon: Icons.light_mode_rounded,
            onTap: () async {
              await themeProvider.changeTheme(ThemeMode.light);
              if (context.mounted) Navigator.pop(context);
            },
          ),
          SizedBox(height: 12.h),
          _buildOption(
            context,
            title: tr("dark"),
            isSelected: isDark,
            icon: Icons.dark_mode_rounded,
            onTap: () async {
              await themeProvider.changeTheme(ThemeMode.dark);
              if (context.mounted) Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildOption(
    BuildContext context, {
    required String title,
    required bool isSelected,
    required IconData icon,
    required VoidCallback onTap,
  }) {
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
      leading: Icon(icon, color: textColor, size: 22.r),
      title: Text(
        title,
        style: TextStyle(
          color: textColor,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          fontSize: 16.sp,
        ),
      ),
      trailing: isSelected
          ? Icon(Icons.check_circle, color: AppColors.bluePrimaryColor)
          : null,
    );
  }
}
