import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:restaurant_rating/app/controller/map_controller.dart';

import '../detail_page.dart';

class MapPage extends StatelessWidget {
  MapController mapController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() => mapController.isLoading.value
        ? Text('de')
        : GoogleMap(
            onMapCreated: (controller) {
              mapController.changeController(controller);
            },
            initialCameraPosition: const CameraPosition(
              target: LatLng(40.9359552, 40.2885578),
              zoom: 11.0,
            ),
            gestureRecognizers: Set()
              ..add(Factory<PanGestureRecognizer>(() => PanGestureRecognizer()))
              ..add(Factory<VerticalDragGestureRecognizer>(
                  () => VerticalDragGestureRecognizer())),
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            onLongPress: (latlang) {
              mapController.addCustomMarker(latlang);
            },
            // markers: controller.,
            markers: //{marker}
                {
              //restoranlar
              ...mapController.restoranList.map((restoran) {
                return Marker(
                  icon: BitmapDescriptor.defaultMarker,
                  markerId: MarkerId(restoran.restoranId.toString()),
                  position: LatLng(double.tryParse(restoran.lat!)!,
                      double.tryParse(restoran.long!)!),
                  infoWindow: InfoWindow(
                    title: restoran.name,
                    snippet: restoran.description,
                    onTap: () {
                      Get.bottomSheet(DetailPage(
                        parameter: restoran.restoranId.toString(),
                      ));
                    },
                  ),
                );
              }).toSet(),
              //markerımız.
              mapController.marker.value,
            },
          ));
  }
}
