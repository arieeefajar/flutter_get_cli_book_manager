import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  final emailC = TextEditingController();
  final passwordC = TextEditingController();

  void register() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailC.text.trim(),
        password: passwordC.text.trim(),
      );
      Get.snackbar(
        'Success',
        'User registered successfully',
        snackPosition: SnackPosition.BOTTOM,
      );
      emailC.clear();
      passwordC.clear();
      Get.offAllNamed('/login'); // Navigate to login page after registration
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        'Gagal Daftar',
        e.message ?? 'An error occurred',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'An unexpected error occurred: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  void onClose() {
    emailC.dispose();
    passwordC.dispose();
    super.onClose();
  }
}
