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
    databaseTables: [tableUserParams],
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
