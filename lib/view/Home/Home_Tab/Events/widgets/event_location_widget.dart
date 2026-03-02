import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart'; // Ensure this is in pubspec.yaml

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_styles.dart';

class EventLocationWidget extends StatefulWidget {
  final double lat;
  final double long;

  const EventLocationWidget({super.key, required this.lat, required this.long});

  @override
  State<EventLocationWidget> createState() => _EventLocationWidgetState();
}

class _EventLocationWidgetState extends State<EventLocationWidget> {
  String _address = "Fetching address...";

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  // Logic to convert lat/long to Address
  Future<void> getLocation() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        widget.lat,
        widget.long,
      );
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        setState(() {
          // You can customize how much detail you want here
          _address =
              "${place.street}, ${place.administrativeArea}, ${place.country}";
        });
      }
    } catch (e) {
      setState(() {
        _address = "Location not found";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.r),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.bluePrimaryColor),
      ),
      child: Row(
        children: [
          // Blue Icon Box
          Container(
            padding: EdgeInsets.all(10.r),
            decoration: BoxDecoration(
              color: AppColors.bluePrimaryColor,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(Icons.gps_fixed, color: Colors.white, size: 24.r),
          ),
          SizedBox(width: 12.w),
          // Address Text
          Expanded(
            child: Text(
              _address,
              style: AppStyles.medium16blue,
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
            ),
          ),
        ],
      ),
    );
  }
}
