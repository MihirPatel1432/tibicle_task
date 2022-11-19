import 'dart:io';

import 'package:flutterprojectsetup/models/post.dart';

import '../domain/adapters/repository_adapter.dart';
import 'dashboard_api_provider.dart';

class DashboardRepository implements IDashboardRepository {
  DashboardRepository({required this.provider});

  final IDashboardProvider provider;

  @override
  Future<List<Post>> getPosts() async {
    final cases = await provider.getPosts('posts');
    if (cases.status.hasError) {
      return Future.error(cases.statusText!);
    } else {
      return cases.body!;
    }
  }

  @override
  Future<Object> uploadFile(File file) async {
    final cases = await provider.uploadFile('upload', file);
    if (cases.status.hasError) {
      return Future.error(cases.statusText!);
    } else {
      return cases.body!;
    }
  }
}
