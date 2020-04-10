import 'package:coronavirusstatus/pages/about.dart';
import 'package:coronavirusstatus/pages/graphs.dart';
import 'package:coronavirusstatus/pages/helpful_links.dart';
import 'package:coronavirusstatus/pages/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'pages/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.blue,
        textTheme: TextTheme(
          bodyText2: TextStyle(
            fontSize: 18,
          ),
          caption: TextStyle(
            color: Colors.black,
          ),
          headline4: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.teal,
        textTheme: TextTheme(
            bodyText2: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
            caption: TextStyle(
              color: Colors.white,
            ),
            headline4: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            subtitle1: TextStyle(
              fontWeight: FontWeight.bold,
            )),
      ),
      routes: {
        '/home': (context) => Home(),
        '/states': (context) => States(),
        '/graphs': (context) => Graphs(),
        '/help': (context) => HelpfulLinks(),
        '/about': (context) => About(),
      },
      initialRoute: '/home',
    );
  }
}
