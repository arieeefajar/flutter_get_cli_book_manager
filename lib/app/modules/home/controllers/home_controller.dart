import 'package:book_manager/app/modules/book/controllers/book_controller.dart';
import 'package:book_manager/app/modules/map/controllers/map_controller.dart';
import 'package:book_manager/app/modules/map/views/map_view.dart';
import 'package:book_manager/app/modules/profile/controllers/profile_controller.dart';
import 'package:book_manager/app/modules/profile/views/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../book/views/book_view.dart';

class HomeController extends GetxController {
  final RxInt currentIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    Get.lazyPut(() => BookController());
    Get.lazyPut(() => MapController());
    Get.lazyPut(() => ProfileController());
  }

  final List<Widget> pages = [
    const Center(
      child: Text(
        'Selamat Datang di Aplikasi Book Manager',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    ),
    BookView(),
    MapView(),
    ProfileView(),
  ];

  void changePage(int index) {
    currentIndex.value = index;
  }
}
