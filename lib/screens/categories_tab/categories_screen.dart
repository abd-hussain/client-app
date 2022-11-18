import 'package:client_app/screens/categories_tab/categories_bloc.dart';
import 'package:client_app/screens/categories_tab/widgets/list_categories_widget.dart';
import 'package:client_app/screens/home_tab/widgets/header.dart';
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
  void initState() {
    logDebugMessage(message: 'Categories init Called ...');
    _bloc.listOfCategories();

    super.initState();
  }

  //TODO: Handle Home Page
  //TODO: Handle Search Page

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Column(
          children: [
            const HeaderHomePage(),
            const SizedBox(height: 8),
            Expanded(
              child: Row(
                children: [
                  CategoriesList(
                    categoriesListNotifier: _bloc.categoriesListNotifier,
                    onTap: (category) {},
                  ),
                  Container(
                    color: Colors.white,
                    width: MediaQuery.of(context).size.width - 110,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
