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
          fetchBooks();
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

  void updateBook(int id, String name, String author, String avatar) async {
    if (name.isNotEmpty && author.isNotEmpty && avatar.isNotEmpty) {
      final book = Book(
        id: id,
        name: name,
        author: author,
        avatar: avatar,
        createdAt: DateTime.now().toIso8601String(),
      );

      try {
        final response = await provider.updateBook(id, book);
        if (response.statusCode == 200) {
          final index = books.indexWhere((b) => b.id == id);
          if (index != -1) {
            books[index] = book;
          }
          Get.back();
          fetchBooks();
          await Future.delayed(Duration(milliseconds: 300));
          Get.snackbar(
            'Success',
            'Buku "${book.name}" berhasil diperbarui',
            snackPosition: SnackPosition.BOTTOM,
          );
        } else {
          Get.snackbar(
            'Error',
            'Gagal memperbarui buku: ${response.statusText}',
            snackPosition: SnackPosition.BOTTOM,
          );
        }
      } catch (e) {
        Get.snackbar(
          'Error',
          'Gagal memperbarui buku: ${e.toString()}',
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

  void deleteBook(int id) async {
    final response = await provider.deleteBook(id);
    if (response.statusCode == 200) {
      fetchBooks();
    }
  }
}
