import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/edit_book_controller.dart';

class EditBookView extends GetView<EditBookController> {
  const EditBookView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Book'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text('ID: ${controller.id}'),
            TextField(
              controller: TextEditingController(text: controller.nameC.text),
              decoration: InputDecoration(
                labelText: 'Name',
                hintText: 'Enter book name',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
