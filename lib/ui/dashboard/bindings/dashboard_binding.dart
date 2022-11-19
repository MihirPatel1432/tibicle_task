import 'package:get/get.dart';
import '../data/dashboard_api_provider.dart';

import '../data/dashboard_repository.dart';
import '../domain/adapters/repository_adapter.dart';
import '../presentation/controllers/home_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IDashboardProvider>(() => DashboardProvider());
    Get.lazyPut<IDashboardRepository>(() => DashboardRepository(provider: Get.find()));
    Get.lazyPut(() => DashboardController(dashboardRepository: Get.find()));
  }
}
