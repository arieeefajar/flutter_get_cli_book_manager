import 'package:get/get.dart';
import 'package:book_manager/app/data/models/book_model.dart';

class BookProvider extends GetConnect {
  BookProvider() {
    httpClient.baseUrl = 'https://685bf98789952852c2dbb8b8.mockapi.io/api';
  }

  Future<Response<List<Book>>> getBooks() async => await get(
    '/books',
    decoder: (data) {
      return (data as List).map((e) => Book.fromJson(e)).toList();
    },
  );

  Future<Response<Book>> addBook(Book book) async => await post(
    '/books',
    book.toJson(),
    decoder: (data) => Book.fromJson(data),
  );

  Future<Response<Book>> updateBook(int id, Book book) async => await put(
    '/books/${book.id}',
    book.toJson(),
    decoder: (data) => Book.fromJson(data),
  );

  Future<Response> deleteBook(int id) async =>
      await delete('$baseUrl/books/$id');
}
