import 'package:flutter/material.dart';
import 'package:flutter_redbook/widget/wx_text.dart';

Container addLine(BuildContext context) {
  ///添加线条
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 0.6,
    color: const Color(0xffE6E8ED),
  );
}

///添加可点击选项
addSelOpt(BuildContext context, selOptCallBack, var diaDataItem, bgColor,
    fontColor, fontSize, height, borderRadius) {
  ///选项
  return GestureDetector(
    onTap: () {
      ///关闭对话框
      Navigator.pop(context);

      ///点击取消按钮
      selOptCallBack(diaDataItem);
    },
    child: selOpt(context, diaDataItem, bgColor, fontColor, fontSize, height,
        borderRadius),
  );
}

selOpt(BuildContext context, var diaDataItem, bgColor, fontColor, fontSize,
    height, borderRadius) {
  return Container(
    width: MediaQuery.of(context).size.width,
    alignment: Alignment.center,
    height: height,
    decoration:
        BoxDecoration(color: Color(bgColor), borderRadius: borderRadius),
    child: commTextEll('${diaDataItem['label']}', 0xff1D1D1F, fontSize,
        FontWeight.normal, TextAlign.center),
  );
}

commTextEll(_label, _color, _fontSize, _fontWeight, _textAlign,
    {isCenEll = true, maxLines = 1}) {
  return isCenEll
      ? WXText(
          breakWord(_label)!,
          textAlign: _textAlign,
          style: TextStyle(
              color: Color(_color),
              fontSize: _fontSize,
              fontWeight: _fontWeight),
        )
      : Text(
          breakWord(_label)!,
          overflow: TextOverflow.ellipsis,
          textAlign: _textAlign,
          maxLines: maxLines,
          style: TextStyle(
              color: Color(_color),
              fontSize: _fontSize,
              fontWeight: _fontWeight),
        );
}

///overflow 属性省略号解决数字、长字母串整体显示省略号问题
String? breakWord(String? word) {
  if (word == null || word.isEmpty) {
    return word;
  }
  String breakWord = ' ';
  word.runes.forEach((element) {
    breakWord += String.fromCharCode(element);

    breakWord += '\u200B';
  });
  return breakWord;
}

void comBotDialog(BuildContext c, List<dynamic> diaData, selOptCallBack) {
  showModalBottomSheet(
      context: c,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        ///列表视图集合
        List<Widget> _diaChis = [];

        ///对话框文本数组大小
        // ignore: unnecessary_null_comparison
        int diaDataL = (diaData == null) ? 0 : diaData.length;
        for (int i = 0; i < diaDataL; i++) {
          if (i > 0 && i < diaDataL - 1) {
            ///选项
            _diaChis.add(addSelOpt(context, selOptCallBack, diaData[i],
                0xffFFFFFF, 0xff1D1D1F, 18.0, 56.0, null));

            ///添加线条
            _diaChis.add(addLine(context));
          } else {
            if (i == 0) {
              ///标题
              _diaChis.add(
                selOpt(
                    context,
                    diaData[i],
                    0xffFFFFFF,
                    0xffB8BABF,
                    12.0,
                    32.0,
                    const BorderRadius.only(
                        topLeft: Radius.circular(16.0),
                        topRight: Radius.circular(16.0))),
              );

              ///添加线条
              _diaChis.add(addLine(context));
            } else {
              ///最后一项
              _diaChis.add(
                Expanded(
                  flex: 1,
                  child: addSelOpt(context, selOptCallBack, diaData[i],
                      0xffF9FAFC, 0xff1D1D1F, 18.0, 72.0, null),
                ),
              );
            }
          }
        }

        ///对话框
        double _diaH =
            32.0 + (diaDataL - 2) * 56.0 + (diaDataL - 2) * 0.6 + 72.0;

        return Container(
          width: double.infinity,

          ///对话框列表高度
          height: _diaH,
          decoration: const BoxDecoration(
            color: Color(0xffFFFFFF),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.0),
                topRight: Radius.circular(16.0)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,

            ///列表视图集合
            children: _diaChis,
          ),
        );
      });
}

///选项点击事件
typedef void ISelOptCallBack(var sleOpt);
