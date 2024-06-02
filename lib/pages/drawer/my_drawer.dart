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
        child: ListView.builder(
          itemCount: menuTitles.length * 2,
          itemBuilder: renderDrawerRow,
          padding: const EdgeInsets.all(0.0), // 加上这一行可以让Drawer展开时，状态栏中不显示白色
        ),
      ),
    );
  }

  Widget renderDrawerRow(BuildContext context, int index) {
    if (index.isOdd) {
      // 如果是奇数则渲染分割线
      if ((index + 1) % 6 == 0) {
        return const Divider(
          thickness: 1.0,
          color: Colors.grey,
          indent: 15.0,
          endIndent: 15.0,
        );
      } else {
        return const Divider(
          thickness: 1.0,
          color: Colors.white,
          indent: 15.0,
          endIndent: 15.0,
        );
      }
    }
    // 偶数，就除2取整，然后渲染菜单item
    index = index ~/ 2;
    // 菜单item组件
    var listItemContent = Padding(
      // 设置item的外边距
      padding: const EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
      // Row组件构成item的一行
      child: Row(
        children: <Widget>[
          // 菜单item的图标
          Icon(
            menuIcons[index],
            color: Colors.black,
            size: 28.0,
            semanticLabel: menuTitles[index],
          ),
          // 菜单item的文本，需要
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              menuTitles[index],
              style: menuStyle,
            ),
          ),
          const Spacer(),
          rightArrowIcon,
        ],
      ),
    );

    return InkWell(
      child: listItemContent,
      onTap: () {
        switch (index) {
          case 0:
          case 1:
          case 2:
          case 3:
          case 4:
          case 5:
          case 6:
            controller.openIndexDetailPage(index + 1);
            break;
        }
      },
    );
  }
}
