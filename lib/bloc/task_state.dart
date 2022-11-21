part of 'task_bloc.dart';

class TaskState extends Equatable {
  TaskState({
    this.allTasks = const <Task>[],
    this.removeTasks = const <Task>[],
  });

  List<Task> allTasks = [];
  List<Task> removeTasks   = [];

  @override
  List<Object?> get props => [allTasks];
}
