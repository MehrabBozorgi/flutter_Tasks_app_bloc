import 'package:flutter/material.dart';
import 'package:flutter_bloc_todo/model/task.dart';

import 'bloc/bloc_exports.dart';

class TaskListScreen extends StatelessWidget {
  TaskListScreen({Key? key}) : super(key: key);

  TextEditingController titleController = TextEditingController();

  void _addTask(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              const Text('Add Task'),
              const SizedBox(height: 30),
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(
                      color: Colors.blueAccent,
                      width: 2,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Back'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      var task = Task(title: titleController.text);

                      context.read<TasksBloc>().add(AddTask(task: task));
                      Navigator.of(context).pop();
                    },
                    child: const Text('add task'),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        List<Task> taskList = state.allTasks;
        return Scaffold(
          resizeToAvoidBottomInset: true,
          floatingActionButton: FloatingActionButton(
            onPressed: () => _addTask(context),
            child: const Icon(Icons.add),
          ),
          appBar: AppBar(
            title: const Text('Add Task'),
          ),
          body: ListView.builder(
            itemCount: taskList.length,
            itemBuilder: (context, index) {
              return ListTile(
                onLongPress: () => context
                    .read<TasksBloc>()
                    .add(DeleteTask(task: taskList[index])),
                title: Text(taskList[index].title),
                trailing: Checkbox(
                  value: taskList[index].isDone,
                  onChanged: (value) {
                    context
                        .read<TasksBloc>()
                        .add(UpdateTask(task: taskList[index]));
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }
}
