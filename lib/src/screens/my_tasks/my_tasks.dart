import 'package:flutter/material.dart';

import 'package:manager_app/src/models/project.dart';
import 'package:manager_app/src/models/task.dart';
import 'package:manager_app/src/repositories/users_repository.dart';

import '../../repositories/projects_repository.dart';

class MyTasksScreen extends StatelessWidget {
  static MaterialPageRoute route() => MaterialPageRoute(
        builder: (context) => const MyTasksScreen(),
      );

  const MyTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Tasks')),
      body: ListView(
        children: [
          for (var item in ProjectsRepository().readMyProjects())
            TaskItem(item),
        ],
      ),
    );
  }
}

class TaskItem extends StatefulWidget {
  const TaskItem(this.project, {Key? key}) : super(key: key);

  final ProjectModel project;

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  @override
  Widget build(BuildContext context) {
    final list = <TaskModel>[];

    for (var task in widget.project.tasks) {
      for (var user in task.users) {
        if (user.id == kUser?.id) {
          list.add(task);
        }
      }
    }

    if (list.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          title: Text(widget.project.name),
          selected: true,
          dense: true,
        ),
        for (var task in list)
          ListTile(
            title: Text(task.name),
            subtitle: task.state != 0
                ? null
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextButton(
                        onPressed: () {
                          task.state = 1;
                          widget.project.save();
                          setState(() {});
                        },
                        child: const Text('Completed'),
                      ),
                      TextButton(
                        onPressed: () {
                          task.state = 2;
                          widget.project.save();
                          setState(() {});
                        },
                        child: const Text('Cancelled'),
                      )
                    ],
                  ),
          ),
      ],
    );
  }
}
