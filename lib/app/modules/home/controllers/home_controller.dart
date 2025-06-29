import 'package:book_manager/app/modules/book/controllers/book_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../book/views/book_view.dart';

class HomeController extends GetxController {
  final RxInt currentIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    Get.lazyPut(() => BookController());
  }

  final List<Widget> pages = [
    const Center(
      child: Text(
        'Selamat Datang di Aplikasi Book Manager',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    ),
    BookView(),
    const Center(child: Text('Profile')),
  ];

  void changePage(int index) {
    currentIndex.value = index;
  }
}
