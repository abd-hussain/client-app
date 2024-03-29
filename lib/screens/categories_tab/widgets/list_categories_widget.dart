import 'package:client_app/models/https/categories_model.dart';
import 'package:client_app/shared_widgets/custom_text.dart';
import 'package:client_app/shared_widgets/shimmers/shimmer_categories.dart';
import 'package:flutter/material.dart';

class CategoriesList extends StatefulWidget {
  final ValueNotifier<List<Category>> categoriesListNotifier;
  final Function(Category) onTap;

  const CategoriesList(
      {super.key, required this.categoriesListNotifier, required this.onTap});

  @override
  State<CategoriesList> createState() => _CategoriesListState();
}

class _CategoriesListState extends State<CategoriesList> {
  ValueNotifier<int> selectedIndex = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: ValueListenableBuilder<List<Category>>(
          valueListenable: widget.categoriesListNotifier,
          builder: (context, data, child) {
            return data.isEmpty
                ? const ShimmerCategoriesView()
                : ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (ctx, index) {
                      return categoriesTile(context, data[index], index);
                    });
          }),
    );
  }

  Widget categoriesTile(BuildContext context, Category item, int index) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, right: 4, bottom: 8),
      child: InkWell(
        onTap: () {
          selectedIndex.value = index;
          widget.onTap(item);
        },
        child: ValueListenableBuilder<int>(
            valueListenable: selectedIndex,
            builder: (context, snapshot, child) {
              return Container(
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                      width: 3,
                      color: snapshot == index
                          ? const Color(0xff4CB6EA)
                          : Colors.white),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 30,
                        height: 30,
                        child: FadeInImage(
                          placeholder: const AssetImage(
                              "assets/images/flagPlaceHolderImg.png"),
                          image: NetworkImage(item.icon!, scale: 1),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Expanded(
                        child: CustomText(
                          title: item.name!,
                          fontSize: 14,
                          textAlign: TextAlign.center,
                          textColor: const Color(0xff034061),
                          maxLins: 4,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
