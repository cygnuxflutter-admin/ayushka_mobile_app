import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

DefaultVariablesResponse defaultVariablesResponseFromJson(String str) => DefaultVariablesResponse.fromJson(json.decode(str));

String defaultVariablesResponseToJson(DefaultVariablesResponse data) => json.encode(data.toJson());

CowData cowDataFromJson(String str) => CowData.fromJson(json.decode(str));

String cowDataToJson(CowData data) => json.encode(data.toJson());

class DefaultVariablesResponse {
  final String status;
  final String message;
  final CowData data;

  DefaultVariablesResponse({required this.status, required this.message, required this.data});

  factory DefaultVariablesResponse.fromJson(Map<String, dynamic> json) =>
      DefaultVariablesResponse(status: json["status"], message: json["message"], data: CowData.fromJson(json["data"]));

  Map<String, dynamic> toJson() => {"status": status, "message": message, "data": data.toJson()};
}

class CowData {
  final List<Vendor> vendors;
  final List<Breed> bulls;
  final List<Breed> items;
  final List<ItemMaster> itemMaster;
  final List<SalesItem> salesItems;
  final List<Department> department;
  final List<Breed> expenseTypes;
  final List<Breed> employeeCategory;
  final List<Breed> sheds;
  final List<Breed> cowTypes;
  final List<Breed> breeds;
  final List<Breed> distributionFreePerson;
  final List<Vehicle> vehicles;
  final List<Breed> gaushalaList;
  final List<Breed> vaccines;

  CowData({
    required this.vendors,
    required this.bulls,
    required this.items,
    required this.itemMaster,
    required this.salesItems,
    required this.department,
    required this.expenseTypes,
    required this.employeeCategory,
    required this.sheds,
    required this.cowTypes,
    required this.breeds,
    required this.distributionFreePerson,
    required this.vehicles,
    required this.gaushalaList,
    required this.vaccines,
  });

