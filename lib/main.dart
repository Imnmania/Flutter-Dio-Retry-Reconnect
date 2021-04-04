import 'package:flutter/material.dart';
import 'package:flutter_dio_interceptor/views/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DIO Interceptor',
      home: HomePage(),
    );
  }
}
