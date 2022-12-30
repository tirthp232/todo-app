import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todos_app_getx/controller/todo_controller.dart';
import 'package:todos_app_getx/model/todos.dart';

class TodoScreen extends StatelessWidget {
  int? index;
  TodoScreen({super.key, this.index});

  @override
  Widget build(BuildContext context) {
    String text = '';
    final TodoController controller = Get.find();

    text = index == null ? '' : controller.todoList[index ?? 0].text!;
    final TextEditingController textEditingController =
        TextEditingController(text: text);
    print(text);

    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: TextField(
                controller: textEditingController,
                autofocus: true,
                maxLines: 999,
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  hintText: 'Please Write your todos.....',
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MaterialButton(
                  onPressed: () => Get.back(),
                  color: Colors.amber,
                  child: const Text('canel'),
                ),
                MaterialButton(
                  onPressed: () {
                    if (index == null) {
                      controller.todoList
                          .add(Todo(text: textEditingController.text));
                    } else {
                      //very most importent.
                      var editing = controller.todoList[index!];
                      editing.text = textEditingController.text;
                      controller.todoList[index ?? 0] = editing;
                    }
                    Get.back();
                  },
                  color: Colors.green,
                  child: Text(index != null ? 'edit' : 'done'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
