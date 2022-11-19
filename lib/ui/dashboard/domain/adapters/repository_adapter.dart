import 'dart:io';

import 'package:flutterprojectsetup/models/post.dart';

abstract class IDashboardRepository {
  Future<List<Post>> getPosts();

  // TODO : Sample code for file upload
  Future<Object> uploadFile(File file);
}
