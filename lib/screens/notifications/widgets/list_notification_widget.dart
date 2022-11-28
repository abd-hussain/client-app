import 'package:client_app/models/https/notifications_response.dart';
import 'package:client_app/shared_widgets/custom_text.dart';
import 'package:client_app/shared_widgets/shimmers/shimmer_categories.dart';
import 'package:flutter/material.dart';

class NotificationsList extends StatelessWidget {
  final ValueNotifier<List<NotificationsResponseData>> notificationsListNotifier;
  final Function(NotificationsResponseData) onTap;
  const NotificationsList({super.key, required this.notificationsListNotifier, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<NotificationsResponseData>>(
        valueListenable: notificationsListNotifier,
        builder: (context, data, child) {
          return data.isEmpty
              ? const ShimmerCategoriesView()
              : ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (ctx, index) {
                    return notificationTile(context, data[index], index);
                  });
        });
  }

  Widget notificationTile(BuildContext context, NotificationsResponseData item, int index) {
    var parsedDate = DateTime.parse(item.createdAt!);
    var dateLocal = parsedDate.toLocal();

    return Padding(
      padding: const EdgeInsets.all(8),
      child: InkWell(
        onTap: () {
          onTap(item);
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(width: 5, color: item.readed! ? const Color(0xff4CB6EA) : Colors.white),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 3,
                blurRadius: 4,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Column(
                  children: [
                    const Icon(
                      Icons.notifications,
                      color: Color(0xff444444),
                    ),
                    CustomText(
                      title: "${dateLocal.year}/${dateLocal.month}/${dateLocal.day}",
                      fontSize: 9,
                      textColor: const Color(0xff444444),
                    ),
                    CustomText(
                      title: "${dateLocal.hour}:${dateLocal.minute}",
                      fontSize: 9,
                      textColor: const Color(0xff444444),
                    ),
                  ],
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      title: item.title!,
                      fontSize: 16,
                      textColor: const Color(0xff444444),
                      maxLins: 2,
                      fontWeight: FontWeight.bold,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 100,
                      child: CustomText(
                        title: item.content!,
                        fontSize: 14,
                        textColor: const Color(0xff444444),
                        maxLins: 15,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
