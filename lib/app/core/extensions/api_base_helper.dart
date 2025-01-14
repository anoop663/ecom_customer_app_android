// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:ecommerce_app/app/controllers/base_controller.dart';
import 'package:ecommerce_app/app/core/values/api_configs.dart';
import 'package:ecommerce_app/app/routes/routes.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart' as geti;
import 'package:http/http.dart' as http;
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

class ApiBaseHelper {
  final String _baseUrl = ApiConfig.apiUrl;

  final Map<String, String> _headers = ApiConfig.headers;
  final Map<String, String> _headersMultipart = ApiConfig.headersMultipart;

  Future<dynamic> get(
    String url, {
    Map<String, String>? headers,
    Map<String, String>? queryParameters,
  }) async {
    dynamic responseJson;
    try {
      if (headers != null) {
        headers.addAll(_headers);
      }
      var uri =
          Uri.parse(_baseUrl + url).replace(queryParameters: queryParameters);
      final response = await http.get(uri, headers: headers);
      responseJson = _returnResponse(response);
    } on SocketException {
      throw CommonFailure(message: 'No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> post(String url,
      {Map<String, dynamic> body = const {},
      Map<String, String>? headers}) async {
    dynamic responseJson;
    try {
      if (headers != null) {
        headers.addAll(_headers);
      }
      if (kDebugMode) {
        print(_baseUrl + url);
      }
      if (kDebugMode) {
        print(body.toString());
      }
      var uri = Uri.parse(_baseUrl + url);
      final response = await http.post(uri, body: body, headers: headers);
      if (kDebugMode) {
        print(response.body);
      }
      responseJson = _returnResponse(response);
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      if (e.toString().contains('Failed host lookup')) {
        bool isOnline = true;
        final controller = geti.Get.find<BaseController>();
        switch (controller.source.keys.toList()[0]) {
          case ConnectivityResult.mobile:
            isOnline = true;
            break;
          case ConnectivityResult.wifi:
            isOnline = true;
            break;
          case ConnectivityResult.none:
            isOnline = false;
            break;
          default:
            isOnline = false;
        }
        if (!isOnline) {
          geti.Get.toNamed(Routes.noconnection);
        }

        throw CommonFailure(message: 'Oops..No network detected');
      } else {
        throw CommonFailure(message: e.toString());
      }
    }
    return responseJson;
  }

  Future<dynamic> postMultipart(String url,
      {Map<String, String>? body,
      Map<String, String>? headers,
      String file = '',
      required String key}) async {
    dynamic responseJson;
    try {
      var uri = Uri.parse(_baseUrl + url);
      var request = http.MultipartRequest("POST", uri);

      if (headers != null) {
        headers.addAll(_headersMultipart);
        request.headers.addAll(headers);
      }
      if (body != null) {
        request.fields.addAll(body);
      }
      if (file.isNotEmpty) {
        request.files.add(await http.MultipartFile.fromPath(key, file));
      }
      var streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      responseJson = _returnResponse(response);
    } on SocketException {
      throw CommonFailure(message: 'No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> put(String url,
      {Map<String, dynamic> body = const {},
      Map<String, String> header = const {}}) async {
    dynamic responseJson;
    try {
      header.addAll(_headers);
      var uri = Uri.parse(_baseUrl + url);
      final response =
          await http.put(uri, body: jsonEncode(body), headers: header);
      responseJson = _returnResponse(response);
    } on SocketException {
      throw CommonFailure(message: 'No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> delete(String url,
      {Map<String, String> header = const {}}) async {
    dynamic responseJson;
    try {
      header.addAll(_headers);
      var uri = Uri.parse(_baseUrl + url);
      final response = await http.delete(uri, headers: header);
      responseJson = _returnResponse(response);
    } on SocketException {
      throw CommonFailure(message: 'No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> postDio(
    String url,
    Map<String, dynamic> data,
  ) async {
    if (kDebugMode) {
      print(data);
    }
    // Map<String, MultipartFile>? fileMap = {};

    /*for (MapEntry fileEntry in files.entries) {
      File file = fileEntry.value;
      String fileName = basename(file.path);
      fileMap[fileEntry.key] =
          MultipartFile(file.openRead(), await file.length(), filename: fileName);
    }*/

    // data.addAll(fileMap);

    var formData = FormData.fromMap(data, ListFormat.multiCompatible);

    if (kDebugMode) {
      print(_baseUrl + url);
    }
    if (kDebugMode) {
      print(formData.fields);
    }
    Dio dio = Dio(
      BaseOptions(
        baseUrl: ApiConfig.apiUrl,
        receiveTimeout: const Duration(
          seconds: 6,
        ),
      ),
    );

    Response<String> response = await dio.post(url,
        data: formData, options: Options(contentType: 'multipart/form-data'));

    if (kDebugMode) {
      print(response.data.toString());
    }
    dynamic responseJson = json.decode(response.data!);
    return responseJson;
  }

  Future<dynamic> sendForm(
      String url, Map<String, dynamic> data, Map<String, String> headers,
      {String? file,
      String? key,
      String? file2,
      String? key2,
      String? file3,
      String? key3,
      String? file4,
      String? key4}) async {
    Map<String, MultipartFile>? fileMap = {};

    /*for (MapEntry fileEntry in files.entries) {
      File file = fileEntry.value;
      String fileName = basename(file.path);
      fileMap[fileEntry.key] =
          MultipartFile(file.openRead(), await file.length(), filename: fileName);
    }*/

    if (file != null) {
      fileMap[key!] = MultipartFile(
          File(file).openRead(), await File(file).length(),
          filename: basename(file));
    }

    if (file2 != null) {
      fileMap[key2!] = MultipartFile(
          File(file2).openRead(), await File(file2).length(),
          filename: basename(file2));
    }

    if (file3 != null) {
      fileMap[key3!] = MultipartFile(
          File(file3).openRead(), await File(file3).length(),
          filename: basename(file3));
    }

    if (file4 != null) {
      fileMap[key4!] = MultipartFile(
          File(file4).openRead(), await File(file4).length(),
          filename: basename(file4));
    }

    data.addAll(fileMap);

    var formData = FormData.fromMap(data, ListFormat.multiCompatible);
    Dio dio = Dio(BaseOptions(
        baseUrl: ApiConfig.apiUrl,
        headers: headers,
        receiveTimeout: const Duration(
          seconds: 6,
        )));
    Response<String> response = await dio.post(url,
        data: formData, options: Options(contentType: 'multipart/form-data'));
    log(response.data.toString());
    dynamic responseJson = json.decode(response.data!);
    return responseJson;
  }
}

dynamic _returnResponse(http.Response response) {
  switch (response.statusCode) {
    case 200:
    case 422:
      var responseJson = json.decode(response.body.toString());
      return responseJson;
    case 400:
      throw CommonFailure(message: response.body.toString());
    case 401:
    case 403:
      throw CommonFailure(message: response.body.toString());

    case 500:
    default:
      throw CommonFailure(
        message:
            'Error occurred while Communication with Server with StatusCode : ${response.statusCode}',
      );
  }
}

class Failure {
  String? code;
  String? text;
  Failure({this.code, this.text});
  Failure.fromJson(Map<String, dynamic> json) {
    code = json['success'] == 0 ? '200' : json['success'].toString();
    text = json['message'];
  }
}

class Success {
  int? success;
  String? message;
  int? cartCount;
  Success({this.success, this.message, this.cartCount});
  Success.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    cartCount = json['cartcount'];
  }
}

class LoginFailure implements Exception {}

class CommonFailure implements Exception {
  CommonFailure({
    this.message = '',
  });
  final String message;

  @override
  String toString() {
    return message;
  }
}

