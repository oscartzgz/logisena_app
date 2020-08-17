import 'package:flutter/material.dart';
import 'package:logisena/src/models/transfer_order_model.dart';
import 'package:logisena/src/pages/transfer_order_arguments.dart';
import 'package:logisena/src/pages/shared/status_breadcrumb.dart';

class TransferOrderPage extends StatelessWidget {
  final labelStyle = TextStyle(color: Colors.grey);

  @override
  Widget build(BuildContext context) {
    final TransferOrderArguments args =
        ModalRoute.of(context).settings.arguments;
    final TransferOrderModel transferOrder = args.transferOrder;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent[400],
        title: Text('Orden de Traslado'),
        centerTitle: true,
        actions: <Widget>[],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            children: <Widget>[
              Text(
                transferOrder.attributes.code,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              // _renderStatus(transferOrder),
              renderStatusBreadcrumb(transferOrder),
              // Card(
              //   elevation: 2,
              //   child: Container(
              //     padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              //     width: double.infinity,
              //     child: Container(),
              //   ),
              // ),
              SizedBox(
                height: 10,
              ),
              // Container(
              //   padding: EdgeInsets.symmetric(horizontal: 5),
              //   width: double.infinity,
              //   child: Row(
              //     children: <Widget>[
              //       Text(
              //         'Ruta',
              //         textAlign: TextAlign.left,
              //         style: TextStyle(
              //             fontWeight: FontWeight.bold,
              //             color: Colors.redAccent[700]),
              //       ),
              //       SizedBox(
              //         width: 5,
              //       ),
              //       Expanded(
              //           child: Container(height: 2, color: Colors.grey[500])),
              //     ],
              //   ),
              // ),
              _renderClient(transferOrder),
              SizedBox(height: 15),
              _renderRoute(transferOrder),
              SizedBox(height: 15),
              _renderVehicle(transferOrder),
            ],
          ),
        ),
      ),
    );
  }

  Widget _renderStatus(TransferOrderModel transferOrder) {
    final _labelOk = BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(50)),
      color: Colors.green[400],
    );
    final _labelTextStyle =
        TextStyle(color: Colors.white, fontWeight: FontWeight.bold);

    return Container(
      padding: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
      decoration: _labelOk,
      child: Text(
        transferOrder.attributes.status,
        style: _labelTextStyle,
      ),
    );
  }

  Widget _renderRoute(TransferOrderModel transferOrder) {
    return Card(
      elevation: 3,
      shadowColor: Colors.black,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: Column(
          children: <Widget>[
            Icon(Icons.map, color: Colors.black45),
            SizedBox(
              height: 15,
            ),
            IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Icon(
                        Icons.location_on,
                        color: Colors.indigoAccent,
                      ),
                      Text(transferOrder.attributes.transferredAt.toString(),
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(
                        'Origen',
                        style: labelStyle,
                      ),
                      Container(height: 70, width: 2, color: Colors.black45),
                      Text(
                        (transferOrder.attributes.paymentKm.toString() ??
                                '---') +
                            ' Km',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        height: 70,
                        width: 2,
                        color: Colors.black45,
                      ),
                      Text('Destino', style: labelStyle),
                      Text(
                          transferOrder.attributes.deliveredAt == null
                              ? '---'
                              : transferOrder.attributes.deliveredAt.toString(),
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Icon(
                        Icons.location_on,
                        color: Colors.redAccent,
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                transferOrder.attributes.originDirectory.name,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              Text(
                                  transferOrder
                                      .attributes.originDirectory.address,
                                  style: labelStyle),
                              Text(
                                  transferOrder
                                      .attributes.originDirectory.suburb,
                                  style: labelStyle),
                              Text(
                                  transferOrder.attributes.originDirectory.city,
                                  style: labelStyle),
                              Text(
                                  transferOrder
                                      .attributes.originDirectory.state,
                                  style: labelStyle),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                transferOrder
                                    .attributes.destinationDirectory.name,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              Text(
                                  transferOrder
                                      .attributes.destinationDirectory.address,
                                  style: labelStyle),
                              Text(
                                  transferOrder
                                      .attributes.destinationDirectory.suburb,
                                  style: labelStyle),
                              Text(
                                  transferOrder
                                      .attributes.destinationDirectory.city,
                                  style: labelStyle),
                              Text(
                                  transferOrder
                                      .attributes.destinationDirectory.state,
                                  style: labelStyle),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _renderVehicle(TransferOrderModel transferOrder) {
    final _witheColor = Color.fromRGBO(255, 255, 255, 0.95);

    return Card(
        color: Colors.indigo[700],
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: Column(
            children: <Widget>[
              Icon(Icons.drive_eta, color: Colors.white70),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Text(transferOrder.attributes.chasisNumber ?? '---',
                            style: TextStyle(
                                color: _witheColor,
                                fontSize: 20,
                                fontWeight: FontWeight.bold)),
                        Text(
                          'Chasis',
                          style: labelStyle,
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Text(transferOrder.attributes.vehicleModel ?? '---',
                            style: TextStyle(
                                color: _witheColor,
                                fontSize: 20,
                                fontWeight: FontWeight.bold)),
                        Text(
                          'Modelo',
                          style: labelStyle,
                        )
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Text(
                          transferOrder.attributes.vehicleCode ?? '---',
                          style: TextStyle(
                              color: _witheColor, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Tipo',
                          style: labelStyle,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        transferOrder.attributes.bodywork
                            ? Icon(
                                Icons.check_circle,
                                color: Colors.green,
                              )
                            : Icon(
                                Icons.cancel,
                                color: Colors.red,
                              ),
                        Text('Carrozado', style: labelStyle)
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ));
  }

  Widget _renderClient(TransferOrderModel transferOrder) {
    return Card(
      elevation: 3,
      color: Colors.indigo[700],
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        child: Column(
          children: <Widget>[
            Icon(
              Icons.verified_user,
              color: Colors.white70,
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              transferOrder.attributes.clientName,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            Text(
              'Cliente',
              style: labelStyle,
            )
          ],
        ),
      ),
    );
  }
}
