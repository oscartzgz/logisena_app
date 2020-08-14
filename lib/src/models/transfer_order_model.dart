import 'dart:async';
import 'dart:convert';

import 'package:logisena/src/providers/transfer_orders_provider.dart';
// To parse this JSON data, do
//
//     final transferOrder = transferOrderFromJson(jsonString);

// import 'dart:convert';

// TransferOrder transferOrderFromJson(String str) => TransferOrder.fromJsonList(json.decode(str));

// String transferOrderToJson(TransferOrder data) => json.encode(data.toJson());
final transferOrdersProvider = TransferOrdersProvider();
Future<List<TransferOrderModel>> _getTransferOrders(int length) async {
  List<TransferOrderModel> transferOrders =
      await transferOrdersProvider.getTransferOrders();
  return transferOrders;
}

class TransferOrdersModel {
  Stream<List<TransferOrderModel>> stream;
  bool hasMore;

  bool _isLoading;
  List<TransferOrderModel> _data;
  StreamController<List<TransferOrderModel>> _controller;

// Constructor
  TransferOrdersModel() {
    _data = List<TransferOrderModel>();
    _controller = StreamController<List<TransferOrderModel>>.broadcast();
    _isLoading = false;
    stream =
        _controller.stream.map((List<TransferOrderModel> transferOrdersData) {
      return transferOrdersData.map((TransferOrderModel transferOrderData) {
        return transferOrderData;
        // return TransferOrderModel.fromJson(transferOrderData);
      }).toList();
    });
    hasMore = true;
    refresh();
  }

  Future<void> refresh() {
    return loadMore(clearCacheData: true);
  }

  Future<void> loadMore({bool clearCacheData = false}) {
    if (clearCacheData) {
      _data = List<TransferOrderModel>();
      hasMore = true;
    }
    if (_isLoading || !hasMore) {
      return Future.value();
    }
    _isLoading = true;
    return _getTransferOrders(10).then((transferOrderData) {
      _isLoading = false;
      _data.addAll(transferOrderData);
      hasMore = (_data.length < 30);
      _controller.add(_data);
    });
  }
}

class TransferOrders {
  List<TransferOrderModel> items = new List();
  TransferOrders();

  TransferOrders.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    for (var item in jsonList) {
      final transferOrder = new TransferOrderModel.fromJson(item);
      items.add(transferOrder);
    }
  }
}

// To parse this JSON data, do
//
//     final transferOrderModel = transferOrderModelFromJson(jsonString);

TransferOrderModel transferOrderModelFromJson(String str) =>
    TransferOrderModel.fromJson(json.decode(str));

String transferOrderModelToJson(TransferOrderModel data) =>
    json.encode(data.toJson());

class TransferOrderModel {
  TransferOrderModel({
    this.id,
    this.type,
    this.attributes,
  });

  String id;
  String type;
  Attributes attributes;

  factory TransferOrderModel.fromJson(Map<String, dynamic> json) =>
      TransferOrderModel(
        id: json["id"],
        type: json["type"],
        attributes: Attributes.fromJson(json["attributes"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "attributes": attributes.toJson(),
      };
}

class Attributes {
  Attributes(
      {this.code,
      this.status,
      this.transferredAt,
      this.deliveredAt,
      this.originDirectory,
      this.destinationDirectory,
      this.paymentKm});

  String code;
  String status;
  String transferredAt;
  dynamic deliveredAt;
  NDirectory originDirectory;
  NDirectory destinationDirectory;
  int paymentKm;

  factory Attributes.fromJson(Map<String, dynamic> json) => Attributes(
        code: json["code"],
        status: json["status"],
        // transferredAt: DateTime.parse(json["transferred_at"]),
        transferredAt: json["transferred_at"],
        deliveredAt: json["delivered_at"],
        originDirectory: NDirectory.fromJson(json["origin_directory"]),
        destinationDirectory:
            NDirectory.fromJson(json["destination_directory"]),
        paymentKm: json["payment_km"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "transferred_at": transferredAt,
        "delivered_at": deliveredAt,
        "origin_directory": originDirectory.toJson(),
        "destination_directory": destinationDirectory.toJson(),
        "payment_km": paymentKm,
      };
}

class NDirectory {
  NDirectory({
    this.id,
    this.name,
    this.businessName,
    this.address,
    this.suburb,
    this.city,
    this.state,
    this.country,
    this.contactName,
    this.contactPhone,
    this.contactEmail,
    this.createdAt,
    this.updatedAt,
    this.latitude,
    this.longitude,
  });

  int id;
  String name;
  String businessName;
  String address;
  String suburb;
  String city;
  String state;
  String country;
  String contactName;
  String contactPhone;
  String contactEmail;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic latitude;
  dynamic longitude;

  factory NDirectory.fromJson(Map<String, dynamic> json) => NDirectory(
        id: json["id"],
        name: json["name"],
        businessName: json["business_name"],
        address: json["address"],
        suburb: json["suburb"],
        city: json["city"],
        state: json["state"],
        country: json["country"],
        contactName: json["contact_name"],
        contactPhone: json["contact_phone"],
        contactEmail: json["contact_email"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        latitude: json["latitude"],
        longitude: json["longitude"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "business_name": businessName,
        "address": address,
        "suburb": suburb,
        "city": city,
        "state": state,
        "country": country,
        "contact_name": contactName,
        "contact_phone": contactPhone,
        "contact_email": contactEmail,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "latitude": latitude,
        "longitude": longitude,
      };
}
