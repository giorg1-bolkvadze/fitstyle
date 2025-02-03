import 'package:get/get_navigation/src/root/internacionalization.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'tr': {
          'login': 'Giriş Yap',
          'signup': 'Kayıt Ol',
          'email': 'E-posta',
          'password': 'Şifre',
          'age': 'Yaş',
          'height': 'Boy (cm)',
          'weight': 'Kilo (kg)',
          'forgot_password': 'Şifremi Unuttum',
          'error': 'Hata',
          'success': 'Başarılı',
          'validation_error': 'Lütfen tüm alanları doldurun',
          'login_success': 'Giriş başarılı!',
          'login_error': 'Giriş başarısız. Lütfen tekrar deneyin.',
          'signup_success': 'Kayıt başarılı!',
          'signup_error': 'Kayıt başarısız. Lütfen tekrar deneyin.',

        },
        'en': {
          'login': 'Login',
          'signup': 'Sign Up',
          'email': 'Email',
          'password': 'Password',
          'age': 'Age',
          'height': 'Height (cm)',
          'weight': 'Weight (kg)',
          'forgot_password': 'Forgot Password',
          'error': 'Error',
          'success': 'Success',
          'validation_error': 'Please fill all fields',
          'login_success': 'Login successful!',
          'login_error': 'Login failed. Please try again.',
          'signup_success': 'Registration successful!',
          'signup_error': 'Registration failed. Please try again.',
          
        },
      };
}
