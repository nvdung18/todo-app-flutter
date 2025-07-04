// To parse this JSON data, do
//
//     final userLoginResponseModel = userLoginResponseModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';

part 'user_login_response_model.g.dart';

@JsonSerializable()
class UserLoginResponseModel {
  final int id;
  final String username;
  final String email;
  final String firstName;
  final String lastName;
  final String gender;
  final String image;
  final String accessToken;
  final String refreshToken;

  UserLoginResponseModel({
    required this.id,
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.image,
    required this.accessToken,
    required this.refreshToken,
  });

  factory UserLoginResponseModel.fromJson(Map<String, dynamic> json) =>
      _$UserLoginResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserLoginResponseModelToJson(this);
}
