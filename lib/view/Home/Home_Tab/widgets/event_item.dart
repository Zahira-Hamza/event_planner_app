import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../core/Firebase-Firestore/models/event.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../view_model/providers/event_list_provider.dart';
import '../Events/event_details_screen.dart';

class EventItem extends StatelessWidget {
  final Event event;

  const EventItem({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const EventDetailsScreen(),
            settings: RouteSettings(arguments: event),
          ),
        );
      },
      child: Container(
        height: 230.h,
        width: double.infinity,
        margin: EdgeInsets.symmetric(vertical: 8.h),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppAssets.getEventImage(context, event.image)),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: AppColors.bluePrimaryColor, width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Date Badge — always white bg with blue text (sits on image, intentional)
            Container(
              margin: EdgeInsets.all(12.w),
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: Colors.white.withOpacity(0.9),
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
              // 1. For the Card Background:
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                color: Theme.of(
                  context,
                ).cardColor.withOpacity(0.95), // Uses cardColor from AppTheme
              ),
              child: Row(
                children: [
                  Expanded(
                    child: // 2. For the Text Color:
                    Text(
                      event.title,
                      style: AppStyles.bold20blue.copyWith(
                        fontSize: 16.sp,
                        color: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.color, // Uses color from your TextTheme
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Provider.of<EventListProvider>(
                        context,
                        listen: false,
                      ).toggleFavorite(event);
                    },
                    child: Icon(
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
