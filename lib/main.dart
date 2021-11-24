import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:my_first_app/todos_provider.dart';

void main() => runApp(TodoApp());

class Todo {
  Todo({required this.name, required this.checked});
  final String name;
  bool checked;
}

class TodoList extends StatefulWidget {
  const TodoList({Key? key}) : super(key: key);

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
        title: const Text('Todo List:'),
        backgroundColor: Colors.orange,
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: (value) {
              setState(() {
                Provider.of<TodosProvider>(context, listen: false)
                    .setFilterBy(value);
              });
            },
            itemBuilder: (context) => [
              const PopupMenuItem(child: Text('Visa alla'), value: 'alla'),
              const PopupMenuItem(child: Text('Visa ej klara'), value: 'inte'),
              const PopupMenuItem(child: Text('Visa klara'), value: 'klar')
            ],
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 6.0),
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
          child: const Icon(Icons.add)),
    );
  }

  List<Todo>? _filterList(List<Todo> list, filterBy) {
    if (filterBy == 'alla') return list;
    if (filterBy == 'klar') {
      return list.where((_todos) => _todos.checked == true).toList();
    }
    if (filterBy == 'inte') {
      return list.where((_todos) => _todos.checked == false).toList();
    }
    return list;
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

Widget deleteButton(BuildContext context, todo, String name) {
  return IconButton(
    icon: const Icon(Icons.delete_outline),
    tooltip: "Delete",
    onPressed: () => showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Varning'),
        content: Text("Är du säker på att du vill radera '$name'?"),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Avbryt'),
          ),
          TextButton(
            onPressed: () {
              Provider.of<TodosProvider>(context, listen: false)
                  .removeTodo(todo);
              Navigator.pop(context);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    ),
  );
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

    return const TextStyle(
      color: Colors.black45,
      decoration: TextDecoration.lineThrough,
    );
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      return Card(
          child: CheckboxListTile(
        title: Text(todo.name, style: _getTextStyle(todo.checked)),
        value: todo.checked,
        secondary: deleteButton(context, todo, todo.name),
        onChanged: (newValue) {
          onTodoChanged(todo);
        },
        controlAffinity: ListTileControlAffinity.leading,
      ));
    });
  }
}

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'TIG169 TODO:',
      home: TodoList(),
    );
  }
}
