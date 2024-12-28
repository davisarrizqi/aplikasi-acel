import 'package:flutter/material.dart';
import 'pages/login.dart';
import 'pages/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isLoggedIn = false;

  // Fungsi login untuk mengatur status login menjadi true
  void _login() {
    setState(() {
      _isLoggedIn = true;
    });
  }

  // Fungsi logout untuk mengatur status login menjadi false
  void _logout() {
    setState(() {
      _isLoggedIn = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: _isLoggedIn
          ? HomePage(onLogout: _logout)  // HomePage dipanggil dengan parameter onLogout
          : LoginPage(onLogin: _login),
    );
  }
}
