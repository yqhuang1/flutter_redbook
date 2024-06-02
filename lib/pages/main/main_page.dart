import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redbook/models/follow_data.dart';
import 'package:get/get.dart';

import '../../constants/color_plate.dart';
import '../../models/card_data.dart';
import 'main_controller.dart';

class MainPage extends StatelessWidget {
  MainPage({Key? key}) : super(key: key);
  final MainController controller = Get.put(MainController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorPlate.background,
        body: Column(
          children: [
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      controller.openDrawerPage(context);
                    },
                    child: Image.asset("assets/images/world.png",
                        width: 30, height: 30),
                  ),
                  SizedBox(
                    height: 30,
                    width: 200,
                    child: TabBar(
                      labelColor: Colors.black,
                      dividerColor: Colors.transparent,
                      indicatorColor: ColorPlate.primary,
                      controller: controller.tabController,
                      tabs: const [
                        Tab(text: "关注"),
                        Tab(text: "发现"),
                        Tab(text: "购物"),
                      ],
                    ),
                  ),
                  Image.asset("assets/images/search.png",
                      width: 30, height: 30),
                ],
              ),
            ),
            Expanded(
              child: GetBuilder<MainController>(
                builder: (_) {
                  return TabBarView(
                    controller: controller.tabController,
                    children: [
                      buildFollowPage(),
                      buildDiscoverPage(),
                      buildShoppingPage(),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildFollowPage() {
    return ListView(
      children: [
        Column(
          children:
              controller.followData.map((e) => buildFollowItem(e)).toList(),
        )
      ],
    );
  }

  Widget buildDiscoverPage() {
    return ListView(
      children: [
        Row(
          children: [
            Column(
              children:
                  controller.discoverData.map((e) => buildCardItem(e)).toList(),
            ),
            Column(
              children: controller.discoverData.reversed
                  .map((e) => buildCardItem(e))
                  .toList(),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildShoppingPage() {
    return const Center(child: Text("正在开发"));
  }

  Widget buildFollowItem(FollowData followData) {
    return Container(
      width: Get.width - 8,
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
            child: Row(
              children: [
                ClipOval(
                  child: Image.network(followData.avatar,
                      width: 30, height: 30, fit: BoxFit.cover),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(followData.nickname),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Text(followData.date),
                ),
              ],
            ),
          ),
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
            child: SizedBox(
              height: Get.height,
              child: Swiper(
                itemBuilder: (BuildContext context, int index) {
                  return Image.network(
                    followData.images[index],
                    width: Get.width,
                    fit: BoxFit.contain,
                  );
                },
                loop: false,
                itemCount: followData.images.length,
                indicatorLayout: PageIndicatorLayout.SCALE,
                pagination: const SwiperPagination(
                  builder: DotSwiperPaginationBuilder(
                    activeColor: ColorPlate.primary,
                    color: ColorPlate.grey,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
            child: Row(
              children: [
                Image.asset("assets/images/share.png", width: 30),
                const Spacer(),
                Image.asset("assets/images/like.png", width: 30, height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(followData.like.toString()),
                ),
                Image.asset("assets/images/fav.png", width: 30, height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(followData.fav.toString()),
                ),
                Image.asset("assets/images/comment.png", width: 30, height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(followData.comment.toString()),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
            child: Text(followData.content,
                maxLines: 2, overflow: TextOverflow.ellipsis),
          ),
        ],
      ),
    );
  }

  Widget buildCardItem(CardData cardData) {
    return GestureDetector(
      onTap: () {
        controller.openIndexDetailPage(cardData.id);
      },
      child: Container(
        width: (Get.width / 2) - 8,
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(4)),
              child: Image.network(
                cardData.cover,
                width: Get.width / 2,
                height: Get.width / 2 + 30,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
              child: Text(cardData.content,
                  maxLines: 2, overflow: TextOverflow.ellipsis),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
              child: Row(
                children: [
                  ClipOval(
                    child: Image.network(cardData.avatar,
                        width: 20, height: 20, fit: BoxFit.cover),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(cardData.nickname),
                  ),
                  const Spacer(),
                  Image.asset("assets/images/like.png", width: 20),
                  Text(cardData.fav.toString())
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
