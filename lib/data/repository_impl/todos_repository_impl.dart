import 'package:mobx_todo/data/data_source/todos_data_source.dart';
import 'package:mobx_todo/domain/models/todo/todo.dart';
import 'package:mobx_todo/domain/repository/todos_repository.dart';

class TodosRepositoryImpl implements TodosRepository {
  final TodosDataSource _dataSource;

  TodosRepositoryImpl(this._dataSource);

  @override
  Future<List<Todo>> getTodosData() => _dataSource.loadTodos();

  @override
  Future<void> updateTodosData(List<Todo> todos) => _dataSource.updateTodos(todos);

  @override
  Stream<List<Todo>> get todosDataStream => _dataSource.todosDataStream;
}
