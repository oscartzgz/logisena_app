import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logisena/src/models/transfer_order_model.dart';
import 'package:logisena/src/providers/transfer_orders_provider.dart';

class HomePage extends StatelessWidget {
  final storage = FlutterSecureStorage();

  final transferOrdersProvider = new TransferOrdersProvider();

  @override
  Widget build(BuildContext context) {
    transferOrdersProvider.getTransferOrders();
    return Scaffold(
      drawer: _menu(),
      appBar: AppBar(
        backgroundColor: Colors.redAccent[400],
        title: Text("Logisena Transportes"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              print('Menu was pressed');
            },
          )
        ],
        // automaticallyImplyLeading: true,
        toolbarOpacity: 0.9,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              // Text("Home Page for Driver should show:"),
              // SizedBox(height: 20.0),
              // Text("First: Show current assigned Transfer Orders"),
              // Text("Second: Show some last monthly Transfer Orders"),
              // Text("Third: Way to show page thatdue with "),
              // Text("Fourth: Ability to logout"),
              // Text("Fifth: Driver can see salary details per TransferOrder"),
              // Text("Sixth: Driver can download PDF and store on phone"),
              // Text(
              //     "Seventh: On a future driver can start translate and app can save GPS route, this have us the ability to see in real time the translate"),
              SizedBox(height: 15),
              Text('Ordenes de Traslado',
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: 20,
                      fontWeight: FontWeight.w900)),
              SizedBox(height: 15),
              _transferOrdersContainer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _menu() {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            child: Text("DrawerHeader"),
            decoration: BoxDecoration(color: Colors.red),
          ),
          ListTile(
            title: Text("Salir"),
            onTap: () {},
          )
        ],
      ),
    );
  }

  _transferOrdersContainer() {
    return FutureBuilder(
      future: transferOrdersProvider.getTransferOrders(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        final transferOrdersList = <Widget>[];
        if (snapshot.hasData) {
          if (snapshot.data.length > 0) {
            snapshot.data.forEach((element) {
              final _transferOrder = _renderTransferOrder(element);
              transferOrdersList.add(_transferOrder);
            });
            return Column(children: transferOrdersList);
          } else {
            return CircularProgressIndicator();
          }
        }
      },
    );

    // return transferOrdersList[0];
  }

  _renderTransferOrder(TransferOrderModel transferOrder) {
    final _styleDir = TextStyle(
        fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black87);
    final _labelData = TextStyle(color: Colors.black54);
    final _labelOk = BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(50)),
      color: Colors.green[400],
    );
    final _labelTextStyle =
        TextStyle(color: Colors.white, fontWeight: FontWeight.bold);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.5),
                blurRadius: 2,
                offset: Offset(1, 1))
          ]),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(transferOrder.attributes.code,
                      style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 20,
                          color: Colors.black87)),
                  Text(
                    transferOrder.attributes.transferredAt.toString(),
                    style: TextStyle(color: Colors.black45),
                  )
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                decoration: _labelOk,
                child: Text(
                  transferOrder.attributes.status,
                  style: _labelTextStyle,
                ),
              )
            ],
          ),
          SizedBox(height: 10),
          Text(
            transferOrder.attributes.originDirectory.name,
            style: _styleDir,
          ),
          Text(
            'Origen',
            style: _labelData,
          ),
          SizedBox(height: 10),
          Text(
            transferOrder.attributes.destinationDirectory.name,
            style: _styleDir,
          ),
          Text(
            'Destino',
            style: _labelData,
          )
        ],
      ),
    );
  }
}
