import 'package:get/get.dart';

import '../constants/pages.dart';
import 'home/home_page.dart';
import 'index/index_detail/index_detail_page.dart';
import 'init/init_page.dart';

class Routes {
  static final List<GetPage> getPages = [
    GetPage(name: Pages.init, page: () => InitPage()),
    GetPage(name: Pages.home, page: () => HomePage()),
    GetPage(name: Pages.indexDetail, page: () => IndexDetailPage()),
    GetPage(name: Pages.followDetail, page: () => IndexDetailPage())
  ];
}
