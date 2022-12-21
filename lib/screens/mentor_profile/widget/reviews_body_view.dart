import 'package:client_app/models/https/mentor_details_model.dart';
import 'package:client_app/shared_widgets/custom_text.dart';
import 'package:client_app/utils/constants/constant.dart';
import 'package:client_app/utils/day_time.dart';
import 'package:flutter/material.dart';

class ReviewBodyView extends StatelessWidget {
  final List<Reviews> reviews;
  const ReviewBodyView({required this.reviews, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView.builder(
          itemCount: reviews.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 4,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8, top: 16, bottom: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: const Color(0xff034061),
                            radius: 20,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: reviews[index].clientProfileImg != ""
                                  ? FadeInImage(
                                      placeholder: const AssetImage("assets/images/avatar.jpeg"),
                                      image: NetworkImage(
                                          AppConstant.imagesBaseURLForProfileImages + reviews[index].clientProfileImg!,
                                          scale: 1),
                                    )
                                  : Image.asset(
                                      'assets/images/avatar.jpeg',
                                      width: 110.0,
                                      height: 110.0,
                                      fit: BoxFit.fill,
                                    ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width - 100,
                                child: CustomText(
                                  title: DayTime().dateFormatter(reviews[index].createdAt!),
                                  fontSize: 10,
                                  textAlign: TextAlign.end,
                                  fontWeight: FontWeight.bold,
                                  textColor: const Color(0xff554d56),
                                ),
                              ),
                              CustomText(
                                title: "${reviews[index].clientFirstName!} ${reviews[index].clientLastName!}",
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                textColor: const Color(0xff554d56),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      CustomText(
                        title: reviews[index].comments!,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        maxLins: 10,
                        textColor: const Color(0xff554d56),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
