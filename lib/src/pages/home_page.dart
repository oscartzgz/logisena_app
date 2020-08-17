import 'package:flutter/material.dart';
import 'package:logisena/src/models/profile_model.dart';
import 'package:logisena/src/models/transfer_order_model.dart';
import 'package:logisena/src/pages/transfer_order_arguments.dart';
import 'package:logisena/src/providers/profile_provider.dart';
import 'package:logisena/src/providers/sessions_provider.dart';
import 'package:logisena/src/providers/transfer_orders_provider.dart';

import '../api.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final scrollController = ScrollController();
  TransferOrdersModel transferOrdersModel;

  final _sessionsProvider = SessionsProvider();
  final transferOrdersProvider = new TransferOrdersProvider();

  @override
  void initState() {
    transferOrdersModel = TransferOrdersModel();
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        transferOrdersModel.loadMore();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: AppBar(
    //   ),
    //   body: null,

    return Scaffold(
      drawer: _menu(context),
      appBar: AppBar(
        backgroundColor: Colors.redAccent[400],
        title: Text("Ordenes de Traslado"),
        centerTitle: true,
        toolbarOpacity: 0.9,
      ),
      body: StreamBuilder(
          stream: transferOrdersModel.stream,
          builder: (BuildContext context, AsyncSnapshot _snapshot) {
            if (!_snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return RefreshIndicator(
                  onRefresh: transferOrdersModel.refresh,
                  child: ListView.builder(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      controller: scrollController,
                      // separatorBuilder: (context, index) => Sized,
                      itemCount: _snapshot.data.length + 1,
                      itemBuilder: (BuildContext context, int index) {
                        if (index < _snapshot.data.length) {
                          return _renderTransferOrder(
                              context, _snapshot.data[index]);
                        } else if (transferOrdersModel.hasMore) {
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 32),
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        } else {
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 32),
                            child: Center(
                              child: Text('¡Nada mas por cargar!'),
                            ),
                          );
                        }
                      }));
            }
          }),
    );

    //           // Text("Home Page for Driver should show:"),
    //           // SizedBox(height: 20.0),
    //           // Text("First: Show current assigned Transfer Orders"),
    //           // Text("Second: Show some last monthly Transfer Orders"),
    //           // Text("Third: Way to show page thatdue with "),
    //           // Text("Fourth: Ability to logout"),
    //           // Text("Fifth: Driver can see salary details per TransferOrder"),
    //           // Text("Sixth: Driver can download PDF and store on phone"),
    //           // Text(
    //           //     "Seventh: On a future driver can start translate and app can save GPS route, this have us the ability to see in real time the translate"),
  }

  Widget _menu(BuildContext context) {
    final _profielProvider = ProfileProvider();

    return Drawer(
      child: ListView(
        children: <Widget>[
          FutureBuilder(
            future: _profielProvider.getProfile(),
            builder: (BuildContext context, AsyncSnapshot _snapshot) {
              if (_snapshot.hasData) {
                final ProfileModel profile = _snapshot.data;
                final urlImage =
                    "${Api.domain}/${profile.attributes.photo.thumb.url}";

                return UserAccountsDrawerHeader(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomRight,
                          colors: [Colors.blue[700], Colors.redAccent])),
                  accountName: Text(profile.attributes.fullName),
                  accountEmail:
                      Text("Matricula: ${profile.attributes.enrollment}"),
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: NetworkImage(urlImage),
                  ),
                );
              } else {
                return DrawerHeader(
                    child: Center(
                  child: CircularProgressIndicator(),
                ));
              }
            },
          ),
          ListTile(
            leading: Icon(
              Icons.exit_to_app,
              color: Colors.red[400],
            ),
            title: Text(
              "Cerrar Sesión",
              style: TextStyle(
                  color: Colors.red[400],
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
            onTap: () {
              _sessionsProvider.destroySession();
              Navigator.pushReplacementNamed(context, 'login');
            },
          )
        ],
      ),
    );
  }

  _renderTransferOrder(BuildContext context, TransferOrderModel transferOrder) {
    final _styleDir = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 18,
      color: Colors.black87,
    );
    final _labelData = TextStyle(color: Colors.black54);
    final _labelOk = BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(50)),
      color: Colors.green[400],
    );
    final _labelTextStyle =
        TextStyle(color: Colors.white, fontWeight: FontWeight.bold);

    return InkWell(
      onTap: () => Navigator.pushNamed(context, 'transfer_order',
          arguments: TransferOrderArguments(transferOrder)),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.5),
                  blurRadius: 3,
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
              textAlign: TextAlign.center,
            ),
            Text(
              'Origen',
              style: _labelData,
            ),
            SizedBox(height: 10),
            Text(
              transferOrder.attributes.destinationDirectory.name,
              style: _styleDir,
              textAlign: TextAlign.center,
            ),
            Text(
              'Destino',
              style: _labelData,
            )
          ],
        ),
      ),
    );
  }
}
