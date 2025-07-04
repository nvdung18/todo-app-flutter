import 'package:flutter_application_1/core/network_handler.dart';
import 'package:flutter_application_1/core/responses/result.dart';
import 'package:flutter_application_1/models/post_model.dart';
import 'package:flutter_application_1/services/post_service.dart';

class PostRepo {
  final PostService postService;

  factory PostRepo({required PostService postService}) {
    return PostRepo._internal(postService);
  }

  PostRepo._internal(this.postService);

  Future<Result<List<PostModel>>> getPosts() {
    return NetworkHandler.safeApiCall(() async {
      final response = await postService.getPosts();

      // Extract posts array from response
      final postsData = response['posts'] as List<dynamic>;

      return postsData
          .map((e) => PostModel.fromJson(e as Map<String, dynamic>))
          .toList();
    });
  }

  Future<Result<List<PostModel>>> searchPosts(String query) {
    return NetworkHandler.safeApiCall(() async {
      final response = await postService.searchPosts(query);

      // Extract posts array from response
      final postsData = response['posts'] as List<dynamic>;

      return postsData
          .map((e) => PostModel.fromJson(e as Map<String, dynamic>))
          .toList();
    });
  }
}
