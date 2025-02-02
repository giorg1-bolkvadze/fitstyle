import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitstyle/presentation/education_center/education_center_screen1.dart';
import 'package:fitstyle/presentation/education_center/test.dart';
import 'package:fitstyle/presentation/forgot_password_page.dart';
import 'package:fitstyle/presentation/home_page.dart';
import 'package:fitstyle/presentation/login_page.dart';
import 'package:fitstyle/presentation/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/route_middleware.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

class AppRoutes {
  static final routes = [
    GetPage(
      name: '/login',
      page: () => const LoginPage(),
      transition: Transition.fade,
    ),
    GetPage(
      name: '/signup',
      page: () => const SignupPage(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: '/home',
      page: () => const HomePage(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: '/forgot-password',
      page: () => const ForgotPasswordPage(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: '/signup',
      page: () => const SignupPage(),
      transition: Transition.rightToLeft,
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/forgot-password',
      page: () => const ForgotPasswordPage(),
      transition: Transition.rightToLeft,
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/education-center',
      page: () => const EducationCenterScreen(),
      transition: Transition.fade,
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/test',
      page: () => const TestScreen(),
      transition: Transition.fade,
      middlewares: [AuthMiddleware()],
    )
  ];
}

// middlewares/auth_middleware.dart
class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    return FirebaseAuth.instance.currentUser == null
        ? const RouteSettings(name: '/login')
        : null;
  }
}