  factory CowData.fromJson(Map<String, dynamic> json) => CowData(
    vendors: List<Vendor>.from(json["vendors"].map((x) => Vendor.fromJson(x))),
    bulls: List<Breed>.from(json["bulls"].map((x) => Breed.fromJson(x))),
    items: List<Breed>.from(json["items"].map((x) => Breed.fromJson(x))),
    itemMaster: List<ItemMaster>.from(json["item_master"].map((x) => ItemMaster.fromJson(x))),
    salesItems: List<SalesItem>.from(json["sales_items"].map((x) => SalesItem.fromJson(x))),
    department: List<Department>.from(json["department"].map((x) => Department.fromJson(x))),
    expenseTypes: List<Breed>.from(json["expense_types"].map((x) => Breed.fromJson(x))),
    employeeCategory: List<Breed>.from(json["employeeCategory"].map((x) => Breed.fromJson(x))),
    sheds: List<Breed>.from(json["sheds"].map((x) => Breed.fromJson(x))),
    cowTypes: List<Breed>.from(json["cowTypes"].map((x) => Breed.fromJson(x))),
    breeds: List<Breed>.from(json["breeds"].map((x) => Breed.fromJson(x))),
    distributionFreePerson: List<Breed>.from(json["distribution_free_person"].map((x) => Breed.fromJson(x))),
    vehicles: List<Vehicle>.from(json["vehicles"].map((x) => Vehicle.fromJson(x))),
    gaushalaList: List<Breed>.from(json["gaushala_list"].map((x) => Breed.fromJson(x))),
    vaccines: List<Breed>.from(json["vaccines"].map((x) => Breed.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "vendors": List<dynamic>.from(vendors.map((x) => x.toJson())),
    "bulls": List<dynamic>.from(bulls.map((x) => x.toJson())),
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
    "item_master": List<dynamic>.from(itemMaster.map((x) => x.toJson())),
    "sales_items": List<dynamic>.from(salesItems.map((x) => x.toJson())),
    "department": List<dynamic>.from(department.map((x) => x.toJson())),
    "expense_types": List<dynamic>.from(expenseTypes.map((x) => x.toJson())),
    "employeeCategory": List<dynamic>.from(employeeCategory.map((x) => x.toJson())),
    "sheds": List<dynamic>.from(sheds.map((x) => x.toJson())),
    "cowTypes": List<dynamic>.from(cowTypes.map((x) => x.toJson())),
    "breeds": List<dynamic>.from(breeds.map((x) => x.toJson())),
    "distribution_free_person": List<dynamic>.from(distributionFreePerson.map((x) => x.toJson())),
    "vehicles": List<dynamic>.from(vehicles.map((x) => x.toJson())),
    "gaushala_list": List<dynamic>.from(gaushalaList.map((x) => x.toJson())),
    "vaccines": List<dynamic>.from(vaccines.map((x) => x.toJson())),
  };
}

class Breed {
  final String id;
  final String value;

  Breed({required this.id, required this.value});

  factory Breed.fromJson(Map<String, dynamic> json) => Breed(id: json["id"], value: json["value"]);

  Map<String, dynamic> toJson() => {"id": id, "value": value};
}

class Department {
  final String id;
  final String value;
  final int mobileNo;
  final String emailId;

  Department({required this.id, required this.value, required this.mobileNo, required this.emailId});

  factory Department.fromJson(Map<String, dynamic> json) =>
      Department(id: json["id"], value: json["value"], mobileNo: json["mobile_no"], emailId: json["email_id"]);

  Map<String, dynamic> toJson() => {"id": id, "value": value, "mobile_no": mobileNo, "email_id": emailId};
}

class ItemMaster {
  final String unitType;
  final String outUnitType;
  final String expenceType;
  final String itemId;
  final String itemName;
  final bool isStock;
  RxDouble stock;
  RxBool stockOut = false.obs;
  TextEditingController StockOutController = TextEditingController();

  ItemMaster({
    required this.unitType,
    required this.outUnitType,
    required this.expenceType,
    required this.itemId,
    required this.itemName,
    required this.isStock,
    required this.stockOut,
    required this.stock,
  });

  factory ItemMaster.fromJson(Map<String, dynamic> json) => ItemMaster(
    unitType: json["UnitType"],
    outUnitType: json["OutUnitType"],
    expenceType: json["ExpenceType"],
    itemId: json["ItemId"],
    itemName: json["ItemName"],
    isStock: json["isStock"] ?? false,
    stockOut: RxBool(json["stockOut"] ?? false),
    stock: RxDouble(json["stock"] ?? 0.0),
  );

  Map<String, dynamic> toJson() => {
    "UnitType": unitType,
    "OutUnitType": outUnitType,
    "ExpenceType": expenceType,
    "ItemId": itemId,
    "ItemName": itemName,
    "isStock": isStock,
  };
}

class SalesItem {
  final String id;
  final String itemName;
  final String unit;
  final String pieceQty;
  final int ratePerUnit;

  SalesItem({required this.id, required this.itemName, required this.unit, required this.pieceQty, required this.ratePerUnit});

  factory SalesItem.fromJson(Map<String, dynamic> json) =>
      SalesItem(id: json["id"], itemName: json["item_name"], unit: json["unit"], pieceQty: json["piece_qty"], ratePerUnit: json["rate_per_unit"]);

  Map<String, dynamic> toJson() => {"id": id, "item_name": itemName, "unit": unit, "piece_qty": pieceQty, "rate_per_unit": ratePerUnit};
}

class Vehicle {
  final String vehicleName;
  final String vehicleNumber;

  Vehicle({required this.vehicleName, required this.vehicleNumber});

  factory Vehicle.fromJson(Map<String, dynamic> json) => Vehicle(vehicleName: json["vehicle_name"], vehicleNumber: json["vehicle_number"]);

  Map<String, dynamic> toJson() => {"vehicle_name": vehicleName, "vehicle_number": vehicleNumber};
}

class Vendor {
  final String code;
  final String group;
  final String name;
  final int mobileNo;

  Vendor({required this.code, required this.group, required this.name, required this.mobileNo});

  factory Vendor.fromJson(Map<String, dynamic> json) =>
      Vendor(code: json["Code"], group: json["Group"], name: json["Name"], mobileNo: json["Mobile_No"]);

  Map<String, dynamic> toJson() => {"Code": code, "Group": group, "Name": name, "Mobile_No": mobileNo};
}
