import 'package:flutter/material.dart';
import 'package:logisena/src/bloc/provider.dart';
import 'package:logisena/src/pages/home_page.dart';
import 'package:logisena/src/pages/login_page.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      child: MaterialApp(
        title: 'Logisena Transportes',
        initialRoute: 'login',
        routes: {
          'login' : ( BuildContext context ) => LoginPage(),
          'home'  : ( BuildContext context ) => HomePage()
        },
      )
    );
  }
}