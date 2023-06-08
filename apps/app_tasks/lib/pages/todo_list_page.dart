import 'package:flutter/material.dart';

class TodoListPage extends StatelessWidget {
  const TodoListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(30),
          child: TextField(
            decoration: InputDecoration(
              labelText: 'Nova Tarefa',
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ),
    );
  }
}
