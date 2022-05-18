import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:family_budget/Server/request_exception.dart';
import 'package:family_budget/Server/sever_config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:family_budget/extansions/snack_bar_utils.dart';

class HttpUtils {
  static get noConnection => 'Отсутствует подключение к серверу';
  static get httpError => 'Не удалось обработать запрос';

  static Future<http.Response> get(String path,
      {Map<String, dynamic>? params}) async {
    http.Response response = await http.get(
      Uri.http(ServerConfig.link, path, params),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    ).timeout(const Duration(seconds: 3));

    if (response.statusCode == 201) {
      return response;
    } else {
      throw RequestException(response.statusCode, response.body);
    }
  }

  static Future<http.Response> post(String path,
      {Map<String, dynamic>? params}) async {
    http.Response response = await http
        .post(
          Uri.http(ServerConfig.link, path),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode(params),
        )
        .timeout(const Duration(seconds: 3));

    if (response.statusCode == 200) {
      return response;
    } else {
      throw RequestException(response.statusCode, response.body);
    }
  }
}
