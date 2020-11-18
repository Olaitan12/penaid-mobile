import 'dart:convert' show json;
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:intl/intl.dart'; //for date format

const EdgeInsets SCREEN_SPACE = EdgeInsets.symmetric(horizontal: 15);
const String VERSION = "0.0.1";
// ignore: non_constant_identifier_names
final BACKGROUND_COLOR = Colors.grey[10];
const NAIRA = "₦";
var numberFormat = new NumberFormat.currency(locale: "en_US", symbol: "");
var nairaFormat = new NumberFormat.currency(locale: "en_US", symbol: NAIRA);
var dateFormat = DateFormat("MMM d, y");
Map<String, MaterialColor> colorsMap = {
  "defaulted": Colors.red,
  "pending": Colors.blue,
  "paid": Colors.green,
  "overdue": Colors.red,
};
// Future<String> photoUrl => getPhotoUrl() ;
Future<String> getPhotoFile() async {
  String jsonString = await rootBundle.loadString("assets/_secure/api.json");
  var links = json.decode(jsonString);
  return links["storage_url"] as String;
}
