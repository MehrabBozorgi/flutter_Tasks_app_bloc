import 'package:flutter/material.dart';

import '../bloc/bloc_exports.dart';
import 'my_drawer.dart';

class RecycleBinScreen extends StatelessWidget {
  const RecycleBinScreen({Key? key}) : super(key: key);
  static const id = 'recycler_bin_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawer(),
      appBar: AppBar(
        title: const Text('Bin List'),
      ),
      body: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          return ListView.builder(
            itemCount: state.removeTasks.length,
            itemBuilder: (context, index) {
              var helper = state.removeTasks[index];
              return ListTile(
                onLongPress: () {
                  context.read<TaskBloc>().add(DeleteTask(task: helper));
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

                    context.read<TaskBloc>().add(DeleteTask(task: helper));

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
