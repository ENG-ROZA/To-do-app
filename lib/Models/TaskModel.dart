import 'package:flutter/material.dart';

  class TaskModel {
  String id;
  String title;
  String description;
  int data;
  bool isDone;
  String userId;

  TaskModel(
      {this.id = '',
      required this.title,
      required this.description,
      this.isDone = false,
      required this.userId,
      required this.data});
  //^^
  TaskModel.fromJson(Map<String, dynamic> json) //Named Constructor Method .
      : //json is map name
        this(
          id: json['id'],
          title: json['title'],
          description: json['description'],
          data: json['data'],
          userId: json['userId'],
          isDone: json['isDone'],
        ); //two functions created to convert from map to Taskmodel direct .
  Map<String, dynamic> tojson() {
    //ToJson Function .
    return {
      'description': description,
      'title': title,
      'data': data,
      'id': id,
      'isDone': isDone,
      'userId': userId,
    };
    //^^
  }
}
