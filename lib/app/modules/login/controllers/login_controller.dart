import 'package:book_manager/app/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final emailC = TextEditingController();
  final passwordC = TextEditingController();

  void login() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailC.text.trim(),
        password: passwordC.text.trim(),
      );
      Get.snackbar('Success', 'Login successful');
      Get.offAllNamed(Routes.HOME);
    } on FirebaseAuthException catch (e) {
      print(e.message);
      Get.snackbar('Login Gagal', e.message ?? 'Terjadi kesalahan');
    } catch (e) {
      Get.snackbar('Error', 'Terjadi kesalahan: $e');
    }
  }

  @override
  void onClose() {
    emailC.dispose();
    passwordC.dispose();
    super.onClose();
  }
}
