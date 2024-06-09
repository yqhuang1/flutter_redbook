import 'package:flutter/material.dart';
import 'package:flutter_redbook/base/presenter/IPresenter.dart';
import 'package:flutter_redbook/base/view/IView.dart';

abstract class BasePage extends StatefulWidget {
  BasePage({Key? key}) : super(key: key);

  @override
  BasePageState createState() => getState();

  ///子类实现
  BasePageState getState();
}

abstract class BasePageState<P extends IPresenter, V extends BasePage>
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
    return const Color(0xff00FFFFFF);
  }
}
