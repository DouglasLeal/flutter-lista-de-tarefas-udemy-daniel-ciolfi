import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List _toDoList = [];

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
        Container(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Row(
            children: [
              const Expanded(
                child: TextField(),
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Icon(Icons.add),
              ),
            ],
          ),
        )
      ],
    );
  }
}
