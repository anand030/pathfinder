import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'api_status.dart';

class ApiBaseHelper {
  final String _baseUrl = 'http://51.143.15.47:9789/';

  Future<Object> get(
      {required String endpoint, required Map<String, String> headers}) async {
    try {
      String url = _baseUrl + endpoint;
      var uri = Uri.parse(url);
      var response = await http.get(uri, headers: headers);
      debugPrint('url $url');
      debugPrint('status code ${response.statusCode}');
      debugPrint('response ${response.body}');
      return processResponse(response);
    } on SocketException {
      return Failure(code: 0, errorResponse: 'No Internet');
    }
  }

  Future<Object> post({
    required String endpoint,
    required Map body,
    required Map<String, String> headers,
  }) async {
    try {
      String url = _baseUrl + endpoint;
      var uri = Uri.parse(url);
      var response =
          await http.post(uri, body: jsonEncode(body), headers: headers);
      debugPrint('url $url');
      debugPrint('body $body');
      debugPrint('status code ${response.statusCode}');
      debugPrint('response ${response.body}');
      return processResponse(response);
    } on SocketException {
      return Failure(code: 0, errorResponse: 'No Internet');
    }
  }

  Future<Object> put(
      {required String url, required Map<String, dynamic> body}) async {
    try {
      var uri = Uri.parse(url);
      var response = await http.put(uri, body: body);
      debugPrint('url $url');
      debugPrint('body $body');
      debugPrint('status code ${response.statusCode}');
      return processResponse(response);
    } on SocketException {
      return Failure(code: 0, errorResponse: 'No Internet');
    }
  }

//Client-Side Status Codes
// 404 Not Found
// 401 Unauthorized
// 403 Forbidden
// 400 Bad Request
// 429 Too Many Requests

// Server-Side Status Codes
// 500 Internal Server Error
// 502 Bad Gateway
// 503 Service Unavailable
// 504 Gateway Timed Out
// 501 Not Implemented

  Object processResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return Success(code: 200, response: response.body);
      case 201:
        return Success(code: 200, response: response.body);
      case 400:
        return Failure(code: 401, errorResponse: 'Bad Request');
      case 401:
        return Failure(code: 401, errorResponse: 'Unauthorized');
      case 403:
        return Failure(code: 403, errorResponse: 'Forbidden');
      case 404:
        return Failure(code: 404, errorResponse: 'Page Not found');
      case 429:
        return Failure(code: 429, errorResponse: 'Too many requests');
      case 500:
        return Failure(code: 500, errorResponse: 'Internal Server Error');
      case 501:
        return Failure(code: 501, errorResponse: 'Not Implemented Error');
      case 502:
        return Failure(code: 502, errorResponse: 'Bad Gateway');
      case 503:
        return Failure(code: 503, errorResponse: 'Service Unavailable');
      case 504:
        return Failure(code: 504, errorResponse: 'Gateway Time out');
      default:
        return Failure(code: 600, errorResponse: 'Something went wrong');
    }
  }
}
