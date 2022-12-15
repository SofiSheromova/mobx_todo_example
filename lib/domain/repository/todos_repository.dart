import 'package:mobx_todo/domain/models/todo/todo.dart';

abstract class TodosRepository {
  Future<List<Todo>> getTodosData();

  Future<void> updateTodosData(List<Todo> todos);

  Stream<List<Todo>> get todosDataStream;
}
