import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo_provider/model/models.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class TodoProvider extends ChangeNotifier {
  late Box data = Hive.box('todo');
  late Box theme = Hive.box('theme');

  List<TodoModel> todos = [];
  List<TodoModel> get getTodo => todos;

//add
  void create(String todo) {
    data.add(TodoModel(text: todo, isChecked: false));
    notifyListeners();
  }

  //remove
  void remove(int index) {
    data.deleteAt(index);
    notifyListeners();
  }

//update
  void update(String todo, int index) {
    data.putAt(index, TodoModel(text: todo));
    notifyListeners();
  }
}
