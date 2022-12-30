import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/todo_controller.dart';
import 'todo_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TodoController controller = Get.put(TodoController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Todos Using Getx'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(TodoScreen()),
        child: const Icon(Icons.add),
      ),
      body: Obx(
        () => Container(
          margin: const EdgeInsets.all(8),
          child: ListView.separated(
            itemBuilder: (context, index) {
              return Dismissible(
                key: UniqueKey(),
                onDismissed: (direction) {
                  var remove = controller.todoList[index];
                  controller.todoList.removeAt(index);
                  Get.snackbar(
                    'Task Remove',
                    'todos is -> ${remove.text}',
                    mainButton: TextButton(
                      onPressed: () {
                        if (remove.isBlank!) {
                          return;
                        }
                        controller.todoList.insert(index, remove);
                      },
                      child: const Text(
                        'Undo',
                        style: TextStyle(color: Colors.brown),
                      ),
                    ),
                  );
                },
                child: ListTile(
                  onTap: () {
                    print("Next");
                    Get.to(TodoScreen(
                      index: index,
                    ));
                  },
                  title: Text(
                    controller.todoList[index].text!,
                    style: TextStyle(
                      color: controller.todoList[index].done
                          ? Colors.red
                          : Colors.black,
                    ),
                  ),
                  leading: Checkbox(
                    value: controller.todoList[index].done,
                    onChanged: (value) {
                      //very most importent.
                      var changed = controller.todoList[index];
                      changed.done = value!;
                      controller.todoList[index] = changed;
                    },
                  ),
                  trailing: const Icon(Icons.edit),
                ),
              );
            },
            separatorBuilder: (context, index) => const Divider(),
            itemCount: controller.todoList.length,
          ),
        ),
      ),
    );
  }
}
