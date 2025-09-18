// ignore_for_file: avoid_print, constant_identifier_names

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:societyadminapp/utils/Constants/session_controller.dart';

class BaseClientClass {
  static const int TIME_OUT_DURATION = 30;

  static Future<dynamic> get(String url, String params) async {
    print('url: ${url + params}');
    http.Response response;
    try {
      response = await http.get(
        Uri.parse(url + params),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer ${SessionController().user.bearerToken}',
        },
      ).timeout(const Duration(seconds: TIME_OUT_DURATION));

      printResponse(response);
      return handleResponse(response);
    } on SocketException {
      print('No internet connection');
      return 'No internet connection';
    } on TimeoutException {
      print('Connection timed out');
      return 'Connection timed out';
    }
  }

  static Future<dynamic> post(
    String url,
    data,
  ) async {
    print('Url: $url');
    print(data);
    http.Response response;
    try {
      response = await http
          .post(
            Uri.parse(url),
            body: json.encode(data),
            headers: {
              "Content-Type": "application/json",
              // 'Authorization': appStore.TOKEN,
              'Authorization': 'Bearer ${SessionController().user.bearerToken}',
            },
            encoding: Encoding.getByName('utf-8'),
          )
          .timeout(const Duration(seconds: TIME_OUT_DURATION));

      print("Authorization Bearer is ${SessionController().user.bearerToken}");

      printResponse(response);
      return handleResponse(response);
    } on SocketException {
      print('No internet connection');
      return 'No internet connection';
    } on TimeoutException {
      print('Connection timed out');
      return 'Connection timed out';
    }
  }

  static Future<dynamic> put(String url, data) async {
    print('Url: $url');
    print(data);
    http.Response response;
    try {
      response = await http
          .put(
            Uri.parse(url),
            body: json.encode(data),
            headers: {
              "Content-Type": "application/json",
              'Authorization': 'Bearer ${SessionController().user.bearerToken}',
              // 'Authorization': appStore.TOKEN, // Include your authorization token here
              // 'Authorization': 'Bearer ${SessionController().token}',
            },
            encoding: Encoding.getByName('utf-8'),
          )
          .timeout(const Duration(seconds: TIME_OUT_DURATION));
      printResponse(response);
      return handleResponse(response);
    } on SocketException {
      print('No internet connection');
      return 'No internet connection';
    } on TimeoutException {
      print('Connection timed out');
      return 'Connection timed out';
    } on http.ClientException catch (e) {
      print('HTTP Client Exception: $e');
      return 'Network error';
    }
  }

  static Future<dynamic> delete(String url) async {
    print('Url: $url');
    http.Response response;
    try {
      response = await http.delete(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer ${SessionController().user.bearerToken}',
          // 'Authorization': appStore.TOKEN, // Include your authorization token here
        },
      ).timeout(const Duration(seconds: TIME_OUT_DURATION));
      printResponse(response);
      return handleResponse(response);
    } on SocketException {
      print('No internet connection');
      return 'No internet connection';
    } on TimeoutException {
      print('Connection timed out');
      return 'Connection timed out';
    } on http.ClientException catch (e) {
      print('HTTP Client Exception: $e');
      return 'Network error';
    }
  }

  static void printResponse(http.Response response) {
    print('######################### START ############################');
    print('Got response');
    print('Status Code: ${response.statusCode}');
    print('Body: ${response.body}');
  }

  static dynamic handleResponse(http.Response response) {
    final decodedBody = jsonDecode(response.body);
    switch (response.statusCode) {
      case 200:
        return response;
      case 400:
        return 'Bad Request';
      case 401:
        return decodedBody['message'] ?? response;

      case 404:
        return 'Not Found';
      case 500:
        return 'Internal Server Error';

      case 403:
        return response;
      default:
        return 'Unknown Error';
    }
  }
}
