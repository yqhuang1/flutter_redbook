import 'dart:collection';
import 'dart:core';

import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'http_error.dart';

///http请求成功回调
typedef HttpSuccessCallback<T> = void Function(dynamic data);

///失败回调
typedef HttpFailureCallback = void Function(HttpError data);

///数据解析回调
typedef T JsonParse<T>(dynamic data);

class HttpManager {
  ///同一个CancelToken可以用于多个请求，当一个CancelToken取消时，
  ///所有使用该CancelToken的请求都会被取消，一个页面对应一个CancelToken。
  Map<String, CancelToken> _cancelTokens = Map<String, CancelToken>();

  ///超时时间
  static const int CONNECT_TIMEOUT = 30000;
  static const int RECEIVE_TIMEOUT = 30000;

  /// http request methods
  static const String GET = 'get';
  static const String POST = 'post';

  Dio? _client;

  static final HttpManager _instance = HttpManager._internal();

  factory HttpManager() => _instance;

  Dio get client => _client!;

  /// 创建 dio 实例对象
  HttpManager._internal() {
    if (_client == null) {
      /// 全局属性：请求前缀、连接超时时间、响应超时时间
      BaseOptions options = BaseOptions(
        connectTimeout: const Duration(seconds: CONNECT_TIMEOUT),
        receiveTimeout: const Duration(seconds: RECEIVE_TIMEOUT),
      );
      _client = Dio(options);
    }
  }

  ///初始化公共属性
  /// [baseUrl] 地址前缀
  /// [connectTimeout] 连接超时赶时间
  /// [receiveTimeout] 接收超时赶时间
  /// [interceptors] 基础拦截器
  void init(
      {String? baseUrl,
      int? connectTimeout,
      int? receiveTimeout,
      List<Interceptor>? interceptors}) {
    _client!.options = _client!.options.copyWith(
      baseUrl: baseUrl,
      connectTimeout: Duration(seconds: connectTimeout ?? 0),
      receiveTimeout: Duration(seconds: receiveTimeout ?? 0),
    );
    if (interceptors != null && interceptors.isNotEmpty) {
      _client!.interceptors.addAll(interceptors);
    }
  }

  ///Get网络请求
  ///[url] 网络请求地址不包含域名
  ///[params] url请求参数支持restful
  ///[options] 请求配置
  ///[successCallback] 请求成功回调
  ///[errorCallback] 请求失败回调
  ///[tag] 请求统一标识，用于取消网络请求
  get({
    String? url,
    Map<String, dynamic>? params,
    Options? options,
    HttpSuccessCallback? successCallback,
    HttpFailureCallback? errorCallback,
    String? tag,
  }) async {
    return _request(
      url: url,
      params: params,
      method: GET,
      options: options,
      successCallback: successCallback!,
      errorCallback: errorCallback!,
      tag: tag!,
    );
  }

  ///post网络请求
  ///[url] 网络请求地址不包含域名
  ///[data] post 请求参数
  ///[params] url请求参数支持restful
  ///[options] 请求配置
  ///[successCallback] 请求成功回调
  ///[errorCallback] 请求失败回调
  ///[tag] 请求统一标识，用于取消网络请求
  post({
    String? url,
    data,
    Map<String, dynamic>? params,
    Options? options,
    HttpSuccessCallback? successCallback,
    HttpFailureCallback? errorCallback,
    @required String? tag,
  }) async {
    return _request(
      url: url!,
      data: data,
      method: POST,
      params: params!,
      options: options!,
      successCallback: successCallback!,
      errorCallback: errorCallback!,
      tag: tag!,
    );
  }

  ///统一网络请求
  ///[url] 网络请求地址不包含域名
  ///[data] post 请求参数
  ///[params] url请求参数支持restful
  ///[options] 请求配置
  ///[successCallback] 请求成功回调
  ///[errorCallback] 请求失败回调
  ///[tag] 请求统一标识，用于取消网络请求
  _request({
    String? url,
    String? method,
    data,
    Map<String, dynamic>? params,
    Options? options,
    HttpSuccessCallback? successCallback,
    HttpFailureCallback? errorCallback,
    @required String? tag,
  }) async {
    //检查网络是否连接
    ConnectivityResult connectivityResult =
        await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      if (errorCallback != null) {
        errorCallback(HttpError(HttpError.NETWORK_ERROR, "网络异常，请稍后重试！"));
      }
      return;
    }
    //设置默认值
    params = params ?? {};
    method = method ?? 'GET';
    options?.method = method;
    options = options ??
        Options(
          method: method,
        );

