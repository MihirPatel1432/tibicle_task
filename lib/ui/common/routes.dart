import 'package:flutter/material.dart';
import 'package:flutterprojectsetup/ui/dashboard/bindings/dashboard_binding.dart';
import 'package:flutterprojectsetup/ui/dashboard/presentation/views/dashboard_view.dart';
import 'package:flutterprojectsetup/ui/dashboard/presentation/views/profile_view.dart';
import 'package:flutterprojectsetup/ui/home/binding/home_binding.dart';
import 'package:flutterprojectsetup/ui/home/view/home_view.dart';
import 'package:flutterprojectsetup/ui/mobile_detail/binding/mobile_detail_binding.dart';
import 'package:flutterprojectsetup/ui/mobile_detail/view/mobile_detail_view.dart';
import 'package:get/get.dart';

class RouteName {
  static const init = home;

  // Base routes
  static const String root = '/';
  static const String profilePage = '/profile';
  static const String home = '/home';
  static const String mobileDetail = '/mobile_detail';
}

class Routes {
  static final routes = [
    GetPage(
        page: () => const DashboardView(),
        name: RouteName.root,
        binding: DashboardBinding(),
        children: [
          GetPage(page: () => const ProfileView(), name: RouteName.profilePage)
        ]),
    GetPage(
        name: RouteName.home,
        page: () => const HomeView(),
        binding: HomeBinding()),
    GetPage(
        name: RouteName.mobileDetail,
        page: () => const MobileDetailView(),
        binding: MobileDetailBinding())
  ];
  static final commonRoutes = <String, WidgetBuilder>{};
}
