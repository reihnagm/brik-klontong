
import 'package:brik/common/constants/remote_data_source_consts.dart';
import 'package:brik/common/errors/exception.dart';
import 'package:brik/features/user/data/models/profile/profile.dart';
import 'package:brik/features/user/data/models/user_activity/user_activity.dart';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

abstract class UserRemoteDataSource {
  Future<UserActivityModel> getListUserActivity();
  Future<ProfileModel> getProfile();
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {

  Dio client;

  UserRemoteDataSourceImpl({required this.client});

  @override
  Future<UserActivityModel> getListUserActivity() async {
    try {
      final response = await client.get("${RemoteDataSourceConsts.baseUrl}/list-user-activity");
      Map<String, dynamic> data = response.data;
      UserActivityModel userActivityModel = UserActivityModel.fromJson(data);
      return userActivityModel;
    } on DioException catch(e) {
      String message = handleDioException(e);
      throw ServerException(message);
    } catch(e, stacktrace) {
      debugPrint(stacktrace.toString());
      throw Exception(e.toString());
    }   
  }

  @override 
  Future<ProfileModel> getProfile() async {
    try {
      final response = await client.get("${RemoteDataSourceConsts.baseUrl}/profile");
      Map<String, dynamic> data = response.data;
      ProfileModel profile = ProfileModel.fromJson(data);
      return profile;
    } on DioException catch(e) {
      String message = handleDioException(e);
      throw ServerException(message);
    } catch(e, stacktrace) {
      debugPrint(stacktrace.toString());
      throw Exception(e.toString());
    }
  }


}