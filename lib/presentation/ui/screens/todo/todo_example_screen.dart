import 'package:flutter/material.dart';
import 'package:mobx_todo/presentation/ui/screens/todo/components/add_todo_text_field.dart';
import 'package:mobx_todo/presentation/ui/screens/todo/components/todo_list_view.dart';
import 'package:mobx_todo/presentation/ui/screens/todo/components/todos_status_description.dart';
import 'package:mobx_todo/presentation/ui/screens/todo/store/todo_list_store.dart';
import 'package:mobx_todo/presentation/ui/screens/todo/components/todos_action_bar.dart';
import 'package:provider/provider.dart';

class TodoExampleScreen extends StatelessWidget {
  const TodoExampleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider<TodoListStore>(
      create: (_) => TodoListStore(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Todos'),
        ),
        body: Column(
          children: <Widget>[
            AddTodoTextField(),
            const TodosActionBar(),
            const TodosStatusDescription(),
            const TodoListView(),
          ],
        ),
      ),
    );
  }
}
