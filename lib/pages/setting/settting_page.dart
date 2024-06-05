import 'package:flutter/material.dart';
import 'package:flutter_redbook/pages/setting/setting_controller.dart';
import 'package:get/get.dart';

class SettingPage extends StatelessWidget {
  SettingPage({Key? key}) : super(key: key);
  final SettingController controller = Get.put(SettingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(0.2),
      appBar: AppBar(
        title: const Text("设置"),
        actions: const [],
      ),
      body: ListView(
        children: [
          Container(
            width: Get.width,
            padding: const EdgeInsets.all(4),
            margin: const EdgeInsets.fromLTRB(6.0, 12.0, 6.0, 12.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: <Widget>[
                buildListTile('账号与安全', '', () {}),
                buildListTile('隐私设置', '', () {}),
              ],
            ),
          ),
          Container(
            width: Get.width,
            padding: const EdgeInsets.all(4),
            margin: const EdgeInsets.fromLTRB(6.0, 12.0, 6.0, 12.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: <Widget>[
                buildListTile('通知设置', '', () {}),
                buildListTile('添加小组件', '', () {}),
                buildListTile('通用设置', '', () {}),
              ],
            ),
          ),
          Container(
            width: Get.width,
            padding: const EdgeInsets.all(4),
            margin: const EdgeInsets.fromLTRB(6.0, 12.0, 6.0, 12.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: <Widget>[
                buildListTile('青少年模式', '未开启', () {}),
                buildListTile('内容偏好调节', '', () {}),
                buildListTile('深色模式', '', () {}),
                buildListTile('字体大小', '', () {}),
              ],
            ),
          ),
          Container(
            width: Get.width,
            padding: const EdgeInsets.all(4),
            margin: const EdgeInsets.fromLTRB(6.0, 12.0, 6.0, 12.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: <Widget>[
                buildListTile('帮助与客服', '', () {}),
                buildListTile('鼓励一下', '', () {}),
                buildListTile('个人信息收集清单', '', () {}),
                buildListTile('第三方信息共享清单', '', () {}),
                buildListTile('关于Red Book', '', () {}),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildListTile(String text, String tip, Function onTap) {
    return ListTile(
      title: Text(text),
      onTap: () {
        onTap.call();
      },
      trailing: SizedBox(
        width: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              tip,
              style: const TextStyle(color: Colors.grey),
            ),
            Icon(
              Icons.chevron_right_outlined,
              color: Colors.grey,
              size: 25.0,
              semanticLabel: text,
            ),
          ],
        ),
      ),
    );
  }
}
