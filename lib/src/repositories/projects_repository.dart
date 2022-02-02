import 'package:hive/hive.dart';
import 'package:manager_app/src/repositories/users_repository.dart';

import '../models/project.dart';

const String projectsBoxName = 'ProjectsBox';

class ProjectsRepository {
  static final ProjectsRepository _singleton = ProjectsRepository._internal();

  factory ProjectsRepository() => _singleton;

  ProjectsRepository._internal()
      : box = Hive.box<ProjectModel>(projectsBoxName);

  final Box<ProjectModel> box;

  List<ProjectModel> readAllProjects() => box.values.toList();

  List<ProjectModel> readMyProjects() =>
      box.values.where((element) => element.creator.id == kUser!.id).toList();

  Future<void> saveProject(ProjectModel project) async {
    final id = await box.add(project);
    box.get(id)!
      ..id = id
      ..save();
  }
}
