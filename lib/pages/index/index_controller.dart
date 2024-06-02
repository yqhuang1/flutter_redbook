import 'package:flutter/material.dart';
import 'package:flutter_redbook/models/follow_data.dart';
import 'package:get/get.dart';

import '../../api/api_client.dart';
import '../../constants/pages.dart';
import '../../models/card_data.dart';

class IndexController extends GetxController with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  List<CardData> data = [];
  List<FollowData> followData = [];

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 3, vsync: this, initialIndex: 1);
    getIndexData();
    getFollowData();
  }

  void getIndexData() {
    ApiClient().getIndexData().then((response) {
      data = response;
      update();
    });
  }

  void getFollowData() {
    ApiClient().getFollowData().then((response) {
      followData = response;
      update();
    });
  }

  void openIndexDetailPage(int id) {
    Get.toNamed(Pages.indexDetail, arguments: {"id": id});
  }

  void openFollowDetailPage(int id) {
    Get.toNamed(Pages.followDetail, arguments: {"id": id});
  }
}
