import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchHomePage extends StatelessWidget {
  // TextEditingController controller = TextEditingController();

  const SearchHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: CupertinoSearchTextField(
        onChanged: (value) {},
        onSubmitted: (value) {},
        controller: TextEditingController(),
        itemSize: 30,
        itemColor: const Color(0xff034061),
        prefixIcon: const Icon(CupertinoIcons.search, size: 20),
        suffixIcon: const Icon(CupertinoIcons.clear, size: 20),
      ),
    );
  }
}
