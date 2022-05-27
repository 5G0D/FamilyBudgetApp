import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:family_budget/Extansions/snack_bar_utils.dart';
import 'package:family_budget/Server/request_exception.dart';
import 'package:family_budget/Server/sever_config.dart';
import 'package:family_budget/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../Dialogs/loading_dialog.dart';

class HttpUtils {
  static get noConnection => 'Отсутствует подключение к серверу';
  static get httpError => 'Не удалось обработать запрос';
  static get timeout => 10;

  static Future<http.Response?> get(String path,
      {Map<String, dynamic>? params, BuildContext? context}) async {
    http.Response? response;

    if (context != null) {
      loadingDialog(context);
    }

    try {
      response = await http.get(
        Uri.http(ServerConfig.link, path, params),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ' + (User.params.auth_code ?? '')
        },
      ).timeout(Duration(seconds: timeout));
      if (response.statusCode != 200) {
        if (context != null) {
          if (response?.statusCode == 401) {
            SnackBarUtils.Show(context, 'Пользователь не авторизирован');
          } else {
            SnackBarUtils.Show(
                context,
                jsonDecode(response!.body)['message'].isNotEmpty
                    ? jsonDecode(response!.body)['message']
                    : HttpUtils.httpError);
          }
        }

        response = null;
      }
    } on SocketException catch (_) {
      if (context != null) {
        SnackBarUtils.Show(context, HttpUtils.noConnection);
      }
    } on TimeoutException catch (e) {
      if (context != null) {
        SnackBarUtils.Show(context, HttpUtils.noConnection);
      }
    }

    if (context != null) {
      Navigator.pop(context);
    }

    return response;
  }

  static Future<http.Response?> post(String path,
      {Map<String, dynamic>? params, BuildContext? context}) async {
    http.Response? response;

    if (context != null) {
      loadingDialog(context);
    }

    try {
      response = await http
          .post(
            Uri.http(ServerConfig.link, path),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'Authorization': 'Bearer ' + (User.params.auth_code ?? '')
            },
            body: json.encode(params),
          )
          .timeout(Duration(seconds: timeout));

      if (response.statusCode != 200) {
        if (context != null) {
          if (response?.statusCode == 401) {
            SnackBarUtils.Show(context, 'Пользователь не авторизирован');
          } else {
            SnackBarUtils.Show(
                context,
                jsonDecode(response!.body)['message'].isNotEmpty
                    ? jsonDecode(response!.body)['message']
                    : HttpUtils.httpError);
          }
        }

        response = null;
      }
    } on SocketException catch (_) {
      if (context != null) {
        SnackBarUtils.Show(context, HttpUtils.noConnection);
      }
    } on TimeoutException catch (e) {
      if (context != null) {
        SnackBarUtils.Show(context, HttpUtils.noConnection);
      }
    }

    if (context != null) {
      Navigator.pop(context);
    }

    return response;
  }
}
