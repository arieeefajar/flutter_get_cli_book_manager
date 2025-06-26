import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class EditBookController extends GetxController {
  late int id;
  late TextEditingController nameC;
  late TextEditingController authorC;
  late TextEditingController avatarC;

  @override
  void onInit() {
    final args = Get.arguments;
    id = args['id'];
    nameC = TextEditingController(text: args['name']);
    authorC = TextEditingController(text: args['author']);
    avatarC = TextEditingController(text: args['avatar']);
    super.onInit();
  }

  @override
  void onClose() {
    nameC.dispose();
    authorC.dispose();
    avatarC.dispose();
    super.onClose();
  }
}
