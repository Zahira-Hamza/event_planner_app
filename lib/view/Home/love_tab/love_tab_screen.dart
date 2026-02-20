import 'package:easy_localization/easy_localization.dart';
import 'package:event_planner_app/view/Home/Home_Tab/widgets/event_item.dart'; // Import your EventItem
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_styles.dart';
import '../../../core/widgets/custom_text_form_field.dart';
import '../../../view_model/providers/event_list_provider.dart';

class LoveTabScreen extends StatefulWidget {
  const LoveTabScreen({super.key});

  @override
  State<LoveTabScreen> createState() => _LoveTabScreenState();
}

class _LoveTabScreenState extends State<LoveTabScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    // Watch the provider for changes
    var provider = context.watch<EventListProvider>();

    // Get the base favorites list
    var filteredFavs = provider.favoriteEvents;

    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * .05,
              vertical: screenHeight * .02,
            ),
            child: CustomTextFormField(
              onChanged: (value) {
                provider.updateSearchQuery(value ?? "");
              },
              borderColor: AppColors.bluePrimaryColor,
              hintText: "Search For Event".tr(),
              hintStyle: AppStyles.medium16blue.copyWith(fontSize: 14),
              prefixIcon: const Icon(
                Icons.search,
                color: AppColors.bluePrimaryColor,
              ),
              textEditingController: searchController,
            ),
          ),
          Expanded(
            child: filteredFavs.isEmpty
                ? Center(
                    child: Text(
                      // Use provider logic to check if search is active
                      "No Results Found".tr(),
                      style: AppStyles.medium16blue,
                    ),
                  )
                : ListView.separated(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * .05,
                    ),
                    itemBuilder: (context, index) {
                      return EventItem(event: filteredFavs[index]);
                    },
                    separatorBuilder: (context, index) =>
                        SizedBox(height: screenHeight * .02),
                    itemCount: filteredFavs.length,
                  ),
          ),
        ],
      ),
    );
  }
}
