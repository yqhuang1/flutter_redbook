import 'package:flutter/material.dart';

import '../presenter/IPresenter.dart';
import 'IView.dart';

abstract class BaseView extends StatefulWidget {
  BaseView({Key? key}) : super(key: key);

  @override
  BaseViewState createState() => getState();

  ///子类实现
  BaseViewState getState();
}

abstract class BaseViewState<P extends IPresenter, V extends BaseView>
    extends State<V> with IView {
  P? presenter;

  @override
  void initState() {
    super.initState();

    presenter = createPresenter();
    if (presenter != null) {
      presenter?.attachView(this);
    }
  }

  P? createPresenter() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ///导航栏
      appBar: buildAppBar(),

      ///内容区域
      body: buildWidget(),

      ///内容区域背景颜色
      backgroundColor: buildBodyColor(),
    );
  }

  buildWidget();

  buildAppBar() => null;

  Color buildBodyColor() {
    return Color(0xff00FFFFFF);
  }
}
