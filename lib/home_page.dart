import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List _toDoList = [];
  final _taskController = TextEditingController();

  void _addTask() {
    Map<String, dynamic> newTask = Map();
    newTask["title"] = _taskController.text;
    newTask["ok"] = false;
    _taskController.clear();
    setState(() {
      _toDoList.add(newTask);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
    );
  }

  _appBar() {
    return AppBar(
      title: const Text("Tarefas"),
      centerTitle: true,
    );
  }

  _body() {
    return Column(
      children: [
        _row(),
        _listView(),
      ],
    );
  }

  _row() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _taskController,
              decoration: const InputDecoration(
                labelText: "Nova Tarefa",
              ),
            ),
          ),
          ElevatedButton(
            onPressed: _addTask,
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }

  _listView() {
    return Expanded(
      child: ListView.builder(
        itemCount: _toDoList.length,
        itemBuilder: (context, index) {
          return CheckboxListTile(
            onChanged: (value) {
              setState(() {
                _toDoList[index]["ok"] = value;
              });
            },
            title: Text(_toDoList[index]["title"]),
            value: _toDoList[index]["ok"],
            secondary: CircleAvatar(
              child: Icon(_toDoList[index]["ok"] ? Icons.check : Icons.error),
            ),
          );
        },
      ),
    );
  }
}
