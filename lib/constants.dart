import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:intl/intl.dart'; //for date format

const EdgeInsets SCREEN_SPACE = EdgeInsets.symmetric(horizontal: 15);
const String VERSION = "0.0.1";
const BACKGROUND_COLOR = Color.fromRGBO(234, 230, 225, 1);
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
