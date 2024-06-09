import 'package:dio/dio.dart';

import '../base/model/IModel.dart';
import '../base/presenter/IPresenter.dart';
import '../base/view/IView.dart';

///图片上传
abstract class CDataModel extends IModel {
  ///
  uploadPic(FormData formData, SuccessCallback s, FailureCallback f);
}

abstract class CDataPresenter extends IPresenter {
  ///上传图片
  uploadPic(String file);
}

abstract class CDataView extends IView {
  ///
  uploadPic(d);
}
