import 'package:dio/dio.dart';

import '../base/model/AbstractModel.dart';
import '../common/utils/http/http_manager.dart';
import 'mvp_callback.dart';

class MData extends AbstractModel implements CDataModel {
  @override
  void dispose() {
    // TODO: implement dispose
    HttpManager().cancel(tag!);
  }

  @override
  uploadPic(FormData data, s, f) async {
    return HttpManager().upload(
        url: '图片上传地址',
        tag: tag!,
        successCallback: (data) {
          s(data);
        },
        errorCallback: (data) {
          f(data);
        },
        data: data);
  }
}
