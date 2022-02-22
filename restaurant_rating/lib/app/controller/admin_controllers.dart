import 'package:get/get.dart';
import 'package:restaurant_rating/app/controller/map_controller.dart';
import 'package:restaurant_rating/app/services/services.dart';

class AdminController extends GetxController {
  var allList = [].obs;

  getAllParameters() async {
    var response = await DatabaseServices.instance.getAllParameters();
    allList(response);
  }

  changeParameter(
      {required String role,
      required String id,
      required String status}) async {
    await DatabaseServices.instance
        .changeParameters(role: role, id: id, status: status);
    await getAllParameters();
    MapController.to.getRestoran();
  }

  @override
  void onInit() {
    super.onInit();
    getAllParameters();
  }
}
