import 'package:client_app/models/https/categories_model.dart';
import 'package:client_app/shared_widgets/custom_text.dart';
import 'package:client_app/shared_widgets/shimmers/shimmer_categories.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CategoriesList extends StatelessWidget {
  final ValueNotifier<List<Category>> categoriesListNotifier;
  final Function(Category) onTap;

  CategoriesList({super.key, required this.categoriesListNotifier, required this.onTap});

  ValueNotifier<int> selectedIndex = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 110,
      child: ValueListenableBuilder<List<Category>>(
          valueListenable: categoriesListNotifier,
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
      padding: const EdgeInsets.only(top: 5, left: 8, right: 8, bottom: 5),
      child: InkWell(
        onTap: () {
          selectedIndex.value = index;
          onTap(item);
        },
        child: ValueListenableBuilder<int>(
            valueListenable: selectedIndex,
            builder: (context, snapshot, child) {
              return Container(
                height: 90,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(width: 5, color: snapshot == index ? const Color(0xff4CB6EA) : Colors.white),
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
                          placeholder: const AssetImage("assets/images/flagPlaceHolderImg.png"),
                          image: NetworkImage(item.icon!, scale: 1),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Expanded(
                        child: CustomText(
                          title: item.name!,
                          fontSize: 14,
                          textAlign: TextAlign.center,
                          textColor: const Color(0xff4CB6EA),
                          maxLins: 2,
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
