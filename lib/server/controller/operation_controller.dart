import 'dart:async';
import 'dart:convert';

import 'package:family_budget/Server/Response/operation_response.dart';
import 'package:family_budget/Server/http_utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class OperationController {
  static Future<OperationResponse?> create(int categoryId, int date, String description, double value, {BuildContext? context}) async {
    Map<String, dynamic> params = {
      'categoryId': categoryId,
      'date': date,
      'description': description,
      'value': value,
    };

    http.Response? response =
    await HttpUtils.post('/api/operation/create', params: params, context: context);

    if (response != null) {
      return OperationResponse.fromJson(jsonDecode(response.body));
    }

    return null;
  }

  static Future<bool> delete (int id, {BuildContext? context}) async {
    Map<String, dynamic> params = {
      'id': id,
    };

    http.Response? response =
    await HttpUtils.post('/api/operation/delete', params: params, context: context);

    if (response != null) {
      return true;
    }

    return false;
  }

  static Future<List<OperationResponse>?> getCategoryOperation(int categoryId, {BuildContext? context}) async {
    Map<String, String> params = {
      'categoryId': categoryId.toString(),
    };

    http.Response? response =
    await HttpUtils.get('/api/operation/getCategoryOperation', params: params, context: context);

    if (response != null) {
      List<OperationResponse> operations = [];
      for (var c in jsonDecode(response.body)["operations"]){
        operations.add(OperationResponse.fromJson(c));
      }
      return operations;
    }
    return null;
  }
}
