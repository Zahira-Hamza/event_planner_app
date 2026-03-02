import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../view_model/providers/app_provider.dart';

class PickEventLocation extends StatefulWidget {
  const PickEventLocation({super.key});

  @override
  State<PickEventLocation> createState() => _PickEventLocationState();
}

class _PickEventLocationState extends State<PickEventLocation> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AppProvider>(context, listen: false).getLocation();
    });
  }

  @override
  Widget build(BuildContext context) {
    // Access provider once here for the FAB and non-builder parts
    var appProvider = Provider.of<AppProvider>(context);

    return Scaffold(
      body: Stack(
        children: [
          // 1. The Map Layer
          Consumer<AppProvider>(
            builder: (context, provider, child) => GoogleMap(
              markers: provider.markers,
              onMapCreated: (mapController) {
                provider.mapController = mapController;
              },
              mapType: MapType.normal,
              initialCameraPosition: provider.cameraPosition,
              // Optional: Add onTap to update the marker manually
              onTap: (location) {
                // You could call a method in provider to move the marker here
                appProvider.setEventLocation(location);
                Navigator.pop(context);
              },
            ),
          ),

          // 2. The GPS Floating Action Button
          Positioned(
            top: 50,
            right: 16,
            child: FloatingActionButton(
              onPressed: () => appProvider.getLocation(),
              backgroundColor: AppColors.bluePrimaryColor,
              child: const Icon(Icons.gps_fixed, color: Colors.white),
            ),
          ),

          // 3. The Bottom Button Layer
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: ElevatedButton(
                onPressed: () {
                  // todo:Logic to save selected location and go back
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.bluePrimaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Tap on Location To Select",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
