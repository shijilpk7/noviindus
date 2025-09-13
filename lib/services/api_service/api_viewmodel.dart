// ignore_for_file: type_literal_in_constant_pattern

import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/material.dart';
import 'package:noviindus/models/response_models/branch_list_response.dart';
import 'package:noviindus/models/response_models/general_response.dart';
import 'package:noviindus/models/response_models/login_response.dart';
import 'package:noviindus/models/response_models/patient_list_response.dart';
import 'package:noviindus/models/response_models/treatment_list_response.dart';
import 'package:noviindus/services/api_service/api_urls.dart';
import 'package:noviindus/services/local_db/hive_constants.dart';
import 'package:noviindus/utils/app_constants.dart';

class ApiViewModel {
  Dio dio = Dio();
  String pro = '0.0';
  CookieJar cookieJar = CookieJar();

  ApiViewModel() {
    String baseUrl;
    baseUrl = ApiUrls.kStagingBaseURL;

    dio
      ..options.baseUrl = baseUrl
      ..options.connectTimeout = const Duration(seconds: 200)
      ..options.receiveTimeout = const Duration(seconds: 200)
      ..options.headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      };

    dio.interceptors.add(CookieManager(cookieJar));
    dio.interceptors.add(
      LogInterceptor(responseBody: true, requestBody: true, request: true),
    );

    // 👇 Trust self-signed certs for dev/staging only (skip on web)
    if (dio.httpClientAdapter is IOHttpClientAdapter) {
      (dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate = (
        HttpClient client,
      ) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      };
    }
  }
  Future<T?> login<T>({
    required String apiUrl,
    required Map<String, dynamic>? data,
  }) async {
    try {
      final formData = FormData.fromMap(data ?? {});
      final response = await dio.post(apiUrl, data: formData);

      if (response.statusCode == 200) {
        final parsed = fromJson<T>(response.data);

        // if this is LoginResponse, save the token
        if (parsed is LoginResponse && parsed.token != null) {
          await hiveInstance?.saveData(DataBoxKey.kauthKey, parsed.token);
        }

        return parsed;
      } else {
        throw Failure.fromCode(response.statusCode ?? ResponseCode.DEFAULT);
      }
    } on DioException catch (error) {
      throw Failure.fromCode(
        error.response?.statusCode ?? ResponseCode.DEFAULT,
      );
    }
  }

  Future<T?> get<T>({
    required String apiUrl,
    Map<String, dynamic>? params,
  }) async {
    try {
      _attachAuthHeaders();

      Response response = await dio.get(apiUrl, queryParameters: params);

      if (response.statusCode == 200) {
        return fromJson<T>(response.data);
      } else {
        throw Failure.fromCode(response.statusCode ?? ResponseCode.DEFAULT);
      }
    } on DioException catch (error) {
      throw Failure.fromCode(
        error.response?.statusCode ?? ResponseCode.DEFAULT,
      );
    }
  }

  Future<T?> post<T>({
    required String apiUrl,
    Map<String, dynamic>? data,
    Map<String, dynamic>? params,
  }) async {
    try {
      _attachAuthHeaders();
      final formData = FormData.fromMap(data ?? {});

      Response response = await dio.post(
        apiUrl,
        data: formData,
        queryParameters: params,
      );

      if (response.statusCode == 200) {
        return fromJson<T>(response.data);
      } else {
        throw Failure.fromCode(response.statusCode ?? ResponseCode.DEFAULT);
      }
    } on DioException catch (error) {
      throw Failure.fromCode(
        error.response?.statusCode ?? ResponseCode.DEFAULT,
      );
    }
  }

  Future<T?> put<T>({
    required String apiUrl,
    Map<String, dynamic>? data,
  }) async {
    try {
      _attachAuthHeaders();
      final formData = FormData.fromMap(data ?? {});
      Response response = await dio.put(apiUrl, data: formData);

      if (response.statusCode == 200) {
        return fromJson<T>(response.data);
      } else {
        throw Failure.fromCode(response.statusCode ?? ResponseCode.DEFAULT);
      }
    } on DioException catch (error) {
      log(error.response.toString());
      throw Failure.fromCode(
        error.response?.statusCode ?? ResponseCode.DEFAULT,
      );
    }
  }

  Future<T?> postFormdata<T>({
    required String apiUrl,
    required FormData data,
  }) async {
    try {
      _attachAuthHeaders();

      Response response = await dio.post(apiUrl, data: data);

      if (response.statusCode == 200) {
        return fromJson<T>(response.data);
      } else {
        throw Failure.fromCode(response.statusCode ?? ResponseCode.DEFAULT);
      }
    } on DioException catch (error) {
      throw Failure.fromCode(
        error.response?.statusCode ?? ResponseCode.DEFAULT,
      );
    }
  }

  // Convert response to respective model classes
  T fromJson<T>(Map<String, dynamic> json) {
    log(json.toString());
    switch (T) {
      case LoginResponse:
        return LoginResponse.fromJson(json) as T;
      case PatientListResponse:
        return PatientListResponse.fromJson(json) as T;
      case TreatmentListResponse:
        return TreatmentListResponse.fromJson(json) as T;
      case BranchListResponse:
        return BranchListResponse.fromJson(json) as T;
      case GeneralResponse:
        return GeneralResponse.fromJson(json) as T;

      default:
        throw FromJsonNotImplementedException();
    }
  }

  void _attachAuthHeaders() {
    // 🔹 Attach token
    final token = hiveInstance?.getData("auth_token");
    if (token != null && token.toString().isNotEmpty) {
      dio.options.headers["Authorization"] = "Bearer $token";
    }
  }
}

