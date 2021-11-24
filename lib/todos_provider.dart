import 'package:flutter/cupertino.dart';
import 'package:my_first_app/todo.dart';

class TodosProvider extends ChangeNotifier {
  final List<Todos> _name = [];
  String _filterBy = 'all';
  List<Todos> get getName {
    return _name;
  }

  String get filterBy => _filterBy;

  void setFilterBy(String filterBy) {
    this._filterBy = filterBy;
    notifyListeners();
  }

  void updateAll(bool check) {
    for (var a in _name) {
      a.checked = check;
    }
    notifyListeners();
  }

  void addTodo(String name, bool checked) {
    Todos todo = Todos(name, checked);

    _name.add(todo);

    notifyListeners();
  }

  void removeTodo(Todos todo) {
    _name.remove(todo);
  }

  bool checkAllMarked() {
    bool value = false;
    if (_name.every((element) => element.checked == false)) {
      value = false;
    }
    if (_name.every((element) => element.checked == true)) {
      value = true;
    }
    return value;
  }
}
