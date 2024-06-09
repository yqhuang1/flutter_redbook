import 'package:dio/dio.dart';

import '../base/model/IModel.dart';
import '../base/presenter/AbstractPresenter.dart';
import 'm_data.dart';
import 'mvp_callback.dart';

class PData extends AbstractPresenter<CDataView, CDataModel>
    implements CDataPresenter {
  @override
  IModel createModel() {
    return MData();
  }

  @override
  uploadPic(String file) async {
    ///上传图片的文件名称
    var name = file.substring(file.lastIndexOf("/") + 1, file.length);

    ///表单
    FormData _formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(
        file,
        filename: name,
      ),
    });
    view?.startLoading();
    return model?.uploadPic(_formData, (data) {
      view?.showLoadSuccess();
      view?.uploadPic(data);
      model?.dispose();
    }, (error) {
      view?.showLoadFailure(error.code!, error.message!);
    });
  }
}
