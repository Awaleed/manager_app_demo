import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import '../../../models/project.dart';
import '../../../models/task.dart';
import '../../../models/user.dart';
import '../../../repositories/projects_repository.dart';
import '../../../repositories/users_repository.dart';

class NewProjectDialog extends StatelessWidget {
  static MaterialPageRoute route() => MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => const NewProjectDialog(),
      );

  const NewProjectDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New project')),
      body: FormBuilder(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  FormBuilderTextField(
                    name: 'name',
                    validator: (value) {
                      if ((value ?? '').isEmpty) return 'Must not be empty';

                      return null;
                    },
                    decoration:
                        const InputDecoration(labelText: 'Project name'),
                  ),
                  FormBuilderCheckboxGroup<UserModel>(
                    name: 'users',
                    options: [
                      ...UsersRepository().readAllUser().map(
                            (e) => FormBuilderFieldOption(
                              value: e,
                              child: Text(e.name),
                            ),
                          )
                    ],
                    validator: (value) =>
                        (value ?? []).isNotEmpty ? null : 'Must not be empty',
                    decoration: const InputDecoration(labelText: 'Users'),
                  ),
                  const Divider(),
                  const ListTile(
                    title: Text('Tasks'),
                  ),
                  const Tasks(),
                  Builder(builder: (context) {
                    return ElevatedButton(
                      onPressed: () async {
                        if (FormBuilder.of(context)!.validate()) {
                          FormBuilder.of(context)!.save();
                          await ProjectsRepository().saveProject(
                            ProjectModel(
                              name: FormBuilder.of(context)!.value['name'],
                              users:
                                  FormBuilder.of(context)!.value['users'] ?? [],
                              tasks:
                                  FormBuilder.of(context)!.value['tasks'] ?? [],
                              creator: kUser!,
                            ),
                          );
                          Navigator.of(context).pop();
                        }
                      },
                      child: const Text('Add Project'),
                    );
                  })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Tasks extends StatefulWidget {
  const Tasks({Key? key}) : super(key: key);

  @override
  State<Tasks> createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  TextEditingController controller = TextEditingController();
  List<UserModel> users = [];

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilderField<List<TaskModel>>(
      name: 'tasks',
      builder: (field) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (var item in field.value ?? <TaskModel>[])
              ListTile(
                title: Text(item.name),
                trailing: IconButton(
                  onPressed: () {
                    field.value?.remove(item);
                    field.didChange(field.value);
                    setState(() {});
                  },
                  icon: const Icon(Icons.delete),
                ),
              ),
            TextField(
              controller: controller,
              decoration: const InputDecoration(labelText: 'Task name'),
            ),
            MultiSelectDialogField<UserModel?>(
              buttonText: const Text('Users for the task'),
              title: const Text('Users'),
              items: [
                ...UsersRepository().readAllUser().map(
                      (e) => MultiSelectItem(e, e.name),
                    )
              ],
              initialValue: users,
              onConfirm: (value) {
                users.clear();
                for (var item in value) {
                  if (item != null) {
                    users.add(item);
                  }
                }
                setState(() {});
              },
            ),
            ElevatedButton(
              onPressed: () async {
                if (controller.text.isEmpty) return;
                field.didChange([
                  ...field.value ?? [],
                  TaskModel(name: controller.text, users: users)
                ]);
                controller.clear();
                users = [];
                setState(() {});
              },
              child: const Text('Sava new task'),
            ),
          ],
        );
      },
    );
  }
}
