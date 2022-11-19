import 'package:flutter/material.dart';
import 'package:flutterprojectsetup/enum/font_type.dart';
import 'package:flutterprojectsetup/models/post.dart';
import 'package:flutterprojectsetup/ui/common/strings.dart';
import 'package:flutterprojectsetup/ui/common/widgets/app_theme.dart';
import 'package:get/get.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _appTheme = AppTheme.of(context);
    final post = Get.arguments as Post;
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(StringConstants.profile,
                style: _appTheme.customTextStyle(
                    fontSize: 50,
                    color: _appTheme.whiteColor,
                    fontFamilyType: FontFamilyType.prozaLibre,
                    fontWeightType: FontWeightType.bold))),
        backgroundColor: _appTheme.primaryColor,
        automaticallyImplyLeading: false,
      ),
      body: Center(child: Text(post.title)),
    );
  }
}
