import 'package:flutter/material.dart';

void shareBottomDialog(BuildContext context, callBack) {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return _buildShareWidget(context, callBack);
      });
}

Widget _buildShareWidget(BuildContext context, callBack) {
  List<String> nameItems = [
    '微信',
    '朋友圈',
    'QQ',
    'QQ空间',
    '新浪微博',
    'FaceBook',
    '邮件',
    'Keep'
  ];
  List<String> iconItems = [
    'icon_wechat.png',
    'icon_pyq.png',
    'icon_qq.png',
    'icon_qq_zone.png',
    'icon_sina_weibo.png',
    'icon_facebook.png',
    'icon_mail.png',
    'icon_keep.png'
  ];

  return SizedBox(
    height: 250.0,
    child: Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
          child: SizedBox(
            height: 190,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 5.0,
                  childAspectRatio: 1.0),
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    callBack(index);
                  },
                  child: Column(
                    children: <Widget>[
                      Padding(
                          padding:
                              const EdgeInsets.fromLTRB(0.0, 6.0, 0.0, 6.0),
                          child: Image.asset(
                            'images/icons/${iconItems[index]}',
                            width: 50.0,
                            height: 50.0,
                            fit: BoxFit.fill,
                          )),
                      Text(nameItems[index]),
                    ],
                  ),
                );
              },
              itemCount: nameItems.length,
            ),
          ),
        ),
        Container(
          height: 0.5,
          color: Colors.blueGrey,
        ),
        InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: const Center(
            child: Padding(
                padding: EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
                child: Text(
                  '取  消',
                  style: TextStyle(fontSize: 18.0, color: Colors.blueGrey),
                )),
          ),
        ),
      ],
    ),
  );
}
