import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:restaurant_rating/app/model/all_parameters_model.dart';
import 'package:restaurant_rating/app/model/comment_model.dart';
import 'package:restaurant_rating/app/model/image_model.dart';
import 'package:restaurant_rating/app/model/restoran_model.dart';
import 'package:restaurant_rating/app/model/user_model.dart';
import 'package:restaurant_rating/core/consts.dart';

class DatabaseServices {
  static final DatabaseServices instance = DatabaseServices._private();
  DatabaseServices._private();
  factory DatabaseServices() => instance;

  var headers = {
    'content-type': 'application/json',
    'X-Requested-With': 'XMLHttpRequest'
  };

  Future userLogin({required String email, required String password}) async {
    try {
      var result = await http.post(Constants.instance.toApi('/user/login'),
          headers: headers,
          body: jsonEncode({"mail": email, "password": password}));
      var body = result.body;
      if (body.isEmpty) {
        return null;
      }
      return User.fromJson(jsonDecode(body));
    } catch (e) {
      print("getUserLogin catch $e");
      return null;
    }
  }

  Future userRegister(
      {required String username,
      required String email,
      required String password}) async {
    try {
      var result = await http.post(Constants.instance.toApi('/user'),
          headers: headers,
          body: jsonEncode(
              {"username": username, "mail": email, "password": password}));
      var body = result.body;
      var jsonObject = jsonDecode(body);
      if (jsonObject['message'] != null) {
        return jsonObject['message'];
      }
      return User.fromJson(jsonObject);
    } catch (e) {
      print("getUserLogin catch $e");
      return null;
    }
  }

  Future<List<Restoran>> getRestaurant() async {
    try {
      var result = await http.get(
        Constants.instance.toApi('/restoran'),
        headers: headers,
      );
      List json = jsonDecode(result.body);
      List<Restoran> restoranList = [];
      json.forEach((element) {
        restoranList.add(Restoran.fromJson(element));
      });
      return restoranList;
    } catch (e) {
      print("getUserLogin catch $e");
      return [];
    }
  }

  Future<Restoran> getRestaurantDetail(String id) async {
    try {
      var result = await http.get(
        Constants.instance.toApi('/restoran/$id'),
        headers: headers,
      );
      List json = jsonDecode(result.body);
      List restoranList = [];
      json.forEach((element) {
        restoranList.add(Restoran.fromJson(element));
      });
      Restoran restoran = restoranList[0];
      List<Comments>? comments = [];
      if (restoran.comments != null) {
        restoran.comments!.forEach((element) {
          if (element.status == true) {
            comments.add(element);
          }
        });
      }
      List<Images>? images = [];
      if (restoran.images != null) {
        restoran.images!.forEach((element) {
          if (element.status == true) {
            images.add(element);
          }
        });
      }
      restoran.comments = comments;
      restoran.images = images;
      return restoran;
    } catch (e) {
      print("getRestaurantDetail catch $e");
      return Restoran();
    }
  }

  Future postComment(
      {required String comment,
      required String restoran_id,
      required String user_id,
      required String username,
      required String rating,
      required String imagePath}) async {
    try {
      var result = await http.post(Constants.instance.toApi('/comment'),
          headers: headers,
          body: jsonEncode({
            "restoran_id": int.tryParse(restoran_id),
            "user_id": user_id,
            "username": username,
            "comment": comment,
            "rating": rating,
            "imagePath": imagePath
          }));
      var body = jsonDecode(result.body);
      if (body['message'] != null) {
        return body['message'];
      }
      return true;
    } catch (e) {
      print("getUserLogin catch $e");
      return false;
    }
  }

  Future createRestoran({
    required String name,
    required String description,
    required double lat,
    required double long,
  }) async {
    try {
      var result = await http.post(Constants.instance.toApi('/restoran'),
          headers: headers,
          body: jsonEncode({
            "name": name,
            "description": description,
            "lat": lat.toString(),
            "long": long.toString(),
          }));

      var restoran = Restoran.fromJson(jsonDecode(result.body));

      return restoran;
    } catch (e) {
      print("createRestoran catch $e");
      return Restoran();
    }
  }

  Future banned({
    required String userId,
  }) async {
    try {
      var result = await http.put(
        Constants.instance.toApi('/user/$userId'),
        headers: headers,
      );
      var body = result.body;
      print(body);
      return true;
    } catch (e) {
      print("getUserLogin catch $e");
      return false;
    }
  }

  Future<List<AllParameters>> getAllParameters() async {
    try {
      var result = await http.get(
        Constants.instance.toApi('/restoran/admin'),
        headers: headers,
      );
      List json = jsonDecode(result.body);
      List<AllParameters> parameters = [];
      json.forEach((element) {
        parameters.add(AllParameters.fromJson(element));
      });

      return parameters;
    } catch (e) {
      print("getAllParameters catch $e");
      List<AllParameters> parameters = [];
      return parameters;
    }
  }

  changeParameters(
      {required String role,
      required String id,
      required String status}) async {
    try {
      await http.get(
        Constants.instance.toApi('/restoran/admin/$role/$id/$status'),
        headers: headers,
      );
      return true;
    } catch (e) {
      print("changeParameters catch $e");
      return false;
    }
  }
}
