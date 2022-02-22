import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_rating/app/controller/admin_controllers.dart';
import 'package:restaurant_rating/app/model/all_parameters_model.dart';
import 'package:restaurant_rating/core/consts.dart';

class AdminPage extends StatefulWidget {
  AdminPage({Key? key}) : super(key: key);

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  AdminController adminController = Get.put(AdminController());

  Color? getColor(role) {
    switch (role) {
      case "1":
        return Colors.red[100];
      case "2":
        return Colors.blue[100];
      case "3":
        return Colors.blueGrey[100];
      default:
        return null;
    }
  }

  @override
  void initState() {
    super.initState();
    adminController.getAllParameters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          adminController.getAllParameters();
        },
        child: Icon(Icons.refresh),
      ),
      body: Obx(() => ListView.builder(
            itemCount: adminController.allList.length,
            itemBuilder: (context, index) {
              AllParameters parameters = adminController.allList.value[index];
              return Card(
                color: getColor(parameters.role),
                child: ListTile(
                  title: Text('${parameters.title}'),
                  subtitle: Text('${parameters.description}'),
                  leading: parameters.role == "3"
                      ? SizedBox(
                          width: 50,
                          height: 100,
                          child: CachedNetworkImage(
                            imageUrl:
                                '${Constants.instance.apiUrl}${parameters.description}',
                          ),
                        )
                      : null,
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          button(parameters, status: "0");
                        },
                      ),
                      SizedBox(width: 10),
                      IconButton(
                        icon: Icon(Icons.check),
                        onPressed: () {
                          button(parameters, status: "1");
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          )),
    );
  }

  void button(AllParameters parameters, {required String status}) {
    adminController.changeParameter(
        role: parameters.role.toString(),
        id: parameters.id.toString(),
        status: status);
  }

  AppBar buildAppBar() {
    return AppBar(
      title: const Text('Restaurant Rating'),
      centerTitle: true,
      elevation: 0,
    );
  }
}
