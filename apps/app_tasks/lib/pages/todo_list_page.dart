import 'package:app_tasks/models/todo.dart';
import 'package:app_tasks/widgets/todo_list_item.dart';
import 'package:flutter/material.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({Key? key}) : super(key: key);

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final TextEditingController _taskController = TextEditingController();

  List<Todo> tasks = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minhas Tarefas'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Expanded(
                  flex: 4,
                  child: TextField(
                    controller: _taskController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Tarefa',
                      hintText: 'Ex. Nova tarefa',
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(16.5),
                    ),
                    onPressed: () {
                      setState(() {
                        Todo todo = Todo(
                          title: _taskController.text,
                          date: DateTime.now(),
                        );
                        tasks.add(todo);
                      });
                    },
                    child: const Icon(
                      Icons.add,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: [
                  for (Todo task in tasks)
                    TodoListItem(
                      todo: task,
                    ),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Text('Você possui ${tasks.length} tarefas pendentes'),
                ),
                const SizedBox(
                  width: 8,
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      tasks.clear();
                    });
                  },
                  child: const Text('Limpar Tudo'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
