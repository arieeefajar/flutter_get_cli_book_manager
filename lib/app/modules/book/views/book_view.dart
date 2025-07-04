import 'package:book_manager/app/routes/app_pages.dart';
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
              subtitle: Text(book.author ?? 'No Author'),
              trailing: IconButton(
                onPressed: () {
                  Get.defaultDialog(
                    title: 'Delete Book',
                    middleText:
                        'Are you sure you want to delete "${book.name}"?',
                    textCancel: 'Cancel',
                    textConfirm: 'Delete',
                    confirmTextColor: Colors.white,
                    onConfirm: () {
                      Get.back();
                      controller.deleteBook(book.id!);
                    },
                  );
                },
                icon: Icon(Icons.delete, color: Color(0xFFD32F2F)),
              ),
              onTap: () {
                Get.toNamed(
                  Routes.EDIT_BOOK,
                  arguments: {
                    'id': book.id,
                    'name': book.name,
                    'avatar': book.avatar,
                    'author': book.author,
                    'createdAt': book.createdAt,
                  },
                );
              },
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(Routes.ADD_BOOK),
        child: Icon(Icons.add),
      ),
    );
  }
}
