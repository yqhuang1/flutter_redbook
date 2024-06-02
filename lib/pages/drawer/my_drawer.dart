import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'my_drawer_controller.dart';

class MyDrawer extends StatelessWidget {
  MyDrawer({Key? key}) : super(key: key);
  final MyDrawerController controller = Get.put(MyDrawerController());

  // 菜单文本前面的图标大小
  static const double IMAGE_ICON_WIDTH = 30.0;

  // 菜单后面的箭头的图标大小
  static const double ARROW_ICON_WIDTH = 16.0;

  // 菜单后面的箭头图片
  var rightArrowIcon = Image.asset(
    'images/ic_arrow_right.png',
    width: ARROW_ICON_WIDTH,
    height: ARROW_ICON_WIDTH,
  );

  // 菜单的文本
  List menuTitles = ['创作中心', '我的草稿', '浏览记录', '订单', '购物车', '钱包', '社区公约'];

  // 菜单文本前面的图标
  List menuIcons = [
    Icons.lightbulb_outlined,
    Icons.drafts_outlined,
    Icons.history_outlined,
    Icons.menu_book_outlined,
    Icons.shopping_cart_outlined,
    Icons.wallet_outlined,
    Icons.grass_outlined
  ];

  // 菜单文本的样式
  TextStyle menuStyle = const TextStyle(fontSize: 15.0, color: Colors.black);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints.expand(width: 304.0),
      child: Material(
        elevation: 16.0,
        child: Column(
          children: <Widget>[
            ListTile(
              leading: const Icon(
                Icons.lightbulb_outlined,
                color: Colors.black,
                size: 28.0,
                semanticLabel: '创作中心',
              ),
              title: const Text('创作中心'),
              onTap: () {
                controller.openIndexDetailPage(0);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.drafts_outlined,
                color: Colors.black,
                size: 28.0,
                semanticLabel: '我的草稿',
              ),
              title: const Text('我的草稿'),
              onTap: () {
                controller.openIndexDetailPage(1);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.history_outlined,
                color: Colors.black,
                size: 28.0,
                semanticLabel: '浏览记录',
              ),
              title: const Text('浏览记录'),
              onTap: () {
                controller.openIndexDetailPage(2);
              },
            ),
            const Divider(
              thickness: 1.0,
              color: Colors.grey,
              indent: 15.0,
              endIndent: 15.0,
            ),
            ListTile(
              leading: const Icon(
                Icons.menu_book_outlined,
                color: Colors.black,
                size: 28.0,
                semanticLabel: '订单',
              ),
              title: const Text('订单'),
              onTap: () {
                Navigator.of(context).pop();
                controller.openIndexDetailPage(3);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.shopping_cart_outlined,
                color: Colors.black,
                size: 28.0,
                semanticLabel: '购物车',
              ),
              title: const Text('购物车'),
              onTap: () {
                Navigator.of(context).pop();
                controller.openIndexDetailPage(4);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.wallet_outlined,
                color: Colors.black,
                size: 28.0,
                semanticLabel: '钱包',
              ),
              title: const Text('钱包'),
              onTap: () {
                Navigator.of(context).pop();
                controller.openIndexDetailPage(5);
              },
            ),
            const Divider(
              thickness: 1.0,
              color: Colors.grey,
              indent: 15.0,
              endIndent: 15.0,
            ),
            ListTile(
              leading: const Icon(
                Icons.grass_outlined,
                color: Colors.black,
                size: 28.0,
                semanticLabel: '社区公约',
              ),
              title: const Text('社区公约'),
              onTap: () {
                Navigator.of(context).pop();
                controller.openIndexDetailPage(6);
              },
            ),
          ],
        ),
      ),
    );
  }
}
