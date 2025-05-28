import 'package:flutter/material.dart';
import 'package:newsapp/utils/theme/widget_themes/appbar_theme.dart';
import 'package:newsapp/utils/theme/widget_themes/text_theme.dart';

import '../constants/colors.dart';

class TAppTheme {
  TAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    disabledColor: TColors.grey,
    brightness: Brightness.light,
    textTheme: TTextTheme.lightTextTheme,
    scaffoldBackgroundColor: TColors.white,
    appBarTheme: TAppBarTheme.lightAppBarTheme,
  );
}
