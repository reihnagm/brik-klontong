import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:brik/common/constants/remote_data_source_consts.dart';
import 'package:brik/common/errors/exception.dart';

import 'package:brik/features/auth/data/models/auth.dart';

abstract class AuthRemoteDataSource {
  Future<AuthModel> login({
    required String email,
    required String password,
  });
  Future<AuthModel> register({
    required String fullname,
    required String email, 
    required String password
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {

  Dio client;

  AuthRemoteDataSourceImpl({required this.client});

  @override
  Future<AuthModel> login({
    required String email, 
    required String password
  }) async {
    try { 
      final response = await client.post("${RemoteDataSourceConsts.baseUrl}/auth/login",
        data: {
          "email": email, 
          "password": password
        }
      );
      Map<String, dynamic> data = response.data;
      AuthModel authModel = AuthModel.fromJson(data);
      return authModel;
    } on DioException catch (e) {
      String message = handleDioException(e);
      throw ServerException(message);
    } catch (e, stacktrace) {
      debugPrint(stacktrace.toString());
      throw Exception(e.toString());
    }
  }

  @override
  Future<AuthModel> register({
    required String fullname, 
    required String email, 
    required String password
  }) async {
    try {
      final response = await client.post("${RemoteDataSourceConsts.baseUrl}/auth/register",
        data: {
          "fullname": fullname,
          "email": email, 
          "password": password
        }
      );
      Map<String, dynamic> data = response.data;
      AuthModel authModel = AuthModel.fromJson(data);
      return authModel;
    } on DioException catch (e) {
      String message = handleDioException(e);
      throw ServerException(message);
    } catch (e, stacktrace) {
      debugPrint(stacktrace.toString());
      throw Exception(e.toString());
    }
  }


}