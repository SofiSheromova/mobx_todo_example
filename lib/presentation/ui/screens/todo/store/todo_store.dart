import 'package:mobx/mobx.dart';
import 'package:mobx_todo/domain/models/todo/todo.dart';

part 'todo_store.g.dart';

class TodoStore extends _TodoStore with _$TodoStore {
  TodoStore(String description) : super._(description, false, DateTime.now().millisecondsSinceEpoch.toString());

  TodoStore.fromModel(Todo todo) : super._(todo.description, todo.done, todo.id);
}

abstract class _TodoStore with Store {
  @readonly
  String _description;
  @readonly
  bool _done;
  final String id;

  _TodoStore._(
    this._description,
    this._done,
    this.id,
  );

  @computed
  Todo get model => Todo(id: id, description: _description, done: _done);

  @action
  void toggleIsDone() {
    _done = !_done;
  }

  @action
  void markAsCompleted() {
    _done = true;
  }

  @action
  void changeDescription(String newDescription) {
    _description = newDescription;
  }
}
