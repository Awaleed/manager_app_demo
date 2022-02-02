import 'package:hive_flutter/adapters.dart';
part 'user.g.dart';

@HiveType(typeId: 0)
class UserModel extends HiveObject {
  UserModel({
    this.id,
    required this.name,
    required this.password,
    required this.email,
  });

  @HiveField(0)
  int? id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String password;

  @HiveField(3)
  String email;
}
