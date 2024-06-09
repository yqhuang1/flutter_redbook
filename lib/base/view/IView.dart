mixin class IView {
  ///开始加载
  void startLoading() {}

  ///加载成功
  void showLoadSuccess() {}

  ///加载失败
  void showLoadFailure(String code, String message) {}

  ///无数据
  void showEmptyData({String? emptyImage, String? emptyText}) {}

  ///带参数的对话框
  void startSubmit({String? message}) {}

  ///隐藏对话框
  void showSubmitSuccess() {}

  ///显示提交失败
  void showSubmitFailure(String code, String message) {}

  ///显示提示
  void showTips(String message) {}
}
