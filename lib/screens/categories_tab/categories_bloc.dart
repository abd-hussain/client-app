import 'package:client_app/locator.dart';
import 'package:client_app/models/https/categories_model.dart';
import 'package:client_app/models/https/mentors_model.dart';
import 'package:client_app/sevices/filter_services.dart';
import 'package:client_app/sevices/mentor_service.dart';
import 'package:client_app/utils/mixins.dart';
import 'package:flutter/material.dart';

class CategoriesBloc extends Bloc<FilterService> {
  final ValueNotifier<List<Category>> categoriesListNotifier = ValueNotifier<List<Category>>([]);
  final ValueNotifier<Category?> selectedCategoryNotifier = ValueNotifier<Category?>(null);
  final ValueNotifier<List<MentorsModelData>?> mentorsListNotifier = ValueNotifier<List<MentorsModelData>?>(null);

  void listOfCategories() {
    service.categories().then((value) {
      categoriesListNotifier.value = value.data!..sort((a, b) => a.id!.compareTo(b.id!));
      selectedCategoryNotifier.value = categoriesListNotifier.value[0];
      listOfMentors(categoryID: categoriesListNotifier.value[0].id!);
    });
  }

  void listOfMentors({required int categoryID}) {
    locator<MentorService>().mentors(categoryID).then((value) {
      if (value.data != null) {
        mentorsListNotifier.value = value.data!..sort((a, b) => a.id!.compareTo(b.id!));
      } else {
        mentorsListNotifier.value = [];
      }
    });
  }

  @override
  onDispose() {
    categoriesListNotifier.dispose();
    selectedCategoryNotifier.dispose();
    mentorsListNotifier.dispose();
  }
}
