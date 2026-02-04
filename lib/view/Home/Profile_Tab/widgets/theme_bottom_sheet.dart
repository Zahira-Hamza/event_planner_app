import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../view_model/Theme_Provider/app_theme_provider.dart';

class ThemeBottomSheet extends StatelessWidget {
  const ThemeBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    // Assuming you have an AppThemeProvider
    var themeProvider = Provider.of<AppThemeProvider>(context);
    bool isDark = themeProvider.isDark;

    return Padding(
      padding: EdgeInsets.all(20.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildOption(
            context,
            title: tr("light"),
            isSelected: !isDark,
            onTap: () {
              themeProvider.changeTheme(ThemeMode.light);
              Navigator.pop(context);
            },
          ),
          SizedBox(height: 12.h),
          _buildOption(
            context,
            title: tr("dark"),
            isSelected: isDark,
            onTap: () {
              themeProvider.changeTheme(ThemeMode.dark);
              Navigator.pop(context);
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
    required VoidCallback onTap,
  }) {
    return ListTile(
      onTap: onTap,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
        side: BorderSide(
          color: isSelected ? AppColors.bluePrimaryColor : Colors.grey.shade300,
        ),
      ),
      title: Text(
        title,
        style: isSelected ? AppStyles.medium16blue : AppStyles.medium16black,
      ),
      trailing: isSelected
          ? Icon(Icons.check_circle, color: AppColors.bluePrimaryColor)
          : null,
    );
  }
}
