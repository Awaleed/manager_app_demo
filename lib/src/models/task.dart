import 'package:hive_flutter/adapters.dart';
import 'package:manager_app/src/models/user.dart';
part 'task.g.dart';

@HiveType(typeId: 2)
class TaskModel extends HiveObject {
  TaskModel({
    this.id,
    required this.name,
    required this.users,
    this.state = 0,
  });

  @HiveField(0)
  int? id;

  @HiveField(1)
  String name;

  @HiveField(2)
  List<UserModel> users;

  @HiveField(3)
  int state;
}
