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
            buildListTile(Icons.lightbulb_outlined, Colors.black, '创作中心', () {
              controller.openIndexDetailPage(0);
            }),
            buildListTile(Icons.drafts_outlined, Colors.black, '我的草稿', () {
              controller.openIndexDetailPage(1);
            }),
            buildListTile(Icons.history_outlined, Colors.black, '浏览记录', () {
              controller.openIndexDetailPage(2);
            }),
            const Divider(
              thickness: 1.0,
              color: Colors.grey,
              indent: 15.0,
              endIndent: 15.0,
            ),
            buildListTile(Icons.menu_book_outlined, Colors.black, '订单', () {
              Navigator.of(context).pop();
              controller.openIndexDetailPage(3);
            }),
            buildListTile(Icons.shopping_cart_outlined, Colors.black, '购物车',
                () {
              Navigator.of(context).pop();
              controller.openIndexDetailPage(4);
            }),
            buildListTile(Icons.wallet_outlined, Colors.black, '钱包', () {
              Navigator.of(context).pop();
              controller.openIndexDetailPage(5);
            }),
            const Divider(
              thickness: 1.0,
              color: Colors.grey,
              indent: 15.0,
              endIndent: 15.0,
            ),
            buildListTile(Icons.grass_outlined, Colors.black, '社区公约', () {
              Navigator.of(context).pop();
              controller.openIndexDetailPage(6);
            }),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  buildIcon(Icons.settings_outlined, "设置", Colors.grey, () {
                    Navigator.of(context).pop();
                    controller.openSettingPage();
                  }),
                  buildIcon(Icons.headset_outlined, "帮助与客服", Colors.grey, () {
                    Navigator.of(context).pop();
                    controller.openIndexDetailPage(7);
                  }),
                  buildIcon(Icons.qr_code_scanner_outlined, "扫一扫", Colors.grey,
                      () {
                    Navigator.of(context).pop();
                    controller.openIndexDetailPage(8);
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildListTile(
      IconData icons, Color color, String text, Function onTap) {
    return ListTile(
      leading: Icon(
        icons,
        color: color,
        size: 28.0,
        semanticLabel: text,
      ),
      title: Text(text),
      onTap: () {
        onTap.call();
      },
    );
  }

  Widget buildIcon(IconData icons, String text, Color color, Function onTap) {
    return GestureDetector(
      onTap: () {
        onTap.call();
      },
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(50.0),
            ),
            child: Icon(icons, size: 25),
          ),
          Text(text,
              style: TextStyle(
                color: color,
              )),
        ],
      ),
    );
  }
}
