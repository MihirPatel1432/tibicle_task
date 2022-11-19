import 'package:flutterprojectsetup/models/post.dart';
import 'package:get/get.dart';

import '../../domain/adapters/repository_adapter.dart';

class DashboardController extends SuperController<List<Post>> {
  DashboardController({required this.dashboardRepository});

  final IDashboardRepository dashboardRepository;

  @override
  void onInit() {
    super.onInit();

    //Loading, Success, Error handle with 1 line of code
    append(() => dashboardRepository.getPosts);
  }

  @override
  void onDetached() {}

  @override
  void onInactive() {}

  @override
  void onPaused() {}

  @override
  void onResumed() {}
}
