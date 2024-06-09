import 'package:flutter_easy_permission/constants.dart';
import 'package:flutter_easy_permission/flutter_easy_permission.dart';

///是否询问相机权限
bool _isReqCamPer=false;

///申请相机+相册权限
Future<bool> requestCameraPermiss() async {
  //多个权限申请
  const permissions = [
    Permissions.CAMERA,
  ];
  const permissionGroup = [PermissionGroup.Camera];

  bool _hasPer = await FlutterEasyPermission.has(
      perms: permissions, permsGroup: permissionGroup);


  ///已经开启权限
  if (_hasPer) {
    return true;
  }

  print('没有开启权限');
  FlutterEasyPermission.request(
      perms: permissions, permsGroup: permissionGroup, rationale: "需要开启相机权限");
  return false;
}

Future<bool> requestPhotoPermiss() async {
  //多个权限申请
  const permissions = [
    Permissions.WRITE_EXTERNAL_STORAGE,
  ];
  const permissionGroup = [PermissionGroup.Photos];
  bool _hasPer = await FlutterEasyPermission.has(
      perms: permissions, permsGroup: permissionGroup);

  ///已经开启权限
  if (_hasPer) {
    return true;
  }
  FlutterEasyPermission.request(
      perms: permissions, permsGroup: permissionGroup, rationale: "需要开启相册权限");
  return false;
}
