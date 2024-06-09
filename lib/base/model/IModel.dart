import '../../common/utils/http/http_error.dart';

abstract class IModel {
  ///释放网络请求
  void dispose();
}

typedef SuccessCallback<T> = void Function(dynamic data);

typedef FailureCallback = void Function(HttpError error);
