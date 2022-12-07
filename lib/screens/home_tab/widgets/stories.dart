// import 'package:client_app/shared_widgets/custom_text.dart';
import 'package:client_app/models/https/home_response.dart';
import 'package:client_app/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';

class StoriesHomePage extends StatelessWidget {
  final List<Stories> listOfStories;
  const StoriesHomePage({required this.listOfStories, Key? key}) : super(key: key);

  //TODO : Handle Stories
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: listOfStories.length,
        itemBuilder: (context, index) {
          return storyWidget(listOfStories[index]);
        },
      ),
    );
  }

  Widget storyWidget(Stories story) {
    return SizedBox(
      width: 75,
      child: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8),
        child: Column(
          children: [
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.blueAccent, width: 3),
              ),
            ),
            const CustomText(
              title: "Abed alrahman al haj hussain",
              fontSize: 10,
              maxLins: 3,
              textAlign: TextAlign.center,
              textColor: Color(0xff444444),
            ),
          ],
        ),
      ),
    );
  }
}
