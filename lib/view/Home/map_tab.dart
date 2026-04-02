import 'package:event_planner_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../view_model/providers/app_provider.dart';

class MapTab extends StatefulWidget {
  const MapTab({super.key});

  @override
  State<MapTab> createState() => _MapTabState();
}

class _MapTabState extends State<MapTab> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AppProvider>(context, listen: false).getLocation();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Provider.of<AppProvider>(context, listen: false).getLocation();
        },
        backgroundColor: AppColors.bluePrimaryColor,
        child: Icon(Icons.gps_fixed, color: Colors.white),
      ),
      body: Consumer<AppProvider>(
        builder: (context, provider, child) => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: GoogleMap(
                markers: provider.markers,
                onMapCreated: (mapController) {
                  provider.mapController = mapController;
                },
                mapType:
                    MapType.normal, // You were missing the specific type here
                initialCameraPosition: provider.cameraPosition,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
