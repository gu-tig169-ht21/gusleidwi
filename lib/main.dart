import 'package:flutter/material.dart';

void main() => runApp(TodoApp());

class Todo {
  Todo({required this.name, required this.checked});
  final String name;
  bool checked;
}

class TodoItem extends StatelessWidget {
  TodoItem({
    required this.todo,
    required this.onTodoChanged,
  }) : super(key: ObjectKey(todo));

  final Todo todo;
  final onTodoChanged;

  TextStyle? _getTextStyle(bool checked) {
    if (!checked) return null;

    return TextStyle(
      color: Colors.black45,
      decoration: TextDecoration.lineThrough,
    );
  }

  bool _checked = false;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: CheckboxListTile(
      title: Text(todo.name, style: _getTextStyle(todo.checked)),
      value: _checked,
      onChanged: (newValue) {
        onTodoChanged(todo);
        setState(() {
          _checked = newValue!;
        });
      },
      controlAffinity: ListTileControlAffinity.trailing,
    ));
  }

  void setState(Null Function() param0) {}
}

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  final TextEditingController _textFieldController = TextEditingController();
  final List<Todo> _todos = <Todo>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TIG169 TODO:'),
        backgroundColor: Colors.orange,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        children: _todos.map((Todo todo) {
          return TodoItem(
            todo: todo,
            onTodoChanged: _handleTodoChange,
          );
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => _displayDialog(),
          tooltip: 'Lägg till föremål',
          backgroundColor: Colors.orange,
          child: Icon(Icons.add)),
    );
  }

  void _handleTodoChange(Todo todo) {
    setState(() {
      todo.checked = !todo.checked;
    });
  }

  void _addTodoItem(String name) {
    setState(() {
      _todos.add(Todo(name: name, checked: false));
    });
    _textFieldController.clear();
  }

  Future<void> _displayDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Lägg till ett nytt föremål i listan'),
          content: TextField(
            controller: _textFieldController,
            decoration: const InputDecoration(hintText: 'Vad vill du göra?'),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Avbryt'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Lägg till'),
              onPressed: () {
                Navigator.of(context).pop();
                _addTodoItem(_textFieldController.text);
              },
            )
          ],
        );
      },
    );
  }
}

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TIG169 TODO:',
      home: TodoList(),
    );
  }
}
