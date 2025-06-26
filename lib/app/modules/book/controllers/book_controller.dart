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

  void addBook(Book book) async {
    final response = await provider.addBook(book);
    if (response.statusCode == 201 || response.statusCode == 200) {
      fetchBooks();
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
