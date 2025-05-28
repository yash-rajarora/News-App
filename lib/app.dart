import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:newsapp/views/home_screen.dart';
import 'utils/theme/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'News App',
      themeMode: ThemeMode.system,
      theme: TAppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      home: const HomeScreen()
    );
  }
}
