import 'package:flutter/material.dart';
import 'package:logisena/src/models/transfer_order_model.dart';
import 'package:logisena/src/pages/transfer_order_arguments.dart';
import 'package:logisena/src/providers/transfer_orders_provider.dart';

class DebtsPage extends StatefulWidget {
  @override
  _DebtsPageState createState() => _DebtsPageState();
}

class _DebtsPageState extends State<DebtsPage> {
  final scrollController = ScrollController();

  TransferOrdersModel transferOrdersModel;

  TransferOrdersProvider transferOrdersProvider = TransferOrdersProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Deudas de OTs'),
        centerTitle: true,
        backgroundColor: Colors.redAccent[400],
      ),
      body: FutureBuilder(
          future: transferOrdersProvider.getDebtTransferOrders(),
          builder: (BuildContext context,
              AsyncSnapshot<List<TransferOrderModel>> _snapshot) {
            if (!_snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              double totalDebt = _snapshot.data
                  .map<double>((m) => m.attributes.driverDue)
                  .fold(0.0, (previous, current) => previous + current);

              return Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: 5),
                    padding: EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: Colors.black87,
                              offset: Offset(0, 1),
                              blurRadius: 2)
                        ],
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15)),
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.center,
                            colors: <Color>[
                              Colors.green[400],
                              Colors.red[500]
                            ])),
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "\$${totalDebt.toStringAsFixed(2)}",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 26,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "Deuda Total",
                          style: TextStyle(
                              color: Colors.white70,
                              fontSize: 16,
                              fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        controller: scrollController,
                        // separatorBuilder: (context, index) => Sized,
                        itemCount: _snapshot.data.length + 1,
                        itemBuilder: (BuildContext context, int index) {
                          if (index < _snapshot.data.length) {
                            return _renderTransferOrder(
                                context, _snapshot.data[index]);
                          } else {
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: 32),
                              child: Center(
                                child: Text('¡Nada mas por cargar!'),
                              ),
                            );
                          }
                        }),
                  ),
                ],
              );
            }
          }),
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
            ),
            Container(
                margin: EdgeInsets.only(top: 10),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.orange[800],
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(6),
                        bottomRight: Radius.circular(6))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Mi Deuda:  ',
                        style: TextStyle(color: Colors.white, fontSize: 16)),
                    Text(
                      "\$${transferOrder.attributes.driverDue.toStringAsFixed(2)}",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
