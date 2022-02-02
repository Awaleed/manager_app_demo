import 'package:hive_flutter/adapters.dart';
import 'package:manager_app/src/models/task.dart';
import 'package:manager_app/src/models/user.dart';
part 'project.g.dart';

@HiveType(typeId: 1)
class ProjectModel extends HiveObject {
  ProjectModel({
    this.id,
    required this.name,
    required this.users,
    required this.tasks,
    required this.creator,
  });

  @HiveField(0)
  int? id;

  @HiveField(1)
  String name;

  @HiveField(2)
  List<UserModel> users;

  @HiveField(3)
  List<TaskModel> tasks;

  @HiveField(4)
  UserModel creator;
}
