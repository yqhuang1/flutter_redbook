// 使用mock数据，这里仅模范网络请求
import '../mock/mock.dart';

class ApiClient {
  ApiClient._internal();

  factory ApiClient() => _instance;
  static final ApiClient _instance = ApiClient._internal();

  // 获取首页"发现"数据
  Future getIndexData() async {
    await Future.delayed(const Duration(seconds: 1));
    return await Future.value(Mock.indexData);
  }

  // 点击首页"发现"卡片，进入详情数据
  Future getIndexDetailDataById(int id) async {
    await Future.delayed(const Duration(seconds: 1));
    for (var v in Mock.cardDetailDataList) {
      if (v.id == id) {
        return await Future.value(v);
      }
    }
    return null;
  }

  Future getCommentList() async {
    await Future.delayed(const Duration(seconds: 1));
    return await Future.value(Mock.commentList);
  }

  Future getVideoList() async {
    await Future.delayed(const Duration(seconds: 1));
    return await Future.value(Mock.videoList);
  }

  // 获取首页"发现"数据
  Future getDiscoverData() async {
    await Future.delayed(const Duration(seconds: 1));
    return await Future.value(Mock.discoverData);
  }

  Future getFollowData() async {
    await Future.delayed(const Duration(seconds: 1));
    return await Future.value(Mock.followData);
  }
}
