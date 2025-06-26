import 'package:book_manager/app/modules/book/controllers/book_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/add_book_controller.dart';

class AddBookView extends GetView<AddBookController> {
  const AddBookView({super.key});
  @override
  Widget build(BuildContext context) {
    final bookC = Get.find<BookController>();
    return Scaffold(
      appBar: AppBar(title: const Text('Add Book Data'), centerTitle: true),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextField(
            controller: controller.bookNameC,
            decoration: InputDecoration(
              labelText: 'Book Name',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 20),
          TextField(
            controller: controller.authorC,
            decoration: InputDecoration(
              labelText: 'Author',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 20),
          TextField(
            controller: controller.avatarC,
            decoration: InputDecoration(
              labelText: 'Avatar URL',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              bookC.addBook(
                controller.bookNameC.text,
                controller.authorC.text,
                controller.avatarC.text,
              );
            },
            child: const Text("Add Book"),
          ),
        ],
      ),
    );
  }
}
