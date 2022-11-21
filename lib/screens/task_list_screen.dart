import 'package:flutter/material.dart';
import 'package:flutter_bloc_todo/model/task.dart';

import '../bloc/bloc_exports.dart';
import 'my_drawer.dart';

class TaskListScreen extends StatelessWidget {
  TaskListScreen({Key? key}) : super(key: key);
  static const id = 'task_screen';
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
                      context.read<TaskBloc>().add(AddTask(task: task));
                      titleController.clear();
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
    return Scaffold(
      drawer: const MyDrawer(),
      appBar: AppBar(
        title: const Text('Task List'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addTask(context),
      ),
      body: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          return ListView.builder(
            itemCount: state.allTasks.length,
            itemBuilder: (context, index) {
              var helper = state.allTasks[index];
              return ListTile(
                onLongPress: () {
                  context.read<TaskBloc>().add(RemoveTask(task: helper));
                },
                title: Text(
                  helper.title,
                  style: helper.isDone!
                      ? const TextStyle(
                          decoration: TextDecoration.lineThrough,
                        )
                      : const TextStyle(color: Colors.black),
                ),
                trailing: Checkbox(
                  value: helper.isDone,
                  onChanged: (value) {
                    context.read<TaskBloc>().add(UpdateTask(task: helper));
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
