import 'package:book_manager/app/modules/book/controllers/book_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/edit_book_controller.dart';

class EditBookView extends GetView<EditBookController> {
  const EditBookView({super.key});
  @override
  Widget build(BuildContext context) {
    final bookC = Get.find<BookController>();
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Book'), centerTitle: true),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextField(
            controller: controller.nameC,
            decoration: InputDecoration(
              labelText: 'Name',
              hintText: 'Enter book name',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 20),
          TextField(
            controller: controller.authorC,
            decoration: InputDecoration(
              labelText: 'Author',
              hintText: 'Enter author name',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 20),
          TextField(
            controller: controller.avatarC,
            decoration: InputDecoration(
              labelText: 'Avatar URL',
              hintText: 'Enter author name',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => bookC.updateBook(
              controller.id,
              controller.nameC.text,
              controller.authorC.text,
              controller.avatarC.text,
            ),
            child: const Text('Update Book'),
          ),
        ],
      ),
    );
  }
}
