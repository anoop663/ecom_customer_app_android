import 'package:ecommerce_app/app/core/theme/app_theme.dart';
import 'package:ecommerce_app/app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

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
