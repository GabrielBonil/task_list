import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TaskListPage extends StatelessWidget {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tasks"),
      ),
      body: StreamBuilder(
        stream: firestore
            .collection('tasks')
            //.where('finished', isEqualTo: 'false')
            .orderBy('name', /*descending: true*/)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator(); //bolinha que fica girando
          }

          var tasks = snapshot.data!.docs;

          return ListView(
            children: tasks
                .map(
                  (task) => CheckboxListTile(
                      title: Text(task['name']),
                      value: task['finished'],
                      onChanged: null),
                )
                .toList(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pushNamed('/task-create'),
        child: Icon(Icons.add),
      ),
    );
  }
}
