import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../common/utils/public_utils.dart';
import '../video/video_controller.dart';

class HomeController extends GetxController {
  RxInt currentIndex = 0.obs;

  void onChangePage(int index) {
    if (index == 2) {
      openGallery();
    } else {
      currentIndex.value = index;
      if (Get.find<VideoController>().videos.isNotEmpty) {
        if (index == 1) {
          print("视频播放");
          PublicUtils.setStatusBarLight();
          Get.find<VideoController>().currentVideo.controller?.play();
        } else {
          print("视频暂停");
          PublicUtils.setStatusBarDark();
          Get.find<VideoController>().currentVideo.controller?.pause();
        }
      }
    }
  }

  void openGallery() async {
    final ImagePicker imagePicker = ImagePicker();
    final XFile? image =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      final String path = image.path;
      print(path);
    }
  }
}
