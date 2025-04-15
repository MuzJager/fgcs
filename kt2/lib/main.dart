import 'package:flutter/material.dart';

void main() {
  runApp(TodoApp());
}

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Список дел',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: TodoScreen(),
    );
  }
}

class TodoScreen extends StatefulWidget {
  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final List<TodoItem> _tasks = [];
  final TextEditingController _controller = TextEditingController();
  String _sortCriteria = 'По дате создания'; // Критерий сортировки
  String _filterCriteria = 'Все задачи'; // Критерий фильтрации

  void _addTask(String task) {
    if (task.isNotEmpty) {
      setState(() {
        _tasks.add(TodoItem(text: task, createdAt: DateTime.now()));
        _controller.clear();
      });
    }
  }

  void _toggleTask(int index) {
    setState(() {
      _tasks[index].isCompleted = !_tasks[index].isCompleted;
    });
  }

  void _deleteTask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
  }

  void _editTask(int index, String newText) {
    setState(() {
      _tasks[index].text = newText;
    });
  }

  void _sortTasks() {
    if (_sortCriteria == 'По дате создания') {
      _tasks.sort((a, b) => a.createdAt.compareTo(b.createdAt));
    } else if (_sortCriteria == 'По важности') {
      _tasks.sort((a, b) {
        if (a.isCompleted == b.isCompleted) {
          return a.createdAt.compareTo(b.createdAt);
        }
        return a.isCompleted ? 1 : -1;
      });
    }
  }

  void _filterTasks() {
    if (_filterCriteria == 'Выполненные') {
      _tasks.retainWhere((task) => task.isCompleted);
    } else if (_filterCriteria == 'Невыполненные') {
      _tasks.retainWhere((task) => !task.isCompleted);
    }
  }

  @override
  Widget build(BuildContext context) {
    _sortTasks(); // Сортируем задачи при каждом обновлении
    _filterTasks(); // Фильтруем задачи при каждом обновлении

    return Scaffold(
      appBar: AppBar(title: Text('Список дел')),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(labelText: 'Новая задача'),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () => _addTask(_controller.text),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                DropdownButton<String>(
                  value: _sortCriteria,
                  onChanged: (value) {
                    setState(() {
                      _sortCriteria = value!;
                    });
                  },
                  items:
                      ['По дате создания', 'По важности']
                          .map(
                            (criteria) => DropdownMenuItem<String>(
                              value: criteria,
                              child: Text(criteria),
                            ),
                          )
                          .toList(),
                ),
                SizedBox(width: 8.0),
                DropdownButton<String>(
                  value: _filterCriteria,
                  onChanged: (value) {
                    setState(() {
                      _filterCriteria = value!;
                    });
                  },
                  items:
                      ['Все задачи', 'Выполненные', 'Невыполненные']
                          .map(
                            (criteria) => DropdownMenuItem<String>(
                              value: criteria,
                              child: Text(criteria),
                            ),
                          )
                          .toList(),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _tasks.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    _tasks[index].text,
                    style: TextStyle(
                      decoration:
                          _tasks[index].isCompleted
                              ? TextDecoration.lineThrough
                              : null,
                    ),
                  ),
                  leading: Checkbox(
                    value: _tasks[index].isCompleted,
                    onChanged: (value) => _toggleTask(index),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          TextEditingController editController =
                              TextEditingController(text: _tasks[index].text);
                          showDialog(
                            context: context,
                            builder:
                                (context) => AlertDialog(
                                  title: Text('Редактировать задачу'),
                                  content: TextField(
                                    controller: editController,
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        _editTask(index, editController.text);
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('Сохранить'),
                                    ),
                                  ],
                                ),
                          );
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => _deleteTask(index),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class TodoItem {
  String text;
  bool isCompleted;
  DateTime createdAt;

  TodoItem({
    required this.text,
    this.isCompleted = false,
    required this.createdAt,
  });
}
