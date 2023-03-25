import 'package:client_app/models/https/categories_model.dart';
import 'package:client_app/models/https/mentors_model.dart';
import 'package:client_app/screens/categories_tab/categories_bloc.dart';
import 'package:client_app/screens/categories_tab/widgets/list_categories_widget.dart';
import 'package:client_app/screens/categories_tab/widgets/main_view_widget.dart';
import 'package:client_app/utils/logger.dart';
import 'package:flutter/material.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final _bloc = CategoriesBloc();

  @override
  void didChangeDependencies() {
    logDebugMessage(message: 'Categories init Called ...');
    _bloc.listOfCategories();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _bloc.onDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Column(
        children: [
          const SizedBox(height: 8),
          Expanded(
            child: Row(
              children: [
                CategoriesList(
                  categoriesListNotifier: _bloc.categoriesListNotifier,
                  onTap: (category) {
                    _bloc.selectedCategoryNotifier.value = category;
                    _bloc.listOfMentors(categoryID: category.id!);
                  },
                ),
                ValueListenableBuilder<Category?>(
                    valueListenable: _bloc.selectedCategoryNotifier,
                    builder: (context, snapshot1, chuld) {
                      if (snapshot1 != null) {
                        return ValueListenableBuilder<List<MentorsModelData>?>(
                            valueListenable: _bloc.mentorsListNotifier,
                            builder: (context, snapshot2, child) {
                              return CategoryMainView(
                                selectedCategory: snapshot1,
                                mentorsListNotifier: snapshot2,
                              );
                            });
                      } else {
                        return Container();
                      }
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
