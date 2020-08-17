import 'package:flutter/material.dart';
import 'package:logisena/src/models/transfer_order_model.dart';

Widget renderStatusBreadcrumb(TransferOrderModel transferOrder) {
  var bgColor = Colors.grey[600];
  var txtColor = Colors.black45;

  switch (transferOrder.attributes.status) {
    case "No realizado":
      bgColor = Colors.grey;
      txtColor = Colors.black87;
      break;
    case "Ejecutando":
      bgColor = Colors.yellow;
      txtColor = Colors.black87;
      break;
    case "Finalizado":
      bgColor = Colors.green;
      txtColor = Colors.white;
      break;
    case "Cancelada":
      bgColor = Colors.red[600];
      txtColor = Colors.white;
      break;
    default:
  }

  final _labelStyle = BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(50)),
    color: bgColor,
  );

  final _labelTextStyle =
      TextStyle(color: txtColor, fontWeight: FontWeight.bold);

  return Container(
    padding: EdgeInsets.symmetric(vertical: 3, horizontal: 15),
    decoration: _labelStyle,
    child: Text(
      transferOrder.attributes.status,
      style: _labelTextStyle,
    ),
  );
}