class FromJsonNotImplementedException implements Exception {
  @override
  String toString() {
    return 'FromJsonNotImplementedException: From Json Not Implemented. '
        'Possible Fixes: \n '
        '1. Check if Model class matches with API response \n '
        '2. Check if the response model class is added in the switch case in api_viewmodel.dart (line: 140)';
  }
}

class Failure {
  final String message;
  Failure(this.message);

  @override
  String toString() => message;

  factory Failure.fromCode(int code) {
    if (code == ResponseCode.DEFAULT) {
      debugPrint("Status code error: $code");
    }
    switch (code) {
      case ResponseCode.SUCCESS:
        return Failure("Success");
      case ResponseCode.NO_CONTENT:
        return Failure("Success with no content");
      case ResponseCode.BAD_REQUEST:
        return Failure("Bad request");
      case ResponseCode.UNAUTORISED:
        return Failure("Unauthorised");
      case ResponseCode.FORBIDDEN:
        return Failure("Forbidden");
      case ResponseCode.NOT_FOUND:
        return Failure("Not found");
      case ResponseCode.INTERNAL_SERVER_ERROR:
        return Failure("Internal server error");
      case ResponseCode.CONNECT_TIMEOUT:
        return Failure("Connection timeout");
      case ResponseCode.CANCEL:
        return Failure("Request cancelled");
      case ResponseCode.RECIEVE_TIMEOUT:
        return Failure("Receive timeout");
      case ResponseCode.SEND_TIMEOUT:
        return Failure("Send timeout");
      case ResponseCode.CACHE_ERROR:
        return Failure("Cache error");
      case ResponseCode.NO_INTERNET_CONNECTION:
        return Failure("No internet connection");
      default:
        return Failure("Something went wrong, Please try again");
    }
  }
}

class ResponseCode {
  static const int SUCCESS = 200; // success with data
  static const int NO_CONTENT = 201; // success with no data (no content)
  static const int BAD_REQUEST = 400; // failure, API rejected request
  static const int UNAUTORISED = 401; // failure, user is not authorised
  static const int FORBIDDEN = 403; //  failure, API rejected request
  static const int INTERNAL_SERVER_ERROR = 500; // failure, crash in server side
  static const int NOT_FOUND = 404; // failure, not found

  // local status code
  static const int CONNECT_TIMEOUT = -1;
  static const int CANCEL = -2;
  static const int RECIEVE_TIMEOUT = -3;
  static const int SEND_TIMEOUT = -4;
  static const int CACHE_ERROR = -5;
  static const int NO_INTERNET_CONNECTION = -6;
  static const int DEFAULT = -7;
}

void handleApiException(int statusCode) {
  final failure = Failure.fromCode(statusCode);
  print(failure);
}
