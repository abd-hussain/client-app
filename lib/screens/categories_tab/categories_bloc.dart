import 'package:client_app/models/https/categories_model.dart';
import 'package:client_app/sevices/filter_services.dart';
import 'package:client_app/utils/mixins.dart';
import 'package:flutter/material.dart';

class CategoriesBloc extends Bloc<FilterService> {
  final ValueNotifier<List<Category>> categoriesListNotifier = ValueNotifier<List<Category>>([]);

  void listOfCategories() {
    service.categories().then((value) {
      categoriesListNotifier.value = value.data!..sort((a, b) => a.id!.compareTo(b.id!));
    });
  }
}
