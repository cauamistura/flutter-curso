import 'package:app_tasks/models/todo.dart';
import 'package:app_tasks/repositories/todo_repository.dart';
import 'package:app_tasks/widgets/todo_list_item.dart';
import 'package:flutter/material.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({Key? key}) : super(key: key);

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final TextEditingController _taskController = TextEditingController();
  final TodoRepository _todoRepository = TodoRepository();

  List<Todo> _tasks = [];

  Todo? _deletedTodo;
  int? _positionDeleted;

  String? _errorText;

  @override
  void initState() {
    _todoRepository.getTodoList().then((value) {
      setState(() {
        _tasks = value;
      });
    });
  }

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
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'Tarefa',
                      hintText: 'Ex. Nova tarefa',
                      errorText: _errorText,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(16.5),
                    ),
                    onPressed: onSaved,
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
                  for (Todo task in _tasks)
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
                  child: Text('Você possui ${_tasks.length} tarefas pendentes'),
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
    _deletedTodo = task;
    _positionDeleted = _tasks.indexOf(task);

    setState(() {
      _tasks.remove(task);
    });
    _todoRepository.saveTodoList(_tasks);

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Tarefa ${task.title} foi excluida!'),
      action: SnackBarAction(
        label: 'Desfazer',
        onPressed: () {
          setState(() {
            _tasks.insert(_positionDeleted!, _deletedTodo!);
          });
          _todoRepository.saveTodoList(_tasks);
        },
      ),
    ));
  }

  void deleteAllTasks() {
    setState(() {
      _tasks.clear();
    });
    _todoRepository.saveTodoList(_tasks);
  }

  void onSaved() {
    if (_taskController.text.isEmpty) {
      setState(() {
        _errorText = 'Preencha sua tarefa!';
      });
      return;
    }

    setState(() {
      Todo todo = Todo(
        title: _taskController.text,
        dateTime: DateTime.now(),
      );
      _tasks.add(todo);
      _errorText = null;
    });
    _todoRepository.saveTodoList(_tasks);
    _taskController.text = '';
  }

  void showDiologConfirmedALLDeleted() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Confirmação'),
              content: const Text(
                  'Se você fizer isto todas as tarefas salvas serão deletadas!'),
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
                  child: const Text(
                    'Apagar tudo',
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ));
  }
}
