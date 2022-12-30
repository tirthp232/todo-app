import 'package:get/state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todos_app_getx/model/todos.dart';

class TodoController extends GetxController {
  var todoList = <Todo>[].obs;

  @override
  void onInit() {
    print('hello');
    List? todos = GetStorage().read<List>('todo');

    if (todos != null) {
      todoList = todos.map((e) => Todo.fromJson(e)).toList().obs;
    }

    ever(
      todoList,
      (_) {
        GetStorage().write('todo', todoList.toList());
      },
    );

    super.onInit();
  }
}
