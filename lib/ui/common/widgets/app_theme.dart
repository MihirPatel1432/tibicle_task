import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterprojectsetup/enum/font_type.dart';

///
/// This class contains all UI related styles
///
class AppTheme extends StatefulWidget {
  final Widget? child;

  const AppTheme({Key? key, required this.child}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return AppThemeState();
  }

  static AppThemeState of(BuildContext context) {
    final _InheritedStateContainer? inheritedStateContainer =
        context.dependOnInheritedWidgetOfExactType();
    if (inheritedStateContainer == null) {
      return AppThemeState();
    } else {
      return inheritedStateContainer.data!;
    }
  }
}

class AppThemeState extends State<AppTheme> {
  double getResponsiveFont(double value) => ScreenUtil().setSp(value);

  double getResponsiveWidth(double value) => ScreenUtil().setWidth(value);

  double getResponsiveHeight(double value) => ScreenUtil().setHeight(value);

  ///
  /// Define All your colors here which are used in whole application
  ///
  Color get whiteColor => const Color(0xFFFFFFFF);

  Color get primaryColor => const Color(0xFF0256A6);

  Color get redColor => const Color(0xFFD9534F);

  Color get dividerColor => const Color(0xFFC2C2C2);

  Color get blackColor => const Color(0xFF000000);

  Color get shimmerBackgroundColor => const Color(0xff484848).withOpacity(0.3);

  Color get shimmerBaseColor => Colors.grey[300] ?? Colors.grey;

  Color get shimmerHighlightColor => Colors.grey[100] ?? Colors.grey;

  ///
  /// Mention height and width which are mentioned in your design file(i.e XD)
  /// to maintain ratio for all other devices
  ///
  double get expectedDeviceWidth => 1440;

  double get expectedDeviceHeight => 3120;

  Size get designSize => Size(expectedDeviceWidth, expectedDeviceHeight);

  TextStyle customTextStyle(
      {double fontSize = 12,
      Color? color,
      FontWeightType? fontWeightType,
      FontFamilyType? fontFamilyType,
      TextDecoration? decoration}) {
    return TextStyle(
        decoration: decoration,
        fontWeight: FontType.getFontWeightType(fontWeightType),
        fontFamily: FontType.getFontFamilyType(fontFamilyType),
        fontSize: getResponsiveFont(fontSize),
        color: color);
  }

  @override
  Widget build(BuildContext context) {
    return _InheritedStateContainer(
      data: this,
      child: widget.child,
    );
  }
}

class _InheritedStateContainer extends InheritedWidget {
  final AppThemeState? data;

  _InheritedStateContainer({
    Key? key,
    @required this.data,
    @required Widget? child,
  })  : assert(child != null),
        super(key: key, child: child!);

  @override
  bool updateShouldNotify(_InheritedStateContainer old) => true;
}
