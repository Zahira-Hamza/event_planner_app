import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../view_model/providers/Language_Provider/app_language_provider.dart';

class LanguageBottomSheet extends StatelessWidget {
  const LanguageBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    String currentLanguage = languageProvider.appLanguage;

    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          LanguageOption(
            title: tr('english'),
            isSelected: currentLanguage == 'en',

            onTap: () {
              //! this line is not useful?
              context.setLocale(const Locale('en'));
              languageProvider.changeLanguage('en');
              Navigator.pop(context);
            },
          ),
          const SizedBox(height: 8),
          LanguageOption(
            title: tr('arabic'),
            isSelected: currentLanguage == 'ar',
            onTap: () {
              //! this line is not useful?
              context.setLocale(const Locale('ar'));
              languageProvider.changeLanguage('ar');
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}

class LanguageOption extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const LanguageOption({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isSelected ? AppColors.bluePrimaryColor : Colors.grey,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isSelected ? AppColors.bluePrimaryColor : Colors.grey,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      trailing: isSelected
          ? Icon(Icons.check_circle, color: AppColors.bluePrimaryColor)
          : null,
    );
  }
}
