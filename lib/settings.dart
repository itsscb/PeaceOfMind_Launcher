// ignore_for_file: non_constant_identifier_names

import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';

class Settings extends SettingsDB{
  int id = 0;
  int primarySwatch = Colors.red.value;
  int scaffoldBackgroundColor = Colors.black.value;
  int textColor = Colors.white.value;
  int primaryColor = Colors.white.value;
  String buttonPosition = 'left';
  late SettingsDB _database;

  Settings({
    required this.primaryColor,
    required this.primarySwatch,
    required this.scaffoldBackgroundColor,
    required this.textColor,
    required this.buttonPosition,
  }) {
    initDB;
  }

  void initDB() {
    _database = SettingsDB();
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map['id'] = id;
    map['scaffoldBackgroundColor'] = scaffoldBackgroundColor;
    map['textColor'] = textColor;
    map['primaryColor'] = primaryColor;
    map['buttonPosition'] = buttonPosition;

    return map;
  }
}

class SettingsDB {
  // SettingsDB();
  late Database database;

  Future<Database> initDatabase() async {
    database = await openDatabase(
      join(await getDatabasesPath(), 'settings.db'),
      onCreate: ((db, version) {
        return db.execute('CREATE TABLE settings('
            'id INTEGER PRIMARY KEY,'
            'primarySwatch INTEGER,'
            'scaffoldBackgroundColor INTEGER,'
            'textColor INTEGER,'
            'primaryColor INTEGER,'
            'buttonPosition TEXT'
            ')');
      }),
      version: 1,
    );

    return database;
  }

  Future<Database> getDatabaseConnect() async {
    // ignore: unnecessary_null_comparison
    if (database != null) {
      return database;
    } else {
      return await initDatabase();
    }
  }

  void defaultSettings() {
    Settings settings = Settings(
        primaryColor: Colors.white.value,
        primarySwatch: Colors.red.value,
        textColor: Colors.white.value,
        scaffoldBackgroundColor: Colors.black.value,
        buttonPosition: 'left',
      );

    insertSettings(settings);
  }

  Future<Settings> getSettings() async {
    final Database db = await getDatabaseConnect();

    if (Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM settings'))! <= 0) {
      defaultSettings();
    }

    final List<Map<String, dynamic>> maps = await db.query('settings');

    List<Settings> settingsList = List.generate(maps.length, (i) {
      return Settings(
        primaryColor: maps[i]['primaryColor'],
        textColor: maps[i]['textColor'],
        primarySwatch: maps[i]['primarySwatch'],
        scaffoldBackgroundColor: maps[i]['scaffoldBackgroundcolor'],
        buttonPosition: maps[i]['buttonPosition'],
      );
    });

    if (settingsList.isEmpty) {
      Settings settings = Settings(
        primaryColor: Colors.white.value,
        primarySwatch: Colors.red.value,
        textColor: Colors.white.value,
        scaffoldBackgroundColor: Colors.black.value,
        buttonPosition: 'left',
      );
      settingsList = List.generate(
        1,
        (i) {
          return settings;
        },
      );
      await insertSettings(settings);
    }
    return settingsList[0];
  }

  Future<void> insertSettings(Settings settings) async {
    final db = await getDatabaseConnect();
    await db.insert(
      'settings',
      settings.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateSettings(Settings settings) async {
    final Database db = await getDatabaseConnect();

    await db.update(
      'settings',
      settings.toMap(),
      where: 'id = ?',
      whereArgs: [settings.id],
    );
  }

  Future<void> deleteSettings(int id) async {
    final db = await getDatabaseConnect();
    await db.delete(
      'settings',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
