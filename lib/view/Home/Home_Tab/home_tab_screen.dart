import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:event_planner_app/view/Home/Home_Tab/widgets/event_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/Firebase-Firestore/firebase_utils.dart';
import '../../../core/Firebase-Firestore/models/event.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_styles.dart';
import 'widgets/event_category_tab_item.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabScreenState();
}

class _HomeTabScreenState extends State<HomeTab> {
  int selectedIndex = 0;

  //* List<Event> eventsList = [];

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
            child: StreamBuilder<QuerySnapshot<Event>>(
              // 1. Listen to snapshots (Real-time)
              stream: FirebaseUtils.getEventsCollection().snapshots(),
              builder: (context, snapshot) {
                // 2. Handle Loading state
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                // 3. Handle Error state
                if (snapshot.hasError) {
                  return Center(child: Text("Something went wrong".tr()));
                }

                // 4. Extract data
                var eventsList =
                    snapshot.data?.docs.map((doc) => doc.data()).toList() ?? [];

                // 5. Handle Empty state
                if (eventsList.isEmpty) {
                  return Center(child: Text("No Events Found".tr()));
                }

                return ListView.separated(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 14.h,
                  ),
                  itemBuilder: (context, index) =>
                      EventItem(event: eventsList[index]),
                  separatorBuilder: (context, index) => SizedBox(height: 16.h),
                  itemCount: eventsList.length,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  //* void getAllEvents() async {
  //   QuerySnapshot<Event> querySnapshot =
  //       await FirebaseUtils.getEventsCollection()
  //           .get(); //* one time read=>real time read
  //   setState(() {
  //     eventsList = querySnapshot.docs.map((doc) => doc.data()).toList();
  //   });
  // }
}

//* Feature:  get() + setState()    =>     snapshots() + StreamBuilder(*Remove the eventsList variable and the getAllEvents call from build and This handles the "snapshots" and the "rebuilds" automatically)
// Data Type: Future (One-time fetch)     Stream (Real-time updates)
// UI Updates:Manual (must call setState)  Automatic (built into the widget)
// Complexity:Higher (handling lifecycles)   Lower (cleaner code)
