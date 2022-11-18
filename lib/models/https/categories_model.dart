import 'package:client_app/utils/constants/constant.dart';

class CategoriesModel {
  List<Category>? data;
  String? message;

  CategoriesModel({this.data, this.message});

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Category>[];
      json['data'].forEach((v) {
        data!.add(Category.fromJson(v));
      });
    }
    message = json['message'];
  }
}

class Category {
  int? id;
  String? name;
  String? icon;
  String? description;

  Category({this.id, this.name, this.icon, this.description});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    icon = AppConstant.imagesBaseURLForCategories + json['icon'];
    name = json['name'];
    description = json['description'];
  }
}
