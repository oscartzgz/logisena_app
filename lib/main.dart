import 'package:flutter/material.dart';
import 'package:logisena/src/bloc/provider.dart';
import 'package:logisena/src/pages/home_page.dart';
import 'package:logisena/src/pages/login_page.dart';
import 'package:logisena/src/pages/transfer_order_page.dart';
import 'package:logisena/src/providers/sessions_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var initialRoute = 'login';
    final sessionsProvier = SessionsProvider();

    return FutureBuilder(
        future: sessionsProvier.tryJWTLogin(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            // Try to login
            if (snapshot.data == true) initialRoute = 'home';
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Provider(
              child: MaterialApp(
            title: 'Logisena Transportes',
            initialRoute: initialRoute,
            routes: {
              'login': (BuildContext context) => LoginPage(),
              'home': (BuildContext context) => HomePage(),
              'transfer_order': (BuildContext context) => TransferOrderPage(),
            },
          ));
        });
  }
}
