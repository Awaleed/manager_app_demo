
import 'package:hive/hive.dart';

import '../models/user.dart';

const String userBoxName = 'UserBox';
const String currentUserKey = 'currentUserKey';

UserModel? get kUser => UsersRepository().readUser(currentUserKey);

class UsersRepository {
  static final UsersRepository _singleton = UsersRepository._internal();

  factory UsersRepository() => _singleton;

  UsersRepository._internal() : box = Hive.box<UserModel>(userBoxName);

  final Box<UserModel> box;

  List<UserModel> readAllUser() => box.values.toList();

  UserModel? readUser(id) => box.get(id);

  Future<void> saveUser(UserModel user) async {
    final id = await box.add(user);
    readUser(id)!
      ..id = id
      ..save();
  }

  Future<void> setCurrentUSer(UserModel? user) async {
    if (user == null) {
      final _user = kUser;
      await box.delete(currentUserKey);
      await box.put(_user!.id, _user);
    } else {
      await box.delete(user.id);
      await box.put(currentUserKey, user);
    }
  }

  Future<void> register(UserModel user) async {
    await saveUser(user);
    setCurrentUSer(user);
  }

  Future<bool> login(String username, String password) async {
    for (final user in box.values) {
      if (user.name == username && user.password == password) {
        setCurrentUSer(user);
        return true;
      }
    }
    return false;
  }
}
