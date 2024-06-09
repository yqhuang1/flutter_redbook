import 'package:flutter/cupertino.dart';
import 'package:flutter_easy_permission/flutter_easy_permission.dart';
import 'package:flutter_redbook/common/utils/permission_utils.dart';
import 'package:image_picker/image_picker.dart';

import '../../widget/common_bottom_dialog.dart';

///选择相册+拍照
void selPhoCam(BuildContext context, State state,
    {titLab, ISelPicCallBack? iSelPicCallBack}) {
  ///选择图片（相册+拍照）
  comBotDialog(context, [
    {'label': '${titLab ?? '上传图片资料'}'},
    {'label': '拍照'},
    {'label': '从手机相册选择'},
    {'label': '取消'},
  ], (sleOpt) async {
    print('选项_$sleOpt');
    var label = '${sleOpt['label']}';
    switch (label) {
      case '拍照':
        bool _isHas = await requestCameraPermiss();
        print('是否开启相机权限：$_isHas');
        if (_isHas) {
          _addPicUpLoad(context, ImageSource.camera, iSelPicCallBack);
        }else{
          FlutterEasyPermission.showAppSettingsDialog(title: "开启相机或者相册权限");
        }
        break;
      case '从手机相册选择':
        bool _isHas = await requestPhotoPermiss();
        print('是否开启相册权限：$_isHas');
        if (_isHas) {
          _addPicUpLoad(context, ImageSource.gallery, iSelPicCallBack);
        }else{
          FlutterEasyPermission.showAppSettingsDialog(title: "开启相机或者相册权限");
        }
        break;
    }
  });
}

FlutterEasyPermission? _easyPermission;

void fluPerCallBack(
    BuildContext context,
    ) {
  _easyPermission = FlutterEasyPermission()
    ..addPermissionCallback(
      onGranted: (requestCode, perms, perm) {
        print("Android Authorized:$perms");
        print("iOS Authorized:$perm");
        print("iOS Deny authorization_camera:$requestCode");
      },
      onDenied: (requestCode, perms, perm, isPermanent) {
        /*if (isPermanent) {
          FlutterEasyPermission.showAppSettingsDialog(title: "开启相机或者相册权限");
        } else {
          print("Android Deny authorization:$perms");
          print("iOS Deny authorization:$perm");
        }*/
      },
    );
}

///权限关闭
void easyPerOff() {
  if (_easyPermission != null) {
    _easyPermission!.dispose();
  }
}

///添加图片并上传
void _addPicUpLoad(BuildContext context, ImageSource source,
    ISelPicCallBack? iSelPicCallBack) async {
  XFile? img = await ImagePicker().pickImage(
      source: source,
      maxWidth: MediaQuery.of(context).size.width,
      maxHeight: MediaQuery.of(context).size.height);
  if (img != null) {
    print("图片${img.path}");
    String picFilePath = img.path.replaceAll("File: ", "").replaceAll("'", "");
    iSelPicCallBack!(picFilePath);
  }
}

///拍照或者选择图片
typedef void ISelPicCallBack(picFile);
