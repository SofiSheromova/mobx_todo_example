import 'package:flutter/material.dart';
import 'package:mobx_todo/presentation/ui/screens/todo/todo_example_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
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
        '/': (context) => const TodoExampleScreen(),
      },
    );
  }
}
