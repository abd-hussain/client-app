import 'package:banner_carousel/banner_carousel.dart';
import 'package:client_app/models/https/home_response.dart';
import 'package:client_app/utils/constants/constant.dart';
import 'package:flutter/material.dart';

class MainBannerHomePage extends StatelessWidget {
  final List<MainBanner> bannerList;

  const MainBannerHomePage({required this.bannerList, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BannerCarousel(
      customizedBanners: _listOfBanners(bannerList),
      activeColor: const Color(0xff4CB6EA),
    );
  }

  List<Widget> _listOfBanners(List<MainBanner> commingList) {
    List<Widget> list = [];
    for (var item in commingList) {
      list.add(_banner(obj: item));
    }
    return list;
  }

  Widget _banner({required MainBanner obj}) {
    return InkWell(
      onTap: () {
        //TODO handle Tab Here click
        print(obj.actionType);
      },
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 0,
              blurRadius: 4,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Image.network(
          AppConstant.imagesBaseURLForBanners + obj.image!,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
