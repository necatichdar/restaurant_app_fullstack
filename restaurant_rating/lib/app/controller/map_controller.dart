import 'dart:math' show cos, sqrt, asin;

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:restaurant_rating/app/services/services.dart';
import 'package:restaurant_rating/app/view/add_restoran_page.dart';

class MapController extends GetxController {
  static MapController get to => Get.find();

  GoogleMapController? googleMapsController;

  var restoranList = [].obs;
  RxBool isLoading = false.obs;
  var markerList = [].obs;
  var marker = Marker(
      markerId: MarkerId("myMarker"),
      visible: false,
      infoWindow: InfoWindow(
        title: "Ekle!",
      )).obs;

  @override
  void onInit() {
    super.onInit();
    getRestoran();
    getCurrentLocation();
  }

  changeController(controller) {
    googleMapsController = controller;
  }

  getRestoran() async {
    var responseList = await DatabaseServices.instance.getRestaurant();
    restoranList(responseList);
  }

  changeCameraMove(double lat, double long) async {
    await googleMapsController!
        .moveCamera(CameraUpdate.newLatLngZoom(LatLng(lat, long), 16));
  }

  addCustomMarker(latlang) {
    marker.value = Marker(
        // This marker id can be anything that uniquely identifies each marker.
        markerId: MarkerId(latlang.toString()),
        position: latlang,
        draggable: true,
        infoWindow: InfoWindow(
          title: "label_texts_taptoadd".tr,
          onTap: () {
            Get.bottomSheet(AddRestoranPage());
          },
        ),
        onTap: () {},
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        onDragEnd: ((newPosition) {
          addCustomMarker(newPosition);
        }));
  }

  markerClose() {
    marker.value = Marker(
        markerId: MarkerId("myMarker"),
        visible: false,
        infoWindow: InfoWindow(
          title: " ",
        ));
  }

  getCurrentLocation() async {
    if (await Permission.location.isGranted) {
      await Permission.location.request();
    }
  }

  static Future<bool> locationVerify() async {
    var cevap = await Permission.location.request();
    print(cevap);

    if (await Permission.location.isGranted) {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      //2 Nokta arası mesafeyi bulma
      var responseDistance = _coordinateDistance(
              position.latitude,
              position.longitude,
              MapController.to.marker.value.position.latitude,
              MapController.to.marker.value.position.longitude)
          .toStringAsFixed(2);
      //1km'den yakında yorum yapabilir. 1km'den fazla ise yorum yapamaz.
      if (double.parse(responseDistance) < 1) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  static double _coordinateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }
}
