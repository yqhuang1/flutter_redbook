import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/pages.dart';

class MyDrawerController extends GetxController {
  late TabController tabController;

  void openIndexDetailPage(int id) {
    Get.toNamed(Pages.indexDetail, arguments: {"id": id});
  }

  void openSettingPage() {
    Get.toNamed(Pages.setting);
  }
}
