import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TodoListScreen(),
    );
  }
}

class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  List<Student> _students = [];

  void _addStudent() {
    String id = "";
    String name = "";
    String groupNumber = "";
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Add a new Student"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) {
                  id = value;
                },
                decoration: InputDecoration(labelText: 'ID'),
              ),
              TextField(
                onChanged: (value) {
                  name = value;
                },
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                onChanged: (value) {
                  groupNumber = value;
                },
                decoration: InputDecoration(labelText: 'Group Number'),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  if (id.isNotEmpty && name.isNotEmpty && groupNumber.isNotEmpty) {
                    _students.add(Student(id: id, name: name, groupNumber: groupNumber));
                  }
                  Navigator.pop(context);
                });
              },
              child: Text("Add"),
            ),
          ],
        );
      },
    );
  }

  void _deleteStudent(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Delete Student"),
          content: Text("Are you sure you want to delete this student?"),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  _students.removeAt(index);
                });
                Navigator.pop(context);
              },
              child: Text("Delete"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel"),
            ),
          ],
        );
      },
    );
  }

  void _editStudent(int index) {
    String id = _students[index].id;
    String name = _students[index].name;
    String groupNumber = _students[index].groupNumber;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Edit Student"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) {
                  id = value;
                },
                controller: TextEditingController()..text = _students[index].id,
                decoration: InputDecoration(labelText: 'ID'),
              ),
              TextField(
                onChanged: (value) {
                  name = value;
                },
                controller: TextEditingController()..text = _students[index].name,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                onChanged: (value) {
                  groupNumber = value;
                },
                controller: TextEditingController()..text = _students[index].groupNumber,
                decoration: InputDecoration(labelText: 'Group Number'),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _students[index].id = id;
                  _students[index].name = name;
                  _students[index].groupNumber = groupNumber;
                });
                Navigator.pop(context);
              },
              child: Text("Save"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Assignment 2"),
        backgroundColor: Colors.purple,
      ),
      body: ListView.builder(
        itemCount: _students.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              "${_students[index].id} - ${_students[index].name} - ${_students[index].groupNumber}",
              style: TextStyle(fontSize: 18),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    _editStudent(index);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    _deleteStudent(index);
                  },
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addStudent,
        backgroundColor: Colors.purple,
        child: Icon(Icons.add),
      ),
    );
  }
}

class Student {
  String id;
  String name;
  String groupNumber;

  Student({required this.id, required this.name, required this.groupNumber});
}