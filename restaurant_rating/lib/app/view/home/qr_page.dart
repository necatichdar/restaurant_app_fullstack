import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:restaurant_rating/app/controller/home_controller.dart';
import 'package:restaurant_rating/app/controller/map_controller.dart';
import 'package:get/get.dart';

class QrPage extends StatefulWidget {
  QrPage({Key? key}) : super(key: key);

  @override
  State<QrPage> createState() => _QrPageState();
}

class _QrPageState extends State<QrPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  Barcode? result;
  QRViewController? controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Text(
                'label_texts_scan'.tr,
              ),
            ),
          )
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      setState(() {
        result = scanData;
      });
      if (result!.code!.contains("https://cuhadar.dev/")) {
        controller.stopCamera();
        for (var i = 0; i < MapController.to.restoranList.length; i++) {
          if (MapController.to.restoranList[i].restoranId.toString() ==
              result!.code!.split('/')[3]) {
            HomeController.to.changePage(0);
            Get.toNamed('/${result!.code!.split('/')[3]}');
            break;
          }
        }
      }
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
