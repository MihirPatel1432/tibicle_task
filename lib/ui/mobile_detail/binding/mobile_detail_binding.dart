import 'package:flutterprojectsetup/ui/mobile_detail/controller/mobile_detail_controller.dart';
import 'package:get/get.dart';

class MobileDetailBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<MobileDetailController>(() => MobileDetailController());
  }

}