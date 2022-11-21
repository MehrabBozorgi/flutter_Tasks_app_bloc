import 'package:flutter/material.dart';
import 'package:flutter_bloc_todo/screens/recycler_bin_screen.dart';
import 'package:flutter_bloc_todo/screens/task_list_screen.dart';

class AppRouter {
  Route? onGenerateRout(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RecycleBinScreen.id:
        return MaterialPageRoute(builder: (_) => const RecycleBinScreen());

      case TaskListScreen.id:
        return MaterialPageRoute(builder: (_) => TaskListScreen());

      default:
        return null;
    }
  }
}
