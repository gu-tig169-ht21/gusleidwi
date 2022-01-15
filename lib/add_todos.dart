import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:my_first_app/todos_provider.dart';

class AddTodo extends StatefulWidget {
  const AddTodo({Key? key}) : super(key: key);

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  final _controller = TextEditingController();
  bool checkAll = false;

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Vad vill du lägga till?'),
          centerTitle: true,
        ),
        body: Wrap(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
              child: TextFormField(
                onFieldSubmitted: (value) async {
                  Provider.of<TodosProvider>(context, listen: false)
                      .addTodo(_controller.text, false);
                  Navigator.pop(context);
                },
                decoration: InputDecoration(
                  suffix: IconButton(
                    onPressed: _controller.clear,
                    icon: const Icon(Icons.clear),
                  ),
                  border: const UnderlineInputBorder(),
                  hintText: "Lägg till aktivitet",
                ),
                controller: _controller,
              ),
            ),
          ],
        ),
      );
    });
  }
}
