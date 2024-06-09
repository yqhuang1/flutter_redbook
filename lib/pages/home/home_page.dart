import 'package:flutter/material.dart';
import 'package:flutter_redbook/base/presenter/IPresenter.dart';
import 'package:flutter_redbook/base/view/IView.dart';
import 'package:get/get.dart';

import '../../base/base_page.dart';
import '../../common/utils/camera_utils.dart';
import '../../mvp/mvp_callback.dart';
import '../../mvp/p_data.dart';
import '../drawer/my_drawer.dart';
import '../main/main_page.dart';
import '../message/message_page.dart';
import '../mine/mine_page.dart';
import '../video/video_page.dart';
import 'home_controller.dart';

class HomePage extends BasePage {
  HomePage({Key? key}) : super(key: key);

  @override
  BasePageState<IPresenter<IView>, BasePage> getState() => _HomePageState();
}

class _HomePageState extends BasePageState<PData, HomePage>
    implements CDataView {
  final HomeController homeController = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    fluPerCallBack(context);
  }

  @override
  void dispose() {
    easyPerOff();
    super.dispose();
  }

  @override
  uploadPic(d) {
    // TODO: implement uploadPic
    throw UnimplementedError();
  }

  @override
  PData? createPresenter() {
    return PData();
  }

  @override
  buildWidget() {
    return Obx(
      () => Scaffold(
        body: IndexedStack(
          index: homeController.currentIndex.value,
          children: [
            MainPage(),
            homeController.currentIndex.value == 1 ? VideoPage() : Container(),
            Container(),
            MessagePage(),
            MinePage(),
          ],
        ),
        drawer: MyDrawer(),
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          child: BottomNavigationBar(
            elevation: 0,
            iconSize: 24,
            backgroundColor: homeController.currentIndex.value == 1
                ? Colors.black
                : Colors.white,
            selectedItemColor: homeController.currentIndex.value == 1
                ? Colors.white
                : Colors.black,
            unselectedItemColor: const Color(0xff999999),
            type: BottomNavigationBarType.fixed,
            currentIndex: homeController.currentIndex.value,
            unselectedFontSize: 16,
            selectedFontSize: 18,
            items: const [
              BottomNavigationBarItem(
                icon: SizedBox.shrink(),
                label: "首页",
              ),
              BottomNavigationBarItem(
                icon: SizedBox.shrink(),
                label: "视频",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.add_box,
                  size: 32,
                  color: Colors.red,
                ),
                label: "",
              ),
              BottomNavigationBarItem(
                icon: SizedBox.shrink(),
                label: "消息",
              ),
              BottomNavigationBarItem(
                icon: SizedBox.shrink(),
                label: "我",
              ),
            ],
            onTap: (index) {
              if (index == 2) {
                selPhoCam(context, this, titLab: '上传图片资料',
                    iSelPicCallBack: (picFile) {
                  print('通过拍照或者选择相册获取多图片：$picFile');
                  presenter!.uploadPic(picFile);
                });
              } else {
                homeController.onChangePage(index, context);
              }
            },
          ),
        ),
      ),
    );
  }
}
