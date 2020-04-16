import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(children: <Widget>[
          SizedBox( height: 100.0, width: double.infinity,),
          Text("Home Page for Driver should show:"),
          SizedBox( height: 20.0 ),
          Text("First: Show current assigned Transfer Orders"),
          Text("Second: Show some last monthly Transfer Orders"),
          Text("Third: Way to show page thatdue with "),
          Text("Fourth: Ability to logout"),
          Text("Fifth: Driver can see salary details per TransferOrder"),
          Text("Sixth: Driver can download PDF and store on phone"),
          Text("Seventh: On a future driver can start translate and app can save GPS route, this have us the ability to see in real time the translate")
        ],),
      ),
    );
  }
}