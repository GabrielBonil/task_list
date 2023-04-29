import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class TaskListPage extends StatefulWidget {
  @override
  State<TaskListPage> createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  void update(String id, bool finished) {
    firestore.collection('tasks').doc(id).update({'finished': finished});
  }

  void delete(String id) {
    firestore.collection('tasks').doc(id).delete();
  }

  final ordenar = ['name', 'priorityIndex', 'date'];
  var ordenarDropdown;
  var ordenarSeta = false;
  var pesquisar;

  @override
  void initState() {
    ordenarDropdown = ordenar[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tasks"),
        actions: [
          //Botão Dropdown que organiza como vai ser ordenado os itens
          DropdownButton(
            focusColor: Colors.transparent,
            underline: const SizedBox.shrink(),
            value: ordenarDropdown,
            items: ordenar.map((e) {
              return DropdownMenuItem<String>(
                value: e,
                child: Text(e),
              );
            }).toList(),
            onChanged: (newValue) {
              setState(() {
                ordenarDropdown = newValue;
              });
            },
          ),

          //Seta que inverte a ordem da organização dos itens (ascending and descending)
          IconButton(
            onPressed: () {
              setState(() {
                ordenarSeta = !ordenarSeta;
              });
            },
            icon: Icon(ordenarSeta ? Icons.arrow_upward : Icons.arrow_downward),
          ),

          //Pesquisa
          Container(
            width: 200,
            child: TextField(
              decoration: InputDecoration(
                // labelText: 'Pesquisa',
                hintText: 'Pesquisar',
                border: InputBorder.none,
              ),
              onChanged: (value) => pesquisar = value,
            ),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: firestore
            .collection('tasks')
            //.where('finished', isEqualTo: 'false')
            .orderBy(ordenarDropdown, descending: ordenarSeta)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator(); //bolinha que fica girando
          }

          var tasks = snapshot.data!.docs;

          return ListView(
            children: tasks
                .map(
                  (task) => Dismissible(
                    background: Container(
                      color: Colors.red,
                    ),
                    key: Key(task.id),
                    direction: DismissDirection.startToEnd,
                    onDismissed: (_) => delete(task.id),
                    child: CheckboxListTile(
                      title: Text(task['name']),
                      // secondary: Icon(Icons.description),
                      value: task['finished'],
                      subtitle: Row(
                        children: [
                          Expanded(
                            child: Text(
                              task['description'],
                            ),
                          ),
                          Expanded(
                            child: Text(
                              DateFormat('dd/MM/yyyy')
                                  .format(task['date'].toDate()),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ],
                      ),
                      onChanged: (value) => update(task.id, value!),
                    ),
                  ),
                )
                .toList(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pushNamed('/task-create'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
