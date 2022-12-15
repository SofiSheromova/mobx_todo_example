import 'package:flutter/material.dart';
import 'package:mobx_todo/domain/repository/todos_repository.dart';
import 'package:mobx_todo/presentation/ui/screens/todo/store/todo_list_store.dart';
import 'package:provider/provider.dart';

class TodoExampleDependencies extends StatelessWidget {
  final Widget child;

  const TodoExampleDependencies({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Provider<TodoListStore>(
      create: (_) => TodoListStore(context.read<TodosRepository>()),
      child: child,
    );
  }
}
