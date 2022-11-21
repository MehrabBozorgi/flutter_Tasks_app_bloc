import 'package:flutter/material.dart';
import 'package:flutter_bloc_todo/bloc/bloc_exports.dart';
import 'package:flutter_bloc_todo/screens/task_list_screen.dart';
import 'package:flutter_bloc_todo/service/app_router.dart';

void main() {
  runApp(MyApp(
    appRouter: AppRouter(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.appRouter}) : super(key: key);
  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TaskBloc(),
      child: MaterialApp(
        home: TaskListScreen(),
        onGenerateRoute: appRouter.onGenerateRout,
      ),
    );
  }
}
