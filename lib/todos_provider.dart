import 'package:flutter/cupertino.dart';
import 'package:my_first_app/todos.dart';
import 'package:my_first_app/response_provider.dart';
import 'dart:convert';

class TodosProvider extends ChangeNotifier {
  List<Todos> _name = [];
  String _filterBy = 'all';
  final String _key = '661e354a-f26a-4a04-b181-c59b3adb95dc';
  String get key => _key;
  List<Todos> get list => _name;

  Future getName() async {
    List<Todos> list = await ResponseProvider().fetchTodos(key);
    _name = list;
    notifyListeners();
  }

  String get filterBy => _filterBy;

  void addTodo(String title, bool done) async {
    Map data = {
      'title': title,
      'done': done,
    };
    var body = jsonEncode(data);
    List<Todos> list = await ResponseProvider().addTodo(body, key);
    _name = list;

    notifyListeners();
  }

  void updateTodo(Todos todo, bool done) async {
    Map data = {
      'id': todo.id,
      'title': todo.title,
      'done': done,
    };
    var body = jsonEncode(data);
    List<Todos> list = await ResponseProvider().updateTodo(body, todo.id, key);
    _name = list;

    notifyListeners();
  }

  void removeTodo(Todos todo) async {
    List<Todos> list = await ResponseProvider().removeTodo(todo.id, key);
    _name = list;

    notifyListeners();
  }

  void setFilterBy(String filterBy) {
    _filterBy = filterBy;
    notifyListeners();
  }
}
