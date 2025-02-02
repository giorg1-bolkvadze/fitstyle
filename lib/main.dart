// main.dart

import 'package:fitstyle/core/app_colors.dart';
import 'package:fitstyle/core/app_routes/app_routes.dart';
import 'package:fitstyle/core/app_translations.dart/app_translations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'services/auth_controller_getx.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
    runApp(const MyApp());
  } catch (e) {
    debugPrint('Error: $e');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'FitStyle',
      theme: AppTheme.lightTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.fade,
      initialRoute: '/home',
      getPages: AppRoutes.routes,
      initialBinding: BindingsBuilder(() {
        Get.put(AuthController(), permanent: true);
      }),
      translations: AppTranslations(),
    );
  }
}
