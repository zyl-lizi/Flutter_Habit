import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Task {
  final String name;
  final DateTime deadline;
  bool isCompleted;

  Task({required this.name, required this.deadline, this.isCompleted = false});
}

class TaskListItem extends StatelessWidget {
  final Task task;
  final VoidCallback onTap;

  TaskListItem({required this.task, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        value: task.isCompleted,
        onChanged: (bool? value) {
          onTap();
        },
      ),
      title: Text(task.name),
      subtitle: Text(
        DateFormat('yyyy-MM-dd').format(task.deadline),
        style: TextStyle(color: Colors.grey),
      ),
    );
  }
}

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  List<Task> _tasks = [
    Task(name: '完成Flutter作业', deadline: DateTime(2023, 5, 6)),
    Task(name: '提交论文', deadline: DateTime(2023, 5, 9)),
    Task(name: '购买礼物', deadline: DateTime(2023, 5, 10)),
  ];

  void _addTask(String name, DateTime deadline) {
    setState(() {
      _tasks.add(Task(name: name, deadline: deadline));
    });
  }

  void _editTask(int index, String name, DateTime deadline) {
    setState(() {
      _tasks[index] = Task(name: name, deadline: deadline);
    });
  }

  void _deleteTask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
  }

  void _toggleTaskCompletion(int index) {
    setState(() {
      _tasks[index].isCompleted = !_tasks[index].isCompleted;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('待办清单'),
      ),
      body: ListView.builder(
        itemCount: _tasks.length,
        itemBuilder: (context, index) {
          return TaskListItem(
            task: _tasks[index],
            onTap: () => _toggleTaskCompletion(index),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddTaskScreen(
                onSave: (name, deadline) => _addTask(name, deadline),
              ),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class AddTaskScreen extends StatefulWidget {
  final Function(String, DateTime) onSave;

  AddTaskScreen({required this.onSave});

  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  DateTime _deadline = DateTime.now();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('添加任务'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: '任务名称',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '请输入任务名称';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              Text('任务截止日期'),
              SizedBox(height: 8.0),
              InkWell(
                onTap: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: _deadline,
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100),
                  );
                  if (picked != null && picked != _deadline) {
                    setState(() {
                      _deadline = picked;
                    });
                  }
                },
                child: Row(
                  children: <Widget>[
                    Icon(Icons.calendar_today),
                    SizedBox(width: 8.0),
                    Text(DateFormat('yyyy-MM-dd').format(_deadline)),
                  ],
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    widget.onSave(_nameController.text, _deadline);
                    Navigator.pop(context);
                  }
                },
                child: Text('保存'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    title: '待办清单',
    home: TodoList(),
  ));
}