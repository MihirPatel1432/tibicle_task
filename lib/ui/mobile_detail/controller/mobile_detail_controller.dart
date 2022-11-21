import 'package:flutter/cupertino.dart';
import 'package:flutterprojectsetup/models/mobile_image_response.dart';
import 'package:get/get.dart';

import '../../../di/api_provider.dart';
import '../../../models/mobile_item_response.dart';

class MobileDetailController extends SuperController {
  PageController pageController = PageController();
  RxList<MobileImageResponse> imageList = <MobileImageResponse>[].obs;
  MobileItemResponse? mobileItemResponse;
  RxInt selectedIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      mobileItemResponse = Get.arguments;
    }
    getMobileImageList(mobileItemResponse?.id ?? 0);
  }

  @override
  void onDetached() {
    // TODO: implement onDetached
  }

  @override
  void onInactive() {
    // TODO: implement onInactive
  }

  @override
  void onPaused() {
    // TODO: implement onPaused
  }

  @override
  void onResumed() {
    // TODO: implement onResumed
  }

  Future<void> getMobileImageList(int id) async {
    ApiProvider()
        .get('https://scb-test-mobile.herokuapp.com/api/mobiles/$id/images')
        .then((value) {
      if (value.statusCode == 200) {
        final response = value.body as List<dynamic>;
        for (int i = 0; i < response.length; i++) {
          imageList.add(MobileImageResponse.fromJson(response[i]));
        }
        debugPrint('@52:::${imageList.length}');
      }
    });
  }
}
