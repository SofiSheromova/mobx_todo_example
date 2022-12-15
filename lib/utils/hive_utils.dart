import 'package:hive_flutter/hive_flutter.dart';
import 'package:mobx_todo/data/data_source/todos_data_source.dart';
import 'package:mobx_todo/domain/models/todo/todo.dart';

class HiveUtils {
  static Future<void> initHive() async {
    await Hive.initFlutter();
    Hive.registerAdapter(TodoAdapter());
    await Hive.openBox<Todo>(TodosDataSource.boxName);
  }
}
