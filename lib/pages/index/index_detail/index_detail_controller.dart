
import 'package:get/get.dart';

import '../../../api/api_client.dart';
import '../../../models/card_detail_data.dart';
import '../../../models/comment.dart';

class IndexDetailController extends GetxController {
  late CardDetailData cardDetailData;
  late int id;
  bool isLoading = true;
  bool isFail = false;
  List<Comment> commentList = [];

  @override
  void onInit() {
    super.onInit();
    id = Get.arguments["id"];
    getIndexDetailData(id);
    getCommentList();
  }

  void getIndexDetailData(int id) {
    ApiClient().getIndexDetailDataById(id).then((response) {
      if (response != null) {
        cardDetailData = response;
      } else {
        isFail = true;
      }
      update();
    }).catchError((onError) {
      isFail = true;
    }).whenComplete(() {
      isLoading = false;
    });
  }

  void getCommentList() {
    ApiClient().getCommentList().then((response) {
      commentList = response;
      update();
    });
  }
}
