import 'dart:async';
import 'dart:convert';

import 'package:family_budget/Server/Response/category_response.dart';
import 'package:family_budget/Server/http_utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CategoryController {
  static Future<List<CategoryResponse>?> getUserCategory(int userId, {BuildContext? context}) async {
    Map<String, String> params = {
      'userId': userId.toString(),
    };

    http.Response? response =
    await HttpUtils.get('/api/category/getUserCategory', params: params, context: context);

    if (response != null) {
      List<CategoryResponse> categories = [];
      for (var c in jsonDecode(response.body)["categories"]){
        categories.add(CategoryResponse.fromJson(c));
      }
      return categories;
    }
    return null;
  }
}
