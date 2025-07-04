import 'package:dio/dio.dart';
import 'package:flutter_application_1/configs/dio_config.dart';
import 'package:flutter_application_1/core/responses/result.dart';
import 'package:flutter_application_1/models/post_model.dart';
import 'package:flutter_application_1/providers/error_provider.dart';
import 'package:flutter_application_1/repos/post_repo.dart';
import 'package:flutter_application_1/services/post_service.dart';
import 'package:flutter_application_1/utils/constant.dart';

class BlogProvider {
  static final BlogProvider _instance = BlogProvider._internal();
  factory BlogProvider() => _instance;
  BlogProvider._internal();

  Dio dummyAPI = DioFactory.getDio(KUrl.DUMMYJSON);
  List<PostModel>? _posts;

  Future<List<PostModel>> fetchPosts() async {
    final result = await PostRepo(
      postService: PostService(dummyAPI),
    ).getPosts();
    switch (result) {
      case Ok(value: final posts):
        _posts = posts;
        break;
      case Error(error: final e):
        print('Error: $e');
        GlobalErrorHandler.instance.setError(result.error);
        break;
    }
    return _posts ?? [];
  }

  Future<List<PostModel>> searchPosts(String query) async {
    final result = await PostRepo(
      postService: PostService(dummyAPI),
    ).searchPosts(query);
    switch (result) {
      case Ok(value: final posts):
        _posts = posts;
        break;
      case Error(error: final e):
        print('Error: $e');
        GlobalErrorHandler.instance.setError(result.error);
        break;
    }
    return _posts ?? [];
  }
}
