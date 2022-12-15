import 'dart:async';
import 'package:collection/collection.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mobx_todo/domain/models/todo/todo.dart';

class TodosDataSource {
  final Box<Todo> _todosBox;
  List<Todo> _todos;

  final StreamController<List<Todo>> _streamController = StreamController<List<Todo>>.broadcast();

  TodosDataSource(this._todosBox) : _todos = [];

  List<Todo> get todosData => List.from(_todos);
  Stream<List<Todo>> get todosDataStream => _streamController.stream;

  Future<List<Todo>> loadTodos() async {
    try {
      final allTodosKeys = _todosBox.keys;
      final todosData = allTodosKeys.map(_todosBox.get).whereNotNull().toList();
      _setTodosValue(todosData);
    } catch (err) {
      print('Could not read todos data from Hive TodosBox: $err');
      rethrow;
    }

    return todosData;
  }

  Future<void> updateTodos(List<Todo> todos) async {
    try {
      await _todosBox.deleteAll(_todosBox.keys);
      await _todosBox.putAll(todos.asMap().map((key, value) => MapEntry(value.id, value)));
    } catch (err) {
      print('Could not write todos data to Hive TodosBox: $err');
      rethrow;
    }
  }

  void _setTodosValue(List<Todo>? todos) {
    if (todos != null) {
      _todos = todos;
      _streamController.add(todos);
    }
  }

  static const boxName = 'todos_box';
}
