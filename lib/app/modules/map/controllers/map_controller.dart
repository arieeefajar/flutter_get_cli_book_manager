import 'package:flutter/material.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:flutter_map/flutter_map.dart' as fm;
import 'package:latlong2/latlong.dart';

class MapController extends GetxController {
  late fm.MapController mapController;
  final popUpController = PopupController();

  final Rx<LatLng> currentLocation = LatLng(-6.1751, 106.8650).obs;
  final RxBool isLoading = true.obs;
  final RxList<fm.Marker> markers = <fm.Marker>[].obs;

  @override
  void onInit() {
    super.onInit();
    mapController = fm.MapController();
    getCurrentLocation();
  }

  Future<void> getCurrentLocation() async {
    isLoading.value = true;

    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      isLoading.value = false;
      return;
    }

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      isLoading.value = false;
      return;
    }

    try {
      final pos = await Geolocator.getCurrentPosition();
      currentLocation.value = LatLng(pos.latitude, pos.longitude);
      markers.assignAll([
        fm.Marker(
          point: currentLocation.value,
          width: 40,
          height: 40,
          child: const Icon(Icons.my_location, size: 40.0, color: Colors.blue),
        ),
      ]);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        mapController.move(currentLocation.value, 15);
        popUpController.showPopupsOnlyFor(markers.toList());
      });
    } catch (e) {
      print('Error getting current location: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void moveToCurrentLocation() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      mapController.move(currentLocation.value, 15);
      popUpController.showPopupsOnlyFor(markers.toList());
    });
  }
}
