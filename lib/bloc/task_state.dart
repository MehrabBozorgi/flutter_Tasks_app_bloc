part of 'task_bloc.dart';

class TaskState extends Equatable {
  TaskState({
    this.allTasks = const <Task>[],
  });

  List<Task> allTasks = [];

  @override
  List<Object?> get props => [allTasks];
}
