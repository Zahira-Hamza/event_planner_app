import 'package:easy_localization/easy_localization.dart';
import 'package:event_planner_app/core/utils/app_routes.dart';
import 'package:event_planner_app/view/Home/map_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/utils/app_colors.dart';
import 'Home_Tab/home_tab_screen.dart';
import 'Profile_Tab/profile_tab_screen.dart';
import 'love_tab/love_tab_screen.dart';

class BottomNavBarWrapper extends StatefulWidget {
  const BottomNavBarWrapper({super.key});

  @override
  State<BottomNavBarWrapper> createState() => _BottomNavBarWrapperState();
}

class _BottomNavBarWrapperState extends State<BottomNavBarWrapper> {
  int _currentIndex = 0;

  // List of screens for each tab
  final List<Widget> _tabs = [
    const HomeTab(), // The implementation for this is below
    MapTab(),
    LoveTabScreen(),
    const ProfileTabScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tabs[_currentIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        height: 65.h,
        width: 65.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 4.w),
        ),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, AppRoutes.createEventRoute);
          },
          backgroundColor: AppColors.bluePrimaryColor,
          elevation: 0,
          shape: const CircleBorder(),
          child: Icon(Icons.add, color: Colors.white, size: 35.sp),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 6.r,
        height: 75.h,
        color: AppColors.bluePrimaryColor,
        child: SizedBox(
          height: 40.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildNavItem(Icons.home_outlined, Icons.home, "Home".tr(), 0),
              _buildNavItem(Icons.map_outlined, Icons.map, "Map".tr(), 1),
              SizedBox(width: 35.w), // Space for FAB
              _buildNavItem(
                Icons.favorite_border,
                Icons.favorite,
                "Love".tr(),
                2,
              ),
              _buildNavItem(
                Icons.person_outline,
                Icons.person,
                "Profile".tr(),
                3,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
    IconData icon,
    IconData activeIcon,
    String label,
    int index,
  ) {
    bool isSelected = _currentIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _currentIndex = index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isSelected ? activeIcon : icon,
            color: Colors.white,
            size: 26.sp,
          ),
          Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontSize: 12.sp,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
