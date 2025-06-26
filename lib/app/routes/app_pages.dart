import 'package:get/get.dart';

import '../modules/book/add_book/bindings/add_book_binding.dart';
import '../modules/book/add_book/views/add_book_view.dart';
import '../modules/book/bindings/book_binding.dart';
import '../modules/book/edit_book/bindings/edit_book_binding.dart';
import '../modules/book/edit_book/views/edit_book_view.dart';
import '../modules/book/views/book_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.BOOK,
      page: () => const BookView(),
      binding: BookBinding(),
      children: [
        GetPage(
          name: _Paths.ADD_BOOK,
          page: () => const AddBookView(),
          binding: AddBookBinding(),
        ),
        GetPage(
          name: _Paths.EDIT_BOOK,
          page: () => const EditBookView(),
          binding: EditBookBinding(),
        ),
      ],
    ),
  ];
}
