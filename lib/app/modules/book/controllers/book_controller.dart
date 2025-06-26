import 'package:book_manager/app/data/models/book_model.dart';
import 'package:book_manager/app/data/providers/book_provider.dart';
import 'package:get/get.dart';

class BookController extends GetxController {
  var books = <Book>[].obs;
  var isLoading = true.obs;
  final provider = BookProvider();

  @override
  void onInit() {
    fetchBooks();
    super.onInit();
  }

  void fetchBooks() async {
    try {
      isLoading.value = true;
      final response = await provider.getBooks();
      if (response.statusCode == 200) {
        books.value = response.body!;
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal mengambil data buku: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void addBook(String name, String author, String avatar) async {
    if (name.isNotEmpty && author.isNotEmpty) {
      final book = Book(
        name: name,
        author: author,
        avatar: avatar,
        createdAt: DateTime.now().toIso8601String(),
      );

      try {
        final respone = await provider.addBook(book);
        if (respone.statusCode == 201 || respone.statusCode == 200) {
          books.add(book);
          Get.back();
          await Future.delayed(Duration(milliseconds: 300));
          Get.snackbar(
            'Success',
            'Buku "${book.name}" berhasil ditambahkan',
            snackPosition: SnackPosition.BOTTOM,
          );
        } else {
          Get.snackbar(
            'Error',
            'Gagal menambahkan buku: ${respone.statusText}',
            snackPosition: SnackPosition.BOTTOM,
          );
        }
        print('Book added successfully: ${book.name}');
        // Get.back();
      } catch (e) {
        Get.snackbar(
          'Error',
          'Gagal menambahkan buku: ${e.toString()}',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } else {
      Get.snackbar(
        'Error',
        'Please fill in all fields',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void updateBook(Book book) async {
    final response = await provider.updateBook(book.id!, book);
    if (response.statusCode == 200) {
      fetchBooks();
    }
  }

  void deleteBook(int id) async {
    final response = await provider.deleteBook(id);
    if (response.statusCode == 200) {
      fetchBooks();
    }
  }
}
