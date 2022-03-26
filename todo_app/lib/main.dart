import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blue,
        accentColor: Colors.orangeAccent,
      ),
      home: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<String> todos = [];
  String input = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TodApp'),
      ),
      floatingActionButton: buildFloatingActionButton(context),
      body: buildListView(),
    );
  }

  ListView buildListView() {
    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (BuildContext context, int index) {
        return Dismissible(
          onDismissed: (direction){
            todos.removeAt(index);
          },
          key: Key(todos[index]),
          child: Card(
            margin: const EdgeInsets.all(8),
            elevation: 4,
            child: ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              title: Text(todos[index]),
              trailing: IconButton(
                onPressed: () {
                  setState(() {
                    todos.removeAt(index);
                  });
                },
                icon: const Icon(
                  Icons.delete,
                  color: Colors.redAccent,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  FloatingActionButton buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              title: const Text(
                'Add TODO',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              content: TextField(
                onChanged: (String value) {
                  input = value;
                },
              ),
              actions: [
                FlatButton(
                  shape: const Border(
                    top: BorderSide(color: Colors.black12),
                    right: BorderSide(color: Colors.black12),
                    left: BorderSide(color: Colors.black12),
                    bottom: BorderSide(color: Colors.black12),
                  ),
                  onPressed: () {
                    setState(() {
                      todos.add(input);
                    });
                    Navigator.of(context).pop();
                  },
                  child: const Text('Add'),
                ),
              ],
            );
          },
        );
      },
      child: const Icon(
        Icons.add,
        color: Colors.white,
      ),
    );
  }
}
