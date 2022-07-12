import 'dart:async';
import 'dart:convert';

import 'package:family_budget/Server/Response/room_response.dart';
import 'package:family_budget/Server/http_utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RoomController {
  static Future<RoomResponse?> create(String name, String photo, {BuildContext? context}) async {
    Map<String, dynamic> params = {
      'name': name,
      'photo': photo,
    };

    http.Response? response =
        await HttpUtils.post('/api/room/create', params: params, context: context);
    if (response != null) {
      return RoomResponse.fromJson(jsonDecode(response.body));
    }

    return null;
  }

  static Future<bool> update(int id, String name, String photo, {BuildContext? context}) async {
    Map<String, dynamic> params = {
      'id': id,
      'name': name,
      'photo': photo,
    };

    http.Response? response =
    await HttpUtils.post('/api/room/update', params: params, context: context);
    if (response != null) {
      return true;
    }

    return false;
  }

  static Future<bool> deleteUserFromRoom(int userId, int roomId,
      {BuildContext? context}) async {
    Map<String, dynamic> params = {
      'userId': userId,
      'roomId': roomId,
    };

    http.Response? response =
        await HttpUtils.post('/api/room/deleteUserFromRoom', params: params, context: context);
    if (response != null) {
      return true;
    }

    return false;
  }

  static Future<bool> addUserToRoom(int userId, int roomId,
      {BuildContext? context}) async {
    Map<String, dynamic> params = {
      'userId': userId,
      'roomId': roomId,
    };

    http.Response? response =
    await HttpUtils.post('/api/room/addUserToRoom', params: params, context: context);
    if (response != null) {
      return true;
    }

    return false;
  }

  static Future<RoomResponse?> getRoomByInviteCode(String inviteCode,
      {BuildContext? context}) async {
    Map<String, dynamic> params = {
      'inviteCode': inviteCode,
    };

    http.Response? response =
    await HttpUtils.get('/api/room/getRoomByInviteCode', params: params, context: context);
    if (response != null) {
      return RoomResponse.fromJson(jsonDecode(response.body));
    }

    return null;
  }

  static Future<RoomResponse?> getRoom(int id,
      {BuildContext? context}) async {
    Map<String, dynamic> params = {
      'id': id.toString(),
    };

    http.Response? response =
    await HttpUtils.get('/api/room/getRoom', params: params, context: context);
    if (response != null) {
      return RoomResponse.fromJson(jsonDecode(response.body));
    }

    return null;
  }
}
