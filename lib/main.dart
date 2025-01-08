
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:soulstyle/app/core/theme/app_theme.dart';
import 'package:soulstyle/app/routes/routes.dart';

void main() async {
  Paint().isAntiAlias = true;


  await GetStorage.init();

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Ecommerce_Application",
      initialRoute: Routes.splashscreen,
      getPages: Routes.pages,
      darkTheme: AppTheme.lightTheme,
      theme: AppTheme.lightTheme,
      defaultTransition: Transition.noTransition,
      navigatorObservers: [],)
          );
          
  }
