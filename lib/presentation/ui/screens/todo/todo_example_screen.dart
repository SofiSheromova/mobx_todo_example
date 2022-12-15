import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:mobx_todo/presentation/ui/screens/todo/components/add_todo_text_field.dart';
import 'package:mobx_todo/presentation/ui/screens/todo/components/todo_list_view.dart';
import 'package:mobx_todo/presentation/ui/screens/todo/components/todos_action_bar.dart';
import 'package:mobx_todo/presentation/ui/screens/todo/components/todos_status_description.dart';
import 'package:mobx_todo/presentation/ui/screens/todo/store/todo_list_store.dart';
import 'package:provider/provider.dart';

class TodoExampleScreen extends StatefulWidget {
  const TodoExampleScreen({Key? key}) : super(key: key);

  @override
  State<TodoExampleScreen> createState() => _TodoExampleScreenState();
}

class _TodoExampleScreenState extends State<TodoExampleScreen> {
  late final ReactionDisposer reactionDisposer;

  @override
  void initState() {
    final store = context.read<TodoListStore>();

    reactionDisposer = reaction<String?>((_) {
      return store.todosSaving.whenOrNull(
        data: (_) => 'Successful saving!',
        error: () => 'Failed saving. Try again later!',
      );
    }, (msg) {
      if (msg != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(msg)),
        );
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<TodoListStore>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Todos'),
        actions: [
          IconButton(
            onPressed: store.saveTodos,
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          AddTodoTextField(),
          const TodosActionBar(),
          const TodosStatusDescription(),
          const TodoListView(),
        ],
      ),
    );
  }

  @override
  void dispose() {
    reactionDisposer();
    super.dispose();
  }
}
