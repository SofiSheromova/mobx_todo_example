import 'package:flutter/material.dart';
import 'package:mobx_todo/presentation/ui/screens/todo/dependencies/todo_example_dependencies.dart';
import 'package:mobx_todo/presentation/ui/screens/todo/todo_example_screen.dart';
import 'package:mobx_todo/provider/app_providers.dart';
import 'package:mobx_todo/utils/hive_utils.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveUtils.initHive();

  runApp(const AppProviders(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
      ),
      routes: {
        '/': (context) => const TodoExampleDependencies(child: TodoExampleScreen()),
      },
    );
  }
}
