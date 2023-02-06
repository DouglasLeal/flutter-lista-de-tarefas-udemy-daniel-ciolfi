import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lista_tarefas/Services/FilesService.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List _toDoList = [];
  Map<String, dynamic>? _lastRemoved;
  int? _lastRemovedPos;

  final _taskController = TextEditingController();

  void _addTask() {
    Map<String, dynamic> newTask = Map();
    newTask["title"] = _taskController.text;
    newTask["ok"] = false;
    _taskController.clear();
    setState(() {
      _toDoList.add(newTask);
    });

    FilesService.saveData(_toDoList);
  }

  void _removeTask(int index){
    _lastRemoved = Map.from(_toDoList[index]);
    _lastRemovedPos = index;

    setState(() {
      _toDoList.removeAt(index);
    });

    FilesService.saveData(_toDoList);

    final snack = SnackBar(
        content: Text("Tarefa: ${_lastRemoved?["title"]} removida"),
        action: SnackBarAction(label: "Desfazer", onPressed: (){
          setState(() {
            _toDoList.insert(index, _lastRemoved);
          });
          FilesService.saveData(_toDoList);
        }),
      duration: const Duration(seconds: 2),
    );

    ScaffoldMessenger.of(context).showSnackBar(snack);
  }

  @override
  void initState() {
    super.initState();

    FilesService.readData().then((value) {
      setState(() {
        if (value != null) {
          _toDoList = json.decode(value);
        }
      });
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
          return Dismissible(
            onDismissed: (direction){
              _removeTask(index);
            },
            direction: DismissDirection.startToEnd,
            background: Container(
              color: Colors.red,
              child: const Align(
                alignment: Alignment(-0.9, 0),
                child: Icon(Icons.delete_forever, color: Colors.white,),
              ),
            ),
            key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
            child: _checkboxListTile(index),
          );
        },
      ),
    );
  }

  _checkboxListTile(int index) {
    return CheckboxListTile(
      onChanged: (value) {
        setState(() {
          _toDoList[index]["ok"] = value;
          FilesService.saveData(_toDoList);
        });
      },
      title: Text(_toDoList[index]["title"]),
      value: _toDoList[index]["ok"],
      secondary: CircleAvatar(
        child: Icon(_toDoList[index]["ok"] ? Icons.check : Icons.error),
      ),
    );
  }
}
