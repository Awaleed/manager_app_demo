import 'package:flutter/material.dart';

import '../../repositories/projects_repository.dart';

class MyProjectsScreen extends StatelessWidget {
  static MaterialPageRoute route() => MaterialPageRoute(
        builder: (context) => const MyProjectsScreen(),
      );

  const MyProjectsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Projects')),
      body: ListView(
        children: [
          for (var item in ProjectsRepository().readMyProjects())
            ListTile(
              title: Text(item.name),
              subtitle: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Users'),
                          content: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              for (var item in item.users) Text(item.name)
                            ],
                          ),
                        ),
                      );
                    },
                    child: const Text('Users'),
                  ),
                  TextButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Tasks'),
                          content: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              for (var item in item.tasks) Text(item.name)
                            ],
                          ),
                        ),
                      );
                    },
                    child: const Text('Tasks'),
                  )
                ],
              ),
            ),
        ],
      ),
    );
  }
}
