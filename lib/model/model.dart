import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:sqfentity/sqfentity.dart';
import 'package:sqfentity_gen/sqfentity_gen.dart';
import 'package:http/http.dart' as http;
part 'model.g.dart';

//flutter pub run build_runner build --delete-conflicting-outputs
//flutter build apk --release --no-tree-shake-icons

@SqfEntityBuilder(familyBudgetModel)
const familyBudgetModel = SqfEntityModel(
    modelName: 'FamilyBudget',
    databaseName: 'FamilyBudget.db',
    databaseTables: [
      tableUserParams,
      tableCategory,
      tableOperation,
      tableSettings,
      tableChat,
      tableRoomMembers,
      tableRoomParams
    ],
    bundledDatabasePath: null);

const tableUserParams = SqfEntityTable(
  tableName: 'userParams',
  primaryKeyName: 'id',
  primaryKeyType: PrimaryKeyType.integer_auto_incremental,
  fields: [
    SqfEntityField('status', DbType.integer, defaultValue: 1, isNotNull: false),
    SqfEntityField('date_modify', DbType.integer, isNotNull: false),
    SqfEntityField('user_id', DbType.integer, isNotNull: false),
    SqfEntityField('name', DbType.text, isNotNull: false),
    SqfEntityField('mail', DbType.text),
    SqfEntityField('auth_code', DbType.text),
    SqfEntityField('avatar', DbType.blob, isNotNull: false),
    SqfEntityField('roomId', DbType.integer, isNotNull: false),
  ],
);

const tableCategory = SqfEntityTable(
  tableName: 'category',
  primaryKeyName: 'id',
  primaryKeyType: PrimaryKeyType.integer_auto_incremental,
  fields: [
    SqfEntityField('status', DbType.integer, defaultValue: 1, isNotNull: false),
    SqfEntityField('date_modify', DbType.integer, isNotNull: false),
    SqfEntityField('category_id', DbType.integer, isNotNull: false),
    SqfEntityField('user_id', DbType.integer, isNotNull: false),
    SqfEntityField('text', DbType.text, isNotNull: false),
    SqfEntityField('icon_code', DbType.integer, isNotNull: false),
    SqfEntityField('icon_color', DbType.integer, isNotNull: false),
    SqfEntityField('block', DbType.integer, isNotNull: false),
    SqfEntityField('position', DbType.integer, isNotNull: false),
    SqfEntityField('type', DbType.integer, isNotNull: false),
  ],
);

const tableOperation = SqfEntityTable(
  tableName: 'operation',
  primaryKeyName: 'id',
  primaryKeyType: PrimaryKeyType.integer_auto_incremental,
  fields: [
    SqfEntityField('status', DbType.integer, defaultValue: 1, isNotNull: false),
    SqfEntityField('date_modify', DbType.integer, isNotNull: false),
    SqfEntityField('user_id', DbType.integer, isNotNull: false),
    SqfEntityField('type', DbType.integer, isNotNull: false),
    SqfEntityField('category_id', DbType.integer, isNotNull: false),
    SqfEntityField('date', DbType.integer, isNotNull: false),
    SqfEntityField('description', DbType.text),
    SqfEntityField('value', DbType.real, isNotNull: false),
  ],
);

const tableRoomParams = SqfEntityTable(
  tableName: 'roomParams',
  primaryKeyName: 'id',
  primaryKeyType: PrimaryKeyType.integer_auto_incremental,
  fields: [
    SqfEntityField('status', DbType.integer, defaultValue: 1, isNotNull: false),
    SqfEntityField('date_modify', DbType.integer, isNotNull: false),
    SqfEntityField('room_id', DbType.integer, isNotNull: false),
    SqfEntityField('name', DbType.text, isNotNull: false),
    SqfEntityField('avatar', DbType.blob, isNotNull: false),
    SqfEntityField('invite_code', DbType.text, isNotNull: false),
  ],
);

const tableRoomMembers = SqfEntityTable(
  tableName: 'roomMembers',
  primaryKeyName: 'id',
  primaryKeyType: PrimaryKeyType.integer_auto_incremental,
  fields: [
    SqfEntityField('status', DbType.integer, defaultValue: 1, isNotNull: false),
    SqfEntityField('date_modify', DbType.integer, isNotNull: false),
    SqfEntityField('room_id', DbType.integer, isNotNull: false),
    SqfEntityField('user_id', DbType.integer, isNotNull: false),
    SqfEntityField('user_name', DbType.text, isNotNull: false),
    SqfEntityField('user_avatar', DbType.blob, isNotNull: false),
    SqfEntityField('user_color', DbType.integer, isNotNull: false),
    SqfEntityField('user_role', DbType.integer, isNotNull: false),
  ],
);

const tableChat = SqfEntityTable(
  tableName: 'chat',
  primaryKeyName: 'id',
  primaryKeyType: PrimaryKeyType.integer_auto_incremental,
  fields: [
    SqfEntityField('status', DbType.integer, defaultValue: 1, isNotNull: false),
    SqfEntityField('date_modify', DbType.integer, isNotNull: false),
    SqfEntityField('room_id', DbType.integer, isNotNull: false),
    SqfEntityField('user_id', DbType.integer, isNotNull: false),
    SqfEntityField('message', DbType.text, isNotNull: false),
    SqfEntityField('date', DbType.integer, isNotNull: false),
    SqfEntityField('message_status', DbType.integer, isNotNull: false, defaultValue: 2),
  ],
);

const tableSettings = SqfEntityTable(
  tableName: 'settings',
  primaryKeyName: 'id',
  primaryKeyType: PrimaryKeyType.integer_auto_incremental,
  fields: [
    SqfEntityField('status', DbType.integer, defaultValue: 1, isNotNull: false),
    SqfEntityField('date_modify', DbType.integer, isNotNull: false),
  ],
);
