import 'package:hive_flutter/hive_flutter.dart';
import 'package:manager_app/src/models/project.dart';
import 'package:manager_app/src/models/task.dart';
import 'package:manager_app/src/repositories/projects_repository.dart';

import 'src/models/user.dart';
import 'src/repositories/users_repository.dart';

Future<void> initHive() async {
  await Hive.initFlutter('manager_app_1');

  Hive.registerAdapter<UserModel>(UserModelAdapter());
  Hive.registerAdapter<TaskModel>(TaskModelAdapter());
  Hive.registerAdapter<ProjectModel>(ProjectModelAdapter());
  await Hive.openBox<UserModel>(userBoxName);
  await Hive.openBox<ProjectModel>(projectsBoxName);
}
