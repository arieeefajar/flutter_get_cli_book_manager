import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/book_controller.dart';

class BookView extends GetView<BookController> {
  const BookView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Book Manager'), centerTitle: true),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.books.isEmpty) {
          return const Center(child: Text('No books available'));
        }

        return ListView.builder(
          itemCount: controller.books.length,
          itemBuilder: (context, index) {
            final book = controller.books[index];
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(book.avatar ?? ''),
                backgroundColor: Colors.grey[200],
              ),
              title: Text(book.name ?? 'No Title'),
              subtitle: Text(book.createdAt ?? 'No Date'),
              trailing: IconButton(
                onPressed: () => controller.deleteBook(book.id!),
                icon: Icon(Icons.delete, color: Color(0xFFD32F2F)),
              ),
              onTap: () {},
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}
