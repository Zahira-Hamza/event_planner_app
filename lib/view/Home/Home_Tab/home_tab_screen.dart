import 'package:easy_localization/easy_localization.dart';
import 'package:event_planner_app/view/Home/Home_Tab/widgets/event_item.dart';
import 'package:event_planner_app/view/Home/Profile_Tab/widgets/language_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_styles.dart';
import '../../../core/widgets/user_avatar.dart';
import '../../../view_model/providers/Language_Provider/app_language_provider.dart';
import '../../../view_model/providers/Theme_Provider/app_theme_provider.dart';
import '../../../view_model/providers/event_list_provider.dart';
import '../../../view_model/providers/user_provider.dart';
import 'widgets/event_category_tab_item.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabScreenState();
}

class _HomeTabScreenState extends State<HomeTab> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<UserProvider>(context, listen: false).fetchCurrentUser();
      Provider.of<EventListProvider>(context, listen: false).listenToEvents();
    });
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<EventListProvider>(context);
    var userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.bluePrimaryColor,
        automaticallyImplyLeading: false,
        toolbarHeight: 100.h,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25.r),
            bottomRight: Radius.circular(25.r),
          ),
        ),
        title: Row(
          children: [
            // ── Profile avatar ──────────────────────────────────────────
            Consumer<UserProvider>(
              builder: (_, userProvider, __) => UserAvatar(
                dataUrl: userProvider.currentUser?.photoUrl,
                radius: 22.r,
              ),
            ),
            SizedBox(width: 12.w),

            // ── Welcome + name ──────────────────────────────────────────
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Welcome Back ✨".tr(), style: AppStyles.medium16white),
                SizedBox(height: 2.h),
                Text(
                  userProvider.currentUser?.name ?? "User",
                  style: AppStyles.bold20white.copyWith(fontSize: 20.sp),
                ),
              ],
            ),
            const Spacer(),

            // ── Theme toggle — sun in light, moon in dark ───────────────
            Consumer<AppThemeProvider>(
              builder: (_, themeProvider, __) => GestureDetector(
                onTap: () async {
                  await themeProvider.changeTheme(
                    themeProvider.isDark ? ThemeMode.light : ThemeMode.dark,
                  );
                },
                child: Icon(
                  themeProvider.isDark
                      ? Icons
                            .dark_mode_rounded // moon when dark
                      : Icons.light_mode_rounded, // sun when light
                  color: Colors.white,
                  size: 28.sp,
                ),
              ),
            ),

            // ── Language badge ──────────────────────────────────────────
            Padding(
              padding: EdgeInsets.only(left: 8.w),
              child: GestureDetector(
                onTap: () => showModalBottomSheet(
                  context: context,
                  backgroundColor: Theme.of(context).cardColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20.r),
                    ),
                  ),
                  builder: (_) => const LanguageBottomSheet(),
                ),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Consumer<AppLanguageProvider>(
                    builder: (_, langProvider, __) => Text(
                      langProvider.appLanguage == 'ar' ? 'AR' : 'EN',
                      style: AppStyles.bold20white.copyWith(
                        fontSize: 14.sp,
                        color: AppColors.bluePrimaryColor,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(90.h),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: Column(
              children: [
                Row(
                  children: [
                    const Icon(Icons.location_on_outlined, color: Colors.white),
                    SizedBox(width: 4.w),
                    Text(
                      userProvider.currentUser?.location ?? "Loading...",
                      style: AppStyles.medium16white,
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                DefaultTabController(
                  length: provider.eventsName.length,
                  child: TabBar(
                    indicatorColor: Colors.transparent,
                    dividerColor: Colors.transparent,
                    labelPadding: EdgeInsets.zero,
                    tabAlignment: TabAlignment.start,
                    onTap: (index) {
                      setState(() => provider.changeSelectedIndex(index));
                    },
                    isScrollable: true,
                    tabs: provider.eventsName.asMap().entries.map((entry) {
                      return EventCategoryTabItem(
                        // Selected: white pill → blue text so it's readable
                        // Unselected: transparent → white text on blue AppBar
                        selectedTextStyle: AppStyles.medium16blue,
                        unselectedTextStyle: AppStyles.medium16white,
                        isSelected: provider.selectedIndex == entry.key,
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
      body: provider.filterEventsList.isEmpty
          ? Center(child: Text("No Events Found".tr()))
          : ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
              itemBuilder: (context, index) =>
                  EventItem(event: provider.filterEventsList[index]),
              separatorBuilder: (context, index) => SizedBox(height: 16.h),
              itemCount: provider.filterEventsList.length,
            ),
    );
  }
}
