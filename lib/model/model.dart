import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:sqfentity/sqfentity.dart';
import 'package:sqfentity_gen/sqfentity_gen.dart';
import 'package:http/http.dart' as http;
part 'model.g.dart';

//flutter pub run build_runner build --delete-conflicting-outputs

@SqfEntityBuilder(familyBudgetModel)
const familyBudgetModel = SqfEntityModel(
    modelName: 'FamilyBudgetModel',
    databaseName: 'FamilyBudgetORM.db',
    databaseTables: [tableUserParams, tableCategory, tableOperation],
    bundledDatabasePath: null
);

const tableUserParams = SqfEntityTable(
  tableName: 'userParams',
  primaryKeyName: 'id',
  primaryKeyType: PrimaryKeyType.integer_auto_incremental,
  fields: [
    SqfEntityField('status', DbType.integer, defaultValue: 1, isNotNull: true),
    SqfEntityField('date_modify', DbType.integer, isNotNull: true),
    SqfEntityField('logged', DbType.bool, defaultValue: false, isNotNull: true),
    SqfEntityField('name', DbType.text, isNotNull: true),
    SqfEntityField('mail', DbType.text),
    SqfEntityField('auth_code', DbType.text),
    SqfEntityField('avatar', DbType.blob, isNotNull: true,)
  ],
);

const tableCategory = SqfEntityTable(
  tableName: 'category',
  primaryKeyName: 'id',
  primaryKeyType: PrimaryKeyType.integer_auto_incremental,
  fields: [
    SqfEntityField('status', DbType.integer, defaultValue: 1, isNotNull: true),
    SqfEntityField('date_modify', DbType.integer, isNotNull: true),
    SqfEntityField('user_id', DbType.integer),
    SqfEntityField('text', DbType.text, isNotNull: true),
    SqfEntityField('icon_code', DbType.integer, isNotNull: true),
    SqfEntityField('icon_color', DbType.integer, isNotNull: true),
    SqfEntityField('block', DbType.integer, isNotNull: true),
    SqfEntityField('position', DbType.integer, isNotNull: true),
    SqfEntityField('type', DbType.integer, isNotNull: true),
  ],
);

const tableOperation = SqfEntityTable(
  tableName: 'operation',
  primaryKeyName: 'id',
  primaryKeyType: PrimaryKeyType.integer_auto_incremental,
  fields: [
    SqfEntityField('status', DbType.integer, defaultValue: 1, isNotNull: true),
    SqfEntityField('date_modify', DbType.integer, isNotNull: true),
    SqfEntityField('type', DbType.integer, isNotNull: true),
    SqfEntityField('user_id', DbType.integer, isNotNull: true),
    SqfEntityField('category_id', DbType.integer, isNotNull: true),
    SqfEntityField('date', DbType.integer, isNotNull: true),
    SqfEntityField('description', DbType.text),
    SqfEntityField('value', DbType.real, isNotNull: true),
  ],
);

