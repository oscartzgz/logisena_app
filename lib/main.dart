import 'package:flutter/material.dart';
import 'package:logisena/src/pages/splash_page.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Logisena Transportes',
      initialRoute: 'splash',
      routes: {
        'splash' : ( BuildContext context ) => SplashPage()
      },
    );
  }
}