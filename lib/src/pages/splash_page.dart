import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {

  final routeName = 'splash';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 100.0),
          child: Image(
            width: 200.0,
            image: AssetImage('assets/logisena-logo.png'),
          ),
        ),
      ),
    );
  }
}