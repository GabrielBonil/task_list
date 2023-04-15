import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'views/app.dart';

// Your web app's Firebase configuration
const firebaseConfig = FirebaseOptions(
  apiKey: "AIzaSyBYgHut8iFtcMxKggqGFAKhyTWIR7dFBFA",
  authDomain: "task-list-d5aba.firebaseapp.com",
  projectId: "task-list-d5aba",
  storageBucket: "task-list-d5aba.appspot.com",
  messagingSenderId: "1085089650479",
  appId: "1:1085089650479:web:6b585f08d673ed04ff73da"
);

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: firebaseConfig);

  runApp(App());
}

