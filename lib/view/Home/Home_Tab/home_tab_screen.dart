import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_styles.dart';
import 'widgets/event_category_tab_item.dart';
// Assuming you have an EventItem widget and an Event model defined locally
// import 'event_item.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabScreenState();
}

class _HomeTabScreenState extends State<HomeTab> {
  int selectedIndex = 0;

  // Local dummy data to replace the provider
  final List<String> dummyEvents = [
    "Birthday Party",
    "Meeting for Development",
    "Art Exhibition",
    "Gaming Night",
  ];

  @override
  Widget build(BuildContext context) {
    List<String> eventsName = [
      'All'.tr(),
      'Sport'.tr(),
      'Birthday'.tr(),
      'Meeting'.tr(),
      'Gaming'.tr(),
      'WorkShop'.tr(),
      'BookClub'.tr(),
      'Exhibition'.tr(),
      'Holiday'.tr(),
      'Eating'.tr(),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.bluePrimaryColor,
        automaticallyImplyLeading: false,
        toolbarHeight: 100.h, // Using fixed height via ScreenUtil
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25.r),
            bottomRight: Radius.circular(25.r),
          ),
        ),
        title: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome Back ✨".tr(),
                  style: AppStyles.medium16white.copyWith(fontSize: 14.sp),
                ),
                SizedBox(height: 4.h),
                Text(
                  "John Safwat",
                  style: AppStyles.bold20white.copyWith(fontSize: 24.sp),
                ),
              ],
            ),
            const Spacer(),
            const ImageIcon(
              AssetImage("assets/images/theme_icon.png"),
              color: Colors.white,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  "EN",
                  style: AppStyles.bold20white.copyWith(
                    fontSize: 14.sp,
                    color: AppColors.bluePrimaryColor,
                  ),
                ),
              ),
            ),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(100.h),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: Column(
              children: [
                Row(
                  children: [
                    const Icon(Icons.location_on_outlined, color: Colors.white),
                    Text("Cairo , Egypt".tr(), style: AppStyles.medium16white),
                  ],
                ),
                SizedBox(height: 12.h),
                DefaultTabController(
                  length: eventsName.length,
                  child: TabBar(
                    indicatorColor: Colors.transparent,
                    dividerColor: Colors.transparent,
                    labelPadding: EdgeInsets.zero,
                    tabAlignment: TabAlignment.start,
                    onTap: (index) {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    isScrollable: true,
                    tabs: eventsName.asMap().entries.map((entry) {
                      return EventCategoryTabItem(
                        selectedTextStyle: Theme.of(
                          context,
                        ).textTheme.headlineMedium!,
                        unselectedTextStyle: Theme.of(
                          context,
                        ).textTheme.headlineSmall!,
                        isSelected: selectedIndex == entry.key,
                        event: entry.value,
                        selectedBgColor: Colors.white,
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: 14.h),
              child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                itemBuilder: (context, index) {
                  // Replace with your actual EventItem widget
                  return Container(
                    height: 200.h,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    alignment: Alignment.center,
                    child: Text(dummyEvents[index % dummyEvents.length]),
                  );
                },
                separatorBuilder: (context, index) => SizedBox(height: 16.h),
                itemCount: 10, // Static count for UI testing
              ),
            ),
          ),
        ],
      ),
    );
  }
}
