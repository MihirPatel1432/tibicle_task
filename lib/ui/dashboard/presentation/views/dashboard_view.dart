import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutterprojectsetup/enum/font_type.dart';
import 'package:flutterprojectsetup/models/post.dart';
import 'package:flutterprojectsetup/ui/common/asset_images.dart';
import 'package:flutterprojectsetup/ui/common/routes.dart';
import 'package:flutterprojectsetup/ui/common/strings.dart';
import 'package:flutterprojectsetup/ui/common/widgets/app_theme.dart';
import 'package:flutterprojectsetup/ui/common/widgets/shimmer_widget.dart';
import 'package:flutterprojectsetup/ui/dashboard/presentation/controllers/home_controller.dart';
import 'package:get/get.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _appTheme = AppTheme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(StringConstants.posts,
                style: _appTheme.customTextStyle(
                    fontSize: 50,
                    color: _appTheme.whiteColor,
                    fontFamilyType: FontFamilyType.prozaLibre,
                    fontWeightType: FontWeightType.bold))),
        backgroundColor: _appTheme.primaryColor,
      ),
      body: SafeArea(
          bottom: false,
          child: controller.obx(
              (state) => ListView.separated(
                  itemBuilder: (context, index) {
                    return state is List
                        ? _getPostWidget(state?[index], _appTheme)
                        : const Offstage();
                  },
                  separatorBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: _appTheme.getResponsiveWidth(70)),
                      child: Divider(
                        thickness: _appTheme.getResponsiveHeight(2),
                        color: _appTheme.dividerColor,
                      ),
                    );
                  },
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(
                      vertical: _appTheme.getResponsiveHeight(20)),
                  itemCount:
                      state != null && state.isNotEmpty ? state.length : 0),
              onLoading: ListView.separated(
                  itemBuilder: (context, index) {
                    return _getPostShimmer(_appTheme);
                  },
                  separatorBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: _appTheme.getResponsiveWidth(70)),
                      child: Divider(
                        thickness: _appTheme.getResponsiveHeight(2),
                        color: _appTheme.dividerColor,
                      ),
                    );
                  },
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(
                      vertical: _appTheme.getResponsiveHeight(20)),
                  itemCount: 20))),
    );
  }

  Widget _getPostShimmer(AppThemeState _appTheme) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: _appTheme.getResponsiveWidth(70),
          vertical: _appTheme.getResponsiveHeight(20)),
      child: Column(
        children: <Widget>[
          ShimmerWidget(
              width: double.infinity,
              height: _appTheme.getResponsiveHeight(50),
              borderRadius: 5),
          SizedBox(height: _appTheme.getResponsiveHeight(10)),
          ShimmerWidget(
              width: double.infinity,
              height: _appTheme.getResponsiveHeight(50),
              borderRadius: 5),
        ],
      ),
    );
  }

  Widget _getPostWidget(Post? post, AppThemeState _appTheme) {
    return InkWell(
      onTap: () {
        Get.toNamed(RouteName.profilePage, arguments: post);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: _appTheme.getResponsiveWidth(70),
            vertical: _appTheme.getResponsiveHeight(20)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Flexible(
                      child: Text(post?.title ?? '',
                          style: _appTheme.customTextStyle(
                              fontSize: 38,
                              color: _appTheme.blackColor,
                              fontFamilyType: FontFamilyType.prozaLibre,
                              fontWeightType: FontWeightType.bold))),
                  SizedBox(height: _appTheme.getResponsiveHeight(10)),
                  Flexible(
                      child: Text(post?.body ?? '',
                          style: _appTheme.customTextStyle(
                              fontSize: 32,
                              color: _appTheme.blackColor.withOpacity(0.5),
                              fontFamilyType: FontFamilyType.prozaLibre,
                              fontWeightType: FontWeightType.medium))),
                ],
              ),
            ),
            SizedBox(width: _appTheme.getResponsiveWidth(20)),
            SvgPicture.asset(
              SVGPath.menu,
              color: _appTheme.blackColor,
              width: _appTheme.getResponsiveHeight(30),
              height: _appTheme.getResponsiveHeight(30),
            )
          ],
        ),
      ),
    );
  }
}
