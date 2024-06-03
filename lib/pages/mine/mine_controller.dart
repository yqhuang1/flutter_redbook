import 'dart:js';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../api/api_client.dart';
import '../../constants/pages.dart';
import '../../models/card_data.dart';

class MineController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  List<CardData> data = [];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    tabController = TabController(length: 3, vsync: this);
    getIndexData();
  }

  void getIndexData() {
    ApiClient().getIndexData().then((response) {
      data = response;
      update();
    });
  }

  void openIndexDetailPage(int id) {
    Get.toNamed(Pages.indexDetail, arguments: {"id": id});
  }

  void openDrawerPage(BuildContext context) {
    Scaffold.of(context).openDrawer();
  }
}
