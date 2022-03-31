import 'package:flutter/material.dart';

class Pokemon {
  String? number;
  String? name;
  String? monType;
  String? thumbnail;
  List? monTypeList = [];

  // Initializer list sets instance variables before the constructor body run
  Pokemon.fromMap(Map<String, dynamic> map) // "initializer list" 기법
      : number = map['number'],
        name = map['name'],
        monType = map['mon_type'],
        thumbnail = map['thumbnail'];

  Pokemon.fromJson(Map<String, dynamic> json)
      : number = json['number'],
        name = json['name'],
        monType = json['mon_type'],
        thumbnail = json['thumbnail'] {
    monTypeList = monType == null ? [] : monType!.split('/');
  }
}
