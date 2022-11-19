import 'package:flutter/material.dart';
import 'package:flutterprojectsetup/ui/dashboard/bindings/dashboard_binding.dart';
import 'package:flutterprojectsetup/ui/dashboard/presentation/views/dashboard_view.dart';
import 'package:flutterprojectsetup/ui/dashboard/presentation/views/profile_view.dart';
import 'package:get/get.dart';

class RouteName {
  static const init = root;

  // Base routes
  static const String root = '/';
  static const String profilePage = '/profile';
}

class Routes {
  static final routes = [
    GetPage(
        page: () => const DashboardView(),
        name: RouteName.root,
        binding: DashboardBinding(),
        children: [
          GetPage(page: () => const ProfileView(), name: RouteName.profilePage)
        ])
  ];
  static final commonRoutes = <String, WidgetBuilder>{};
}
