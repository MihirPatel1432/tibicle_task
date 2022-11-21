import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterprojectsetup/di/app_component_base.dart';
import 'package:flutterprojectsetup/enum/font_type.dart';
import 'package:flutterprojectsetup/ui/common/logger.dart';
import 'package:flutterprojectsetup/ui/common/routes.dart';
import 'package:flutterprojectsetup/ui/common/strings.dart';
import 'package:flutterprojectsetup/ui/common/translation_service.dart';
import 'package:flutterprojectsetup/ui/common/utils.dart';
import 'package:flutterprojectsetup/ui/common/widgets/app_theme.dart';
import 'package:flutterprojectsetup/ui/common/widgets/custom_progress_dialog.dart';
import 'package:get/get.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  @override
  void initState() {
    AppComponentBase.getInstance()?.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppTheme(
        child: GetMaterialApp(
      debugShowCheckedModeBanner: false,
      enableLog: true,
      logWriterCallback: Logger.write,
      initialRoute: RouteName.init,
      getPages: Routes.routes,
      locale: TranslationService.locale,
      fallbackLocale: TranslationService.fallbackLocale,
      translations: TranslationService(),
      builder: (context, widget) {
        final _appTheme = AppTheme.of(context);
        return ScreenUtilInit(
          designSize: _appTheme.designSize,
          builder: (_, __) => Stack(
            children: <Widget>[
              StreamBuilder<bool?>(
                  initialData: false,
                  stream: AppComponentBase.getInstance()?.progressDialogStream,
                  builder: (context, snapshot) {
                    return IgnorePointer(
                        ignoring: snapshot.data as bool, child: widget);
                  }),
              StreamBuilder<bool?>(
                  initialData: true,
                  stream: AppComponentBase.getInstance()
                      ?.getNetworkManager()
                      .internetConnectionStream,
                  builder: (context, snapshot) {
                    return SafeArea(
                      child: AnimatedContainer(
                          height: snapshot.data as bool
                              ? 0
                              : _appTheme.getResponsiveHeight(100),
                          duration: Utils.animationDuration,
                          color: _appTheme.redColor,
                          child: Material(
                            type: MaterialType.transparency,
                            child: Center(
                                child: Text(
                                    StringConstants.noInternetConnection,
                                    style: _appTheme.customTextStyle(
                                        fontSize: 40,
                                        color: _appTheme.whiteColor,
                                        fontFamilyType:
                                            FontFamilyType.prozaLibre,
                                        fontWeightType:
                                            FontWeightType.medium))),
                          )),
                    );
                  }),
              StreamBuilder<bool?>(
                  initialData: false,
                  stream: AppComponentBase.getInstance()?.progressDialogStream,
                  builder: (context, snapshot) {
                    return snapshot.data as bool
                        ? const Center(child: CustomProgressDialog())
                        : const Offstage();
                  })
            ],
          ),
        );
      },
    ));
  }

  @override
  void dispose() {
    AppComponentBase.getInstance()?.dispose();
    super.dispose();
  }
}
