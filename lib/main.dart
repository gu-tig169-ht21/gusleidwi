import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:my_first_app/todos_provider.dart';
import 'package:my_first_app/home.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var ip = TodosProvider();
    ip.getName();
    return ChangeNotifierProvider(
      create: (context) => ip,
      child: MaterialApp(
        title: 'Todo List',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.orange,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Home(),
      ),
    );
  }
}
