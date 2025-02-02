import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitstyle/services/auth_service.dart';

class AuthController extends GetxController {
  final AuthService _authService = AuthService();
  final forgotPasswordEmail = ''.obs;

  final email = ''.obs;
  final password = ''.obs;
  final age = 0.obs;
  final height = 0.0.obs;
  final weight = 0.0.obs;
  final isPasswordVisible = false.obs;
  final isLoading = false.obs;

  void togglePasswordVisibility() =>
      isPasswordVisible.value = !isPasswordVisible.value;

  bool validateEmail() {
    if (!GetUtils.isEmail(email.value)) {
      Get.snackbar('Hata', 'Geçerli bir email adresi giriniz.');
      return false;
    }
    return true;
  }

  bool validatePassword() {
    if (password.value.length < 6) {
      Get.snackbar('Hata', 'Şifre en az 6 karakter olmalıdır.');
      return false;
    }
    return true;
  }

  bool validateSignupFields() {
    if (age.value <= 0) {
      Get.snackbar('Hata', 'Geçerli bir yaş giriniz.');
      return false;
    }
    if (height.value <= 0) {
      Get.snackbar('Hata', 'Geçerli bir boy giriniz.');
      return false;
    }
    if (weight.value <= 0) {
      Get.snackbar('Hata', 'Geçerli bir kilo giriniz.');
      return false;
    }
    return true;
  }

  Future<void> login() async {
    if (!validateEmail() || !validatePassword()) return;

    try {
      isLoading.value = true;
      User? user = await _authService.signIn(email.value, password.value);
      if (user != null) {
        Get.snackbar('Başarılı', 'Giriş başarılı!');
        Get.offAllNamed('/home');
      }
    } catch (e) {
      Get.snackbar('Hata', 'Giriş başarısız: ${e.toString()}',
          backgroundColor: Colors.red[100]);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> resetPassword() async {
    if (!GetUtils.isEmail(forgotPasswordEmail.value)) {
      Get.snackbar(
        'error'.tr,
        'valid_email'.tr,
        backgroundColor: Colors.red[100],
      );
      return;
    }
    try {
      isLoading.value = true;
      await _authService.resetPassword(forgotPasswordEmail.value);
      Get.snackbar(
        'success'.tr,
        'reset_password_success'.tr,
        backgroundColor: Colors.green[100],
      );
      Get.back(); // Önceki sayfaya dön
    } catch (e) {
      Get.snackbar(
        'error'.tr,
        'reset_password_error'.tr,
        backgroundColor: Colors.red[100],
      );
    } finally {
      isLoading.value = false;
      forgotPasswordEmail.value = '';
    }
  }

  Future<bool> isEmailInUse(String email) async {
    try {
      final list =
          await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
      return list.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  Future<void> register() async {
    if (!validateEmail() || !validatePassword() || !validateSignupFields())
      return   ;

    try {
      isLoading.value = true;

      // Önce email kontrolü yapalım
      bool emailInUse = await isEmailInUse(email.value);
      if (emailInUse) {
        Get.snackbar(
          'Hata',
          'Bu e-posta adresi zaten kullanımda',
          backgroundColor: Colors.red,
        );
        return;
      }

      // Email kullanımda değilse kayıt işlemine devam edelim
      User? user = await _authService.signUp(Get.context!, email.value,
          password.value, age.value, height.value, weight.value);

      if (user != null && user.uid.isNotEmpty) {
        Get.snackbar(
          'Başarılı',
          'Kayıt başarılı!',
          backgroundColor: Colors.green[100],
        );
        Get.back();
      }
    } catch (e) {
      Get.snackbar(
        'Hata',
        'Kayıt başarısız: ${e.toString()}',
        backgroundColor: Colors.red[100],
      );
    } finally {
      isLoading.value = false;
    }
  }
}