    ///请求头
    options.headers = await _headers();
    try {
      CancelToken cancelToken;
      cancelToken =
          (_cancelTokens[tag] == null ? CancelToken() : _cancelTokens[tag])!;
      _cancelTokens[tag!] = cancelToken;
      Response response = await _client!.request(url!,
          data: data,
          queryParameters: params,
          options: options,
          cancelToken: cancelToken);
      var _responseData = response.data;
      print('相应数据：$_responseData');
      return _responseData;
      /*int statusCode = _responseData["code"];
      if (statusCode == 200) {
        //成功
        successCallback!(_responseData["data"]);
      } else {
        //失败
        String message = _responseData["msg"].toString();
        errorCallback!(HttpError('$statusCode', message));
      }*/
    } on DioError catch (e, s) {
      if (e.type != DioErrorType.cancel) {
        errorCallback!(HttpError.dioError(e));
      }
    } catch (e, s) {
      errorCallback!(HttpError(HttpError.UNKNOWN, "未知错误，请稍后重试！"));
    }
  }

  ///上传文件
  ///
  ///[url] 网络请求地址不包含域名
  ///[data] post 请求参数
  ///[onSendProgress] 上传进度
  ///[params] url请求参数支持restful
  ///[options] 请求配置
  ///[successCallback] 请求成功回调
  ///[errorCallback] 请求失败回调
  ///[tag] 请求统一标识，用于取消网络请求
  void upload({
    required String? url,
    FormData? data,
    ProgressCallback? onSendProgress,
    Map<String, dynamic>? params,
    Options? options,
    HttpSuccessCallback? successCallback,
    HttpFailureCallback? errorCallback,
    @required String? tag,
  }) async {
    //检查网络是否连接
    ConnectivityResult connectivityResult =
        await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      if (errorCallback != null) {
        errorCallback(HttpError(HttpError.NETWORK_ERROR, "网络异常，请稍后重试！"));
      }
      print("请求网络异常，请稍后重试！");
      return;
    }
    //设置默认值
    params = params ?? {};
    //强制 POST 请求
    options?.method = POST;
    options = options ??
        Options(
          method: POST,
          contentType: "multipart/form-data",
        );

    ///请求头
    options.headers = await _headers();
    try {
      CancelToken? cancelToken;
      if (tag != null) {
        cancelToken =
            _cancelTokens[tag] == null ? CancelToken() : _cancelTokens[tag];
        _cancelTokens[tag] = cancelToken!;
      }

      Response response = await _client!.request(url!,
          onSendProgress: onSendProgress,
          data: data,
          queryParameters: params,
          options: options,
          cancelToken: cancelToken);
      var _responseData = response.data;
      return _responseData;
      /*int statusCode = _responseData["code"];
      if (statusCode == 200) {
        //成功
        successCallback!(_responseData["data"]);
      } else {
        //失败
        String message = _responseData["msg"].toString();
        errorCallback!(HttpError('$statusCode', message));
      }*/
    } on DioError catch (e, s) {
      print("请求出错：$e\n$s");
      if (errorCallback != null && e.type != DioErrorType.cancel) {
        errorCallback(HttpError.dioError(e));
      }
    } catch (e, s) {
      print("未知异常出错：$e\n$s");
      if (errorCallback != null) {
        errorCallback(HttpError(HttpError.UNKNOWN, "网络异常，请稍后重试！"));
      }
    }
  }

  ///取消网络请求
  void cancel(String tag) {
    if (_cancelTokens.containsKey(tag)) {
      if (!_cancelTokens[tag]!.isCancelled) {
        _cancelTokens[tag]!.cancel();
      }
      _cancelTokens.remove(tag);
    }
  }

  ///请求头
  Future<Map<String, String>> _headers() async {
    Map<String, String> _headers = new HashMap();
    String _token = '';
    _headers.addAll({"token": _token});
    return _headers;
  }
}
