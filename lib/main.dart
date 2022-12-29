import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:reusable_text_input/app/theme/app_theme.dart';

import 'app/routes/app_pages.dart';

void main() {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: appTheme,
    );
  }
}
