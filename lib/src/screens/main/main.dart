import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:validators/validators.dart';

import '../../repositories/users_repository.dart';
import '../my_tasks/my_tasks.dart';
import '../projects/my_projects.dart';
import '../splash/splash.dart';
import 'dialogs/new_project.dart';

class MainScreen extends StatelessWidget {
  static MaterialPageRoute route() => MaterialPageRoute(
        builder: (context) => const MainScreen(),
      );

  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Main')),
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            children: [
              ListTile(
                title: const Text('My profile'),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: FormBuilder(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  FormBuilderTextField(
                                    name: 'name',
                                    initialValue: kUser?.name,
                                    validator: (value) {
                                      if ((value ?? '').isEmpty) {
                                        return 'Must not be empty';
                                      }
                                      for (final user
                                          in UsersRepository().readAllUser()) {
                                        if (user.name == value &&
                                            kUser?.name != value) {
                                          return 'Username already in use';
                                        }
                                      }
                                      return null;
                                    },
                                    decoration: const InputDecoration(
                                        labelText: 'Username'),
                                  ),
                                  FormBuilderTextField(
                                    name: 'password',
                                    initialValue: kUser?.password,
                                    obscureText: true,
                                    validator: (value) =>
                                        (value ?? '').isNotEmpty
                                            ? null
                                            : 'Must not be empty',
                                    decoration: const InputDecoration(
                                        labelText: 'Password'),
                                  ),
                                  FormBuilderTextField(
                                    name: 'email',
                                    initialValue: kUser?.email,
                                    validator: (value) => isEmail(value ?? '')
                                        ? null
                                        : 'Must be a valid E-mail',
                                    decoration: const InputDecoration(
                                        labelText: 'E-mail'),
                                  ),
                                  Builder(builder: (context) {
                                    return ElevatedButton(
                                      onPressed: () async {
                                        if (FormBuilder.of(context)!
                                            .validate()) {
                                          FormBuilder.of(context)!.save();
                                          kUser!.name = FormBuilder.of(context)!
                                              .value['name'];
                                          kUser!.password =
                                              FormBuilder.of(context)!
                                                  .value['password'];
                                          kUser!.email =
                                              FormBuilder.of(context)!
                                                  .value['email'];

                                          Navigator.of(context).pop();
                                        }
                                      },
                                      child: const Text('Save'),
                                    );
                                  })
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
              ListTile(
                title: const Text('Notifications'),
                onTap: () {
                  Navigator.of(context).push(MyTasksScreen.route());
                },
              ),
              ListTile(
                title: const Text('Logout'),
                onTap: () {
                  UsersRepository().setCurrentUSer(null);
                  Navigator.of(context).pushAndRemoveUntil(
                      SplashScreen.route(), (route) => false);
                },
              ),
            ],
          ),
        ),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Create new project'),
            onTap: () {
              Navigator.of(context).push(NewProjectDialog.route());
            },
          ),
          ListTile(
            title: const Text('My projects'),
            onTap: () {
              Navigator.of(context).push(MyProjectsScreen.route());
            },
          ),
          ListTile(
            title: const Text('My tasks'),
            onTap: () {
              Navigator.of(context).push(MyTasksScreen.route());
            },
          ),
        ],
      ),
    );
  }
}
