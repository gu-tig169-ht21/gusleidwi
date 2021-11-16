import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const title = 'TIG169 TODO:';
    return MaterialApp(
      title: title,
      theme: ThemeData(fontFamily: 'RobotoCondensed'),
      home: Scaffold(
        appBar: AppBar(
          leading: const Icon(
            Icons.account_box_rounded,
            size: 35,
          ),
          title: const Text(
            title,
            style: TextStyle(fontSize: 30),
          ),
          backgroundColor: Colors.deepPurple,
        ),
        body: ListView(
          children: const <Widget>[
            ListTile(
                title: Text(
                  'Träna',
                  style: TextStyle(fontSize: 30),
                ),
                leading: Icon(
                  Icons.check,
                  size: 35,
                )),
            ListTile(
                leading: Icon(
                  Icons.check,
                  size: 35,
                ),
                title: Text(
                  'Plugga',
                  style: TextStyle(fontSize: 30),
                )),
            ListTile(
                title: Text(
                  'Städa',
                  style: TextStyle(fontSize: 30),
                ),
                leading: Icon(
                  Icons.check,
                  size: 35,
                )),
            ListTile(
                title: Text(
                  'Slå hål i väggen',
                  style: TextStyle(fontSize: 30),
                ),
                leading: Icon(
                  Icons.check,
                  size: 35,
                )),
          ],
        ),
        floatingActionButton: FloatingActionButton(
            elevation: 0.0,
            child: const Icon(Icons.add_sharp),
            backgroundColor: Colors.deepPurple,
            onPressed: () {}),
      ),
    );
  }
}

class MyWidget extends StatelessWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: NetworkImage(
                "https://www.teahub.io/photos/full/8-87200_android-app-background-white.jpg%22")),
      ),
    );
  }
}
