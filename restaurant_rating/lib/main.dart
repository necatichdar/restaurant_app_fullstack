import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:restaurant_rating/app/view/home/home_page.dart';
import 'package:restaurant_rating/core/theme/theme.dart';

import 'app/bindings/main_binding.dart';
import 'app/controller/local_manager.dart';
// import 'app/routes/app_pages.dart';
import 'app/view/router_page.dart';
import 'generated/locales.g.dart';

Future<void> main() async {
  await GetStorage.init();
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Restaurant Rating",
      // initialRoute: AppPages.INITIAL,
      // getPages: AppPages.routes,
      initialBinding: MainBindings(),
      translationsKeys: AppTranslation.translations,
      fallbackLocale: Locale("en", "US"),
      locale: Get.put<LocaleManager>(LocaleManager()).locale,
      theme: myTheme,
      getPages: [
        GetPage(name: "/", page: () => RouterPage()),
        GetPage(name: "/:id", page: () => RouterPage()),
      ],
      // home: RouterPage(),
    ),
  );
}

// import 'package:flutter/foundation.dart';

// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'maps/animate_camera.dart';
// import 'maps/lite_mode.dart';
// import 'maps/map_click.dart';
// import 'maps/map_coordinates.dart';
// import 'maps/map_ui.dart';
// import 'maps/marker_icons.dart';
// import 'maps/move_camera.dart';
// import 'maps/padding.dart';
// import 'maps/page.dart';
// import 'maps/place_circle.dart';
// import 'maps/place_marker.dart';
// import 'maps/place_polygon.dart';
// import 'maps/place_polyline.dart';
// import 'maps/scrolling_map.dart';
// import 'maps/snapshot.dart';
// import 'maps/tile_overlay.dart';

// final List<GoogleMapExampleAppPage> _allPages = <GoogleMapExampleAppPage>[
//   MapUiPage(),
//   MapCoordinatesPage(),
//   MapClickPage(),
//   AnimateCameraPage(),
//   MoveCameraPage(),
//   PlaceMarkerPage(),
//   MarkerIconsPage(),
//   ScrollingMapPage(),
//   PlacePolylinePage(),
//   PlacePolygonPage(),
//   PlaceCirclePage(),
//   PaddingPage(),
//   SnapshotPage(),
//   LiteModePage(),
//   TileOverlayPage(),
// ];

// class MapsDemo extends StatelessWidget {
//   void _pushPage(BuildContext context, GoogleMapExampleAppPage page) {
//     Navigator.of(context).push(MaterialPageRoute<void>(
//         builder: (_) => Scaffold(
//               appBar: AppBar(title: Text(page.title)),
//               body: page,
//             )));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('GoogleMaps examples')),
//       body: ListView.builder(
//         itemCount: _allPages.length,
//         itemBuilder: (_, int index) => ListTile(
//           leading: _allPages[index].leading,
//           title: Text(_allPages[index].title),
//           onTap: () => _pushPage(context, _allPages[index]),
//         ),
//       ),
//     );
//   }
// }

// void main() {
//   if (defaultTargetPlatform == TargetPlatform.android) {
//     AndroidGoogleMapsFlutter.useAndroidViewSurface = true;
//   }
//   runApp(MaterialApp(home: MapsDemo()));
// }
