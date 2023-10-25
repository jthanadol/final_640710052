import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ApiCaller{
  static const baseUrl = "https://cpsu-test-api.herokuapp.com/api/1_2566/weather";
  static final _dio = Dio(BaseOptions(responseType: ResponseType.plain));

  Future<String> get(String endpoint) async {
    try {
      final response =
      await _dio.get('$baseUrl/$endpoint');
      debugPrint(response.data.toString());
      return response.data.toString();
    } catch (e) {
      // TODO:
      rethrow;
    }
  }
}