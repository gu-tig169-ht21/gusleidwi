import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:my_first_app/todos_provider.dart';
import 'package:my_first_app/todos.dart';

import 'add_todos.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool checkAll = false;

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Todo List'),
          actions: <Widget>[
            PopupMenuButton<String>(
              onSelected: (value) async {
                setState(() {
                  Provider.of<TodosProvider>(context, listen: false)
                      .setFilterBy(value);
                });
              },
              itemBuilder: (context) => [
                const PopupMenuItem(child: Text('Visa alla'), value: 'alla'),
                const PopupMenuItem(
                    child: Text('Visa ej klara'), value: 'inte'),
                const PopupMenuItem(child: Text('Visa klara'), value: 'klar')
              ],
            )
          ],
        ),
        body: Consumer<TodosProvider>(
          builder: (context, TodosProvider data, child) {
            return ListView(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                children: _filterList(data.list, data.filterBy)!
                    .map((card) => ListTodo(context, card))
                    .toList());
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddTodo(),
                ));
          },
          tooltip: "Lägg till",
          child: const Icon(Icons.add),
        ),
      );
    });
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
            onPressed: () async {
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

class ListTodo extends StatefulWidget {
  final Todos todo;
  BuildContext context;
  ListTodo(this.context, this.todo, {Key? key}) : super(key: key);

  @override
  State<ListTodo> createState() => _ListTodoState();
}

class _ListTodoState extends State<ListTodo> {
  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      return Padding(
        padding: const EdgeInsets.all(2),
        child: CheckboxListTile(
            value: widget.todo.done,
            title: Text(
              widget.todo.title,
              style: (TextStyle(
                decoration:
                    widget.todo.done ? TextDecoration.lineThrough : null,
                color: widget.todo.done ? Colors.black45 : null,
                decorationThickness: 1.5,
              )),
            ),
            secondary: deleteButton(context, widget.todo, widget.todo.title),
            controlAffinity: ListTileControlAffinity.leading,
            activeColor: Colors.orange,
            onChanged: (newvalue) async {
              Provider.of<TodosProvider>(context, listen: false)
                  .updateTodo(widget.todo, newvalue!);
            }),
      );
    });
  }
}

List<Todos>? _filterList(List<Todos> list, filterBy) {
  if (filterBy == 'alla') return list;
  if (filterBy == 'klar') {
    return list.where((_todos) => _todos.done == true).toList();
  }
  if (filterBy == 'inte') {
    return list.where((_todos) => _todos.done == false).toList();
  }
  return list;
}
