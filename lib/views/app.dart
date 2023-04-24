import 'package:flutter/material.dart';
import 'package:task_list/views/task-create.dart';
import 'package:task_list/views/task-list.dart';
import 'package:task_list/views/user-login.dart';

class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // definindo a propriedade para false
      routes: {
        '/task-list': (context) => TaskListPage(),
        '/task-create':(context) => TaskCreatePage(),
        '/user-login':(context) => UserLoginPage(),
      },
      initialRoute: '/task-list',
      // initialRoute: '/task-create',
      // initialRoute: '/user-login',
    );
  }
}