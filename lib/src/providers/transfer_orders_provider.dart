import 'dart:async';
import 'dart:convert' show json, base64, ascii;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:logisena/src/models/transfer_order_model.dart';
import 'package:logisena/src/providers/configuration.dart';

class TransferOrdersProvider {
  final storage = new FlutterSecureStorage();
  final String _url = Configurations.transferOrders;
  var jwtToken;
  bool _loading = false;

  TransferOrdersProvider() {
    // jwtToken = jwtOrEmpty();
  }

  Future jwtOrEmpty() async {
    var jwt = await storage.read(key: "jwt");
    if (jwt == null || jwt.length < 5) return "";
    return jwt;
  }

  // This will be filled when will be called
  List<TransferOrderModel> _transferOrders = new List();

  final _transferOrdersStreamController =
      StreamController<List<TransferOrderModel>>.broadcast();

  Function(List<TransferOrderModel>) get transferOrdersSink =>
      _transferOrdersStreamController.sink.add;
  Stream<List<TransferOrderModel>> get transferOrdersStream =>
      _transferOrdersStreamController.stream;

  void disposeStreams() {
    _transferOrdersStreamController?.close();
  }

  // Future<List<TransferOrderModel>> _processResponse(String url) async {
  //   final _jwt = await storage.read(key: 'jwt');
  //   final response = await http.get(url, headers: {'Authorization': _jwt});
  //   final decodeData = json.decode(response.body);
  //   final transferOrders = new TransferOrders.fromJsonList(decodeData['data']);
  //   return transferOrders.items;
  // }

  // Future<List<TransferOrderModel>> getTransferOrders() async {
  //   if (_loading) return [];
  //   _loading = true;

  //   final url = Configurations.transfer_orders;
  //   final response = await _processResponse(url);

  //   _transferOrders.addAll(response);
  //   transferOrdersSink(_transferOrders);

  //   _loading = false;
  //   return response;
  // }

  Future<List<TransferOrderModel>> getTransferOrders() async {
    final _jwt = await storage.read(key: 'jwt');
    final Map<String, String> headers = {"Authorization": _jwt};
    final response = await http.get(_url, headers: headers);
    if (response.statusCode == 200) {
      final List<TransferOrderModel> transferOrders =
          TransferOrders.fromJsonList(json.decode(response.body)['data']).items;
      return transferOrders;
    } else {
      return null;
    }
  }
}
