import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventCategoryTabItem extends StatelessWidget {
  final bool isSelected;
  final String event;
  final Color? borderColor;
  final Color selectedBgColor;
  final TextStyle selectedTextStyle;
  final TextStyle unselectedTextStyle;

  const EventCategoryTabItem({
    super.key,
    required this.isSelected,
    required this.event,
    this.borderColor,
    required this.selectedBgColor,
    required this.selectedTextStyle,
    required this.unselectedTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // Using standard pixel-based ScreenUtil for better control
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.r),
        border: Border.all(
          width: 1.5,
          // If not selected, we use the provided border color or white to see it on blue
          color: isSelected
              ? Colors.transparent
              : (borderColor ?? Colors.white),
        ),
        color: isSelected ? selectedBgColor : Colors.transparent,
      ),
      child: Center(
        // Ensures text is centered if the container expands
        child: Text(
          event,
          style: isSelected ? selectedTextStyle : unselectedTextStyle,
        ),
      ),
    );
  }
}
