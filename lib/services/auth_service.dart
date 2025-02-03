import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Şifre sıfırlama
  Future<void> resetPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  // Kullanıcı Kayıt Ol
  Future<User?> signUp(BuildContext context, String email, String password,
      int age, double height, double weight) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;

      if (user != null) {
        await _firestore.collection('users').doc(user.uid).set({
          'email': email,
          'age': age,
          'height': height,
          'weight': weight,
        });
      }

      return user;
    } catch (e) {
      debugPrint(e.toString());

      try {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Kayıt başarısız. Hata: ${e.toString()}')),
        );
      } catch (error) {
        debugPrint("BuildContext geçersiz: $error");
      }

      return null;
    }
  }

  // Kullanıcı Giriş Yap
  Future<User?> signIn(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user;
    } catch (e) {
      debugPrint("Giriş hatası: $e");
      return null;
    }
  }
}
