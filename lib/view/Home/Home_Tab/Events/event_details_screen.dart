import 'package:easy_localization/easy_localization.dart';
import 'package:event_planner_app/view/Home/Home_Tab/Events/widgets/event_location_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/Firebase-Firestore/firebase_utils.dart';
import '../../../../core/Firebase-Firestore/models/event.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_routes.dart';
import '../../../../core/utils/app_styles.dart';

class EventDetailsScreen extends StatelessWidget {
  const EventDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
            onPressed: () => Navigator.pushNamed(
              context,
              AppRoutes.updateEventRoute,
              arguments: event,
            ),
            icon: const Icon(
              Icons.edit_outlined,
              color: AppColors.bluePrimaryColor,
            ),
          ),
          IconButton(
            onPressed: () => _showDeleteDialog(context, event),
            icon: const Icon(Icons.delete_outline, color: Colors.red),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Event Image — switches with theme
            ClipRRect(
              borderRadius: BorderRadius.circular(20.r),
              child: Image.asset(
                AppAssets.getEventImage(context, event.image),
                height: 210.h,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 16.h),

            // Title
            Text(
              event.title,
              style: AppStyles.medium16blue.copyWith(
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 18.h),

            // Date & Time
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

            // Location
            EventLocationWidget(lat: event.lat, long: event.long),
            SizedBox(height: 12.h),

            // Map
            Container(
              height: 300.h,
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

            // Description
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

  void _showDeleteDialog(BuildContext context, Event event) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? const Color(0xff1E2040) : Colors.white;
    final textColor = isDark ? Colors.white : const Color(0xff1C1C1C);
    final subColor = isDark ? Colors.white70 : Colors.grey.shade600;
    const red = Color(0xFFEF5350);

    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        backgroundColor: bgColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 28, 24, 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Red trash icon badge
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: red.withOpacity(0.12),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.delete_rounded, color: red, size: 36),
              ),
              const SizedBox(height: 16),
              Text(
                'Delete Event'.tr(),
                style: TextStyle(
                  color: textColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'This action cannot be undone. The event will be permanently removed.'
                    .tr(),
                textAlign: TextAlign.center,
                style: TextStyle(color: subColor, fontSize: 14, height: 1.5),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(ctx),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.grey),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: Text(
                        'Cancel'.tr(),
                        style: TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        Navigator.pop(ctx);
                        await FirebaseUtils.getEventsCollection()
                            .doc(event.id)
                            .delete();
                        if (context.mounted) Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        elevation: 0,
                      ),
                      child: Text(
                        'Delete'.tr(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

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
