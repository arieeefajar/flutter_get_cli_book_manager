import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final user = FirebaseAuth.instance.currentUser;
  String get email => user?.email ?? 'Tidak ada email';
  String get photoURL => user?.photoURL ?? 'Tidak ada email';

  void logout() async {
    await FirebaseAuth.instance.signOut();
    Get.offAllNamed('/login');
  }
}
