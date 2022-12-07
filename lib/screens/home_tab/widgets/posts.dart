import 'package:client_app/models/https/posts_response.dart';
import 'package:client_app/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';

class PostsWidget extends StatelessWidget {
  final List<PostsResponseData> listOfPosts;
  final Function(int postId) voteUp;
  final Function(int postId) voteDown;
  final Function(PostsResponseData post) moreOption;

  const PostsWidget(
      {required this.listOfPosts, required this.voteUp, required this.voteDown, required this.moreOption, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: ListView.builder(
        itemCount: listOfPosts.length,
        itemBuilder: (context, index) {
          return item(listOfPosts[index]);
        },
      ),
    );
  }

  Widget item(PostsResponseData item) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 180,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 5),
              Row(
                children: [
                  const CircleAvatar(
                    radius: 15,
                    backgroundImage: NetworkImage(
                        'https://pub-static.fotor.com/assets/projects/pages/d5bdd0513a0740a8a38752dbc32586d0/fotor-03d1a91a0cec4542927f53c87e0599f6.jpg'),
                    backgroundColor: Colors.transparent,
                  ),
                  const SizedBox(width: 5),
                  const CustomText(
                    title: "Abed alrahman al haj hussain",
                    fontSize: 12,
                    textColor: Color(0xff444444),
                  ),
                  const Expanded(child: SizedBox()),
                  InkWell(
                    child: const Icon(Icons.more_vert),
                    onTap: () => moreOption(item),
                  )
                ],
              ),
              const Divider(),
              Expanded(
                child: CustomText(
                  title: item.content!,
                  fontSize: 12,
                  maxLins: 20,
                  fontWeight: FontWeight.w700,
                  textColor: const Color(0xff444444),
                ),
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () => voteUp(item.id!),
                    child: const Icon(
                      Icons.thumb_up,
                      color: Colors.green,
                    ),
                  ),
                  CustomText(
                    title: item.votes!.toString(),
                    fontSize: 12,
                    textColor: const Color(0xff444444),
                  ),
                  InkWell(
                    onTap: () => voteDown(item.id!),
                    child: const Icon(
                      Icons.thumb_down,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
