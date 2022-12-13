import 'package:flutter/material.dart';
import 'package:mobx_todo/presentation/ui/screens/todo/store/todo_list_store.dart';
import 'package:provider/provider.dart';

class AddTodoTextField extends StatelessWidget {
  final _textController = TextEditingController(text: '');

  AddTodoTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final list = Provider.of<TodoListStore>(context);

    return TextField(
      autofocus: true,
      decoration: const InputDecoration(labelText: 'Add a Todo', contentPadding: EdgeInsets.all(8)),
      controller: _textController,
      textInputAction: TextInputAction.done,
      onSubmitted: (String value) {
        list.addTodo(value);
        _textController.clear();
      },
    );
  }
}
