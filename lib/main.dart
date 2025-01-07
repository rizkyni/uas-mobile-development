import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:login/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyBkJ5G3ALzAVTxUi5h3sNPF6UVX7aLjWdE",
      appId: "1:388492511933:android:66ffef4226a73adbaf85d4",
      messagingSenderId: "388492511933",
      projectId: "login-5a808",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const LoginScreen());
  }
}
