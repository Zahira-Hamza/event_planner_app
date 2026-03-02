import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../core/Firebase-Firestore/models/event.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../view_model/providers/event_list_provider.dart';
import '../Events/event_details_screen.dart'; // Add this

class EventItem extends StatelessWidget {
  final Event event; // Mark as final for better practice

  const EventItem({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // Inside EventItem class
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const EventDetailsScreen(),
            // Pass the event object as an argument
            settings: RouteSettings(arguments: event),
          ),
        );
      },
      child: Container(
        height: 230.h, // Fixed height responsive to screen height
        width: double.infinity,
        margin: EdgeInsets.symmetric(vertical: 8.h),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(event.image),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: AppColors.bluePrimaryColor, width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Date Badge
            Container(
              margin: EdgeInsets.all(12.w),
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: Colors.white.withOpacity(0.9), // Added slight opacity
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    event.dateTime.day.toString(),
                    style: AppStyles.bold20blue.copyWith(fontSize: 20.sp),
                  ),
                  Text(
                    DateFormat('MMM').format(event.dateTime),
                    style: AppStyles.bold20blue.copyWith(fontSize: 14.sp),
                  ),
                ],
              ),
            ),
            // Bottom Info Bar
            Container(
              margin: EdgeInsets.all(12.w),
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                color: Colors.white,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      event.title.tr(),
                      style: AppStyles.bold20blue.copyWith(
                        fontSize: 16.sp,
                        color: Colors.black, // Adjust based on your theme
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  // Fixed Favorite Icon logic
                  InkWell(
                    onTap: () {
                      // This call triggers the toggle logic in Provider
                      Provider.of<EventListProvider>(
                        context,
                        listen: false,
                      ).toggleFavorite(event);
                    },
                    child: Icon(
                      // TERNARY CONDITION for the icon
                      event.isFavorite
                          ? Icons.favorite_rounded
                          : Icons.favorite_border_rounded,
                      color: AppColors.bluePrimaryColor,
                      size: 24.r,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
