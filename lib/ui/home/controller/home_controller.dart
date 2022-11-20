import 'package:flutter/material.dart';
import 'package:flutterprojectsetup/di/api_provider.dart';
import 'package:get/get.dart';

import '../../../models/mobile_item_response.dart';

class HomeController extends SuperController with GetSingleTickerProviderStateMixin{

  TabController? tabController;
  RxList<MobileItemResponse> mobileList = <MobileItemResponse>[].obs;


  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
    getMobileList();
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


  Future<void> getMobileList() async {
    ApiProvider().get('https://scb-test-mobile.herokuapp.com/api/mobiles/').then((value){
      if(value.statusCode == 200){
        final response = value.body as List<dynamic>;
        for(int i = 0; i < response.length ; i ++){
          mobileList.add(MobileItemResponse.fromJson(response[i]));
        }
        debugPrint('@48:::${mobileList.length}');
      }
    });

  }

}