import 'package:dio/dio.dart';
import 'package:flutter_application_1/models/post_model.dart';
import 'package:retrofit/retrofit.dart';

part 'post_service.g.dart';

@RestApi()
abstract class PostService {
  factory PostService(Dio dio, {String baseUrl}) = _PostService;

  @GET('/posts')
  Future<dynamic> getPosts();

  @GET('/posts/search')
  Future<dynamic> searchPosts(@Query('q') String query);
}
