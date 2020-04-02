import 'package:coronavirusstatus/pages/graphs.dart';
import 'package:coronavirusstatus/pages/states.dart';
import 'package:flutter/material.dart';
import 'pages/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/home': (context) => Home(),
        '/states': (context) => States(),
        '/graphs': (context) => Graphs(),
      },
      initialRoute: '/home',
    );
  }
}
