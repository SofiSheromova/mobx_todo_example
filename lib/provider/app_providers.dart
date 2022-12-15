import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mobx_todo/data/data_source/todos_data_source.dart';
import 'package:mobx_todo/data/repository_impl/todos_repository_impl.dart';
import 'package:mobx_todo/domain/models/todo/todo.dart';
import 'package:mobx_todo/domain/repository/todos_repository.dart';
import 'package:provider/provider.dart';

class AppProviders extends StatelessWidget {
  final Widget child;

  const AppProviders({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<TodosDataSource>(
          create: (context) => TodosDataSource(
            Hive.box<Todo>(TodosDataSource.boxName),
          ),
        ),
        Provider<TodosRepository>(
          create: (context) => TodosRepositoryImpl(
            context.read<TodosDataSource>(),
          ),
        ),
      ],
      child: child,
    );
  }
}
