import 'package:flutter/material.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Logisena Transportes',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Applicacion operadores'),
        ),
        body: Center(
          child: Container(
            child: Text('Hola Mundo!'),
          ),
        ),
      ),
    );
  }
}