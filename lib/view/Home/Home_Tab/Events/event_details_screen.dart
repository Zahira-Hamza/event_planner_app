import 'package:easy_localization/easy_localization.dart';
import 'package:event_planner_app/view/Home/Home_Tab/Events/widgets/event_location_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/Firebase-Firestore/models/event.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_routes.dart';
import '../../../../core/utils/app_styles.dart';

class EventDetailsScreen extends StatelessWidget {
  const EventDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Extract the event object
    final event = ModalRoute.of(context)!.settings.arguments as Event;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: Text(
          "Event Details".tr(),
          style: AppStyles.medium16blue.copyWith(fontSize: 20.sp),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppColors.bluePrimaryColor),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                AppRoutes.updateEventRoute,
                arguments: event, // Pass the event object here too!
              );
            },
            icon: const Icon(
              Icons.edit_outlined,
              color: AppColors.bluePrimaryColor,
            ),
          ),
          IconButton(
            onPressed: () {}, // Delete logic
            icon: const Icon(Icons.delete_outline, color: Colors.red),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 2. Event Image (Rounded Corners)
            ClipRRect(
              borderRadius: BorderRadius.circular(20.r),
              child: Image.asset(
                event.image,
                height: 210.h,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 16.h),

            /// 3. Event Title (Blue Style)
            Text(
              event.title,
              style: AppStyles.medium16blue.copyWith(
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 18.h),

            /// 4. Date & Time Container
            _buildDetailContainer(
              child: Row(
                children: [
                  _buildIconBox(Icons.calendar_month_outlined),
                  SizedBox(width: 12.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        DateFormat('d MMMM yyyy').format(event.dateTime),
                        style: AppStyles.medium16blue,
                      ),
                      Text(
                        event.time,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 12.h),

            /// 5. Location Container
            EventLocationWidget(lat: event.lat, long: event.long),
            SizedBox(height: 12.h),

            /// Map Preview using GoogleMap
            Container(
              height: 300.h, // Adjusted height to match IDE screenshot
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: AppColors.bluePrimaryColor),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.r),
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(event.lat, event.long),
                    zoom: 15,
                  ),
                  markers: {
                    Marker(
                      markerId: const MarkerId("eventLocation"),
                      position: LatLng(event.lat, event.long),
                    ),
                  },
                  zoomControlsEnabled: false,
                  myLocationButtonEnabled: false,
                ),
              ),
            ),
            SizedBox(height: 16.h),

            /// 7. Description
            Text(
              "Description".tr(),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              event.description,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(fontSize: 16.sp, height: 1.4),
            ),
          ],
        ),
      ),
    );
  }

  /// Helper for the rounded white containers with blue borders
  Widget _buildDetailContainer({required Widget child}) {
    return Container(
      padding: EdgeInsets.all(8.r),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.bluePrimaryColor),
      ),
      child: child,
    );
  }

  /// Helper for the blue icon box
  Widget _buildIconBox(IconData icon) {
    return Container(
      padding: EdgeInsets.all(10.r),
      decoration: BoxDecoration(
        color: AppColors.bluePrimaryColor,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Icon(icon, color: Colors.white, size: 24.r),
    );
  }
}
