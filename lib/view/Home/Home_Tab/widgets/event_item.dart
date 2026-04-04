import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../core/Firebase-Firestore/models/event.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../view_model/providers/Theme_Provider/app_theme_provider.dart';
import '../../../../view_model/providers/event_list_provider.dart';
import '../Events/event_details_screen.dart';

class EventItem extends StatelessWidget {
  final Event event;

  const EventItem({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    // Listening to AppThemeProvider ensures this widget rebuilds on theme
    // switch, which forces DecorationImage to pick up the correct image path.
    return Consumer<AppThemeProvider>(
      builder: (context, themeProvider, _) {
        final isDark = themeProvider.isDark;
        final imagePath = isDark
            ? AppAssets.getDarkImage(event.image)
            : event.image;

        return InkWell(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const EventDetailsScreen(),
              settings: RouteSettings(arguments: event),
            ),
          ),
          child: Container(
            height: 230.h,
            width: double.infinity,
            margin: EdgeInsets.symmetric(vertical: 8.h),
            decoration: BoxDecoration(
              image: DecorationImage(
                // Key trick: use a UniqueKey-equivalent by including isDark in
                // the image path so Flutter creates a fresh AssetImage object
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(color: AppColors.bluePrimaryColor, width: 1),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Date badge
                Container(
                  margin: EdgeInsets.all(12.w),
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 4.h,
                  ),
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
                // Bottom info bar
                Container(
                  margin: EdgeInsets.all(12.w),
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 8.h,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    color: Theme.of(context).cardColor.withOpacity(0.95),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          event.title,
                          style: AppStyles.bold20blue.copyWith(
                            fontSize: 16.sp,
                            color: Theme.of(
                              context,
                            ).textTheme.bodyMedium?.color,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      InkWell(
                        onTap: () => Provider.of<EventListProvider>(
                          context,
                          listen: false,
                        ).toggleFavorite(event),
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
      },
    );
  }
}
