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

  Todo? deletedTodo;
  int? positionDeleted;

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
                      onDelete: onDelete,
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
                  onPressed: showDiologConfirmedALLDeleted,
                  child: const Text('Limpar Tudo'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void onDelete(Todo task) {
    deletedTodo = task;
    positionDeleted = tasks.indexOf(task);

    setState(() {
      tasks.remove(task);
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Tarefa ${task.title} foi excluida!'),
      action: SnackBarAction(
        label: 'Desfazer',
        onPressed: () {
          setState(() {
            tasks.insert(positionDeleted!, deletedTodo!);
          });
        },
      ),
    ));
  }

  void deleteAllTasks(){
    setState(() {
      tasks.clear();
    });
  }

  void showDiologConfirmedALLDeleted() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Confirmação'),
              content: const Text('Se você fizer isto todas as tarefas salvas serão deletadas!'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancelar'),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      deleteAllTasks();
                      Navigator.of(context).pop();
                    });
                  },
                  child: const Text('Apagar tudo',
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ));
  }
}
