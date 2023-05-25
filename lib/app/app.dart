import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nado_client_mvp/app/binding.dart';
import 'package:nado_client_mvp/app/routes/pages.dart';
import 'package:nado_client_mvp/app/routes/routes.dart';
import 'package:nado_client_mvp/app/core/values/theme.dart';
import 'package:nado_client_mvp/app/global_widgets/not_found.dart';

class MyApp extends StatelessWidget {
  static FirebaseAnalytics firebaseAnalytics = FirebaseAnalytics.instance;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorObservers: [
        FirebaseAnalyticsObserver(analytics: firebaseAnalytics),
      ],
      title: '나도 손님',
      initialRoute: Routes.CLIENT_PAGE,
      initialBinding: AppBinding(),
      getPages: AppPages.pages,
      onUnknownRoute: (settings) =>
          MaterialPageRoute(builder: (_) => NotFoundPage()),
      theme: appThemeData,
    );
  }
}
