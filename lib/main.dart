import 'package:flutter/material.dart';
import 'package:flutter_bloc_todo/bloc/bloc_exports.dart';
import 'package:flutter_bloc_todo/task_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TaskBloc(),
      child: MaterialApp(
        home: TaskListScreen(),
      ),
    );
  }
}
