import 'package:flutter/material.dart';

void alertDialog(BuildContext context) async {
  var result = await showDialog(
      barrierDismissible: false, //表示点击灰色背景的时候是否消失弹出框
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("提示信息!"),
          content: const Text("您确定要删除吗"),
          actions: [
            TextButton(
                onPressed: () {
                  print("ok");
                  Navigator.of(context).pop("ok"); //点击按钮让AlertDialog消失
                },
                child: const Text("确定")),
            TextButton(
                onPressed: () {
                  print("cancel");
                  Navigator.of(context).pop("取消");
                },
                child: const Text("取消"))
          ],
        );
      });

  print("-----------");
  print(result);
}

void simpleDialog(BuildContext context) async {
  var result = await showDialog(
      barrierDismissible: false, //表示点击灰色背景的时候是否消失弹出框
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text("请选择语言"),
          children: [
            SimpleDialogOption(
              onPressed: () {
                print("汉语");
                Navigator.pop(context, "汉语");
              },
              child: const Text("汉语"),
            ),
            const Divider(),
            SimpleDialogOption(
              onPressed: () {
                print("英语");
                Navigator.pop(context, "英语");
              },
              child: const Text("英语"),
            ),
            const Divider(),
            SimpleDialogOption(
              onPressed: () {
                print("日语");
                Navigator.pop(context, "日语");
              },
              child: const Text("日语"),
            ),
            const Divider(),
          ],
        );
      });
  print("-----------");
  print(result);
}
