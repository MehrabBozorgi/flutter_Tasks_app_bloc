import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_todo/bloc/bloc_exports.dart';

import '../model/task.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc() : super(TaskState()) {
    on<AddTask>(_onAddTask);
    on<UpdateTask>(_onUpdateTask);
    on<DeleteTask>(_onDeleteTask);
    on<RemoveTask>(_onRemoveTask);
  }

  void _onAddTask(AddTask event, Emitter<TaskState> emit) {
    final state = this.state;
    emit(TaskState(
      allTasks: List.from(state.allTasks)..add(event.task),
      removeTasks: state.removeTasks,
    ));
  }

  void _onUpdateTask(UpdateTask event, Emitter<TaskState> emit) {
    final state = this.state;
    final task = event.task;
    final int index = state.allTasks.indexOf(event.task);
    List<Task> allTask = List.from(state.allTasks)..remove(event.task);

    task.isDone == false
        ? allTask.insert(index, task.copyWith(isDone: true))
        : allTask.insert(index, task.copyWith(isDone: false));
    emit(TaskState(allTasks: allTask, removeTasks: state.removeTasks));
  }

  void _onDeleteTask(DeleteTask event, Emitter<TaskState> emit) {
    final state = this.state;

    emit(TaskState(
      allTasks: state.allTasks,
      removeTasks: List.from(state.removeTasks)..remove(event.task),
    ));
  }

  void _onRemoveTask(RemoveTask event, Emitter<TaskState> emit) {
    final state = this.state;

    emit(TaskState(
      allTasks: List.from(state.allTasks)..remove(event.task),
      removeTasks: List.from(state.removeTasks)
        ..add(event.task.copyWith(isDeleted: true)),
    ));
  }
}
