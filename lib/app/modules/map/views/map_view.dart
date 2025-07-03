import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart' as fm;
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';

import 'package:get/get.dart';

import '../controllers/map_controller.dart';

class MapView extends GetView<MapController> {
  const MapView({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      return Stack(
        children: [
          fm.FlutterMap(
            mapController: controller.mapController,
            options: fm.MapOptions(
              initialCenter: controller.currentLocation.value,
              initialZoom: 15.0,
              minZoom: 15.0,
              maxZoom: 18.0,
              onTap: (_, __) => controller.popUpController.hideAllPopups(),
            ),
            children: [
              fm.TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.book_manager',
              ),
              PopupMarkerLayer(
                options: PopupMarkerLayerOptions(
                  markers: controller.markers.toList(),
                  popupController: controller.popUpController,
                  popupDisplayOptions: PopupDisplayOptions(
                    builder: (context, fm.Marker marker) => Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: const Text(
                          'Lokasi Anda Saat Ini',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          Positioned(
            bottom: 20.0,
            right: 20.0,
            child: FloatingActionButton(
              onPressed: controller.moveToCurrentLocation,
              backgroundColor: Colors.blue,
              child: const Icon(Icons.my_location),
            ),
          ),
        ],
      );
    });
  }
}
