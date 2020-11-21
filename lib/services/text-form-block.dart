import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class TextFormBloc {
  final BehaviorSubject<Validate> emailSubject = BehaviorSubject<Validate>();
  final BehaviorSubject<Validate> othernameSubject =
      BehaviorSubject<Validate>();
  final BehaviorSubject<Validate> phoneNumberSubject =
      BehaviorSubject<Validate>();
  final BehaviorSubject<Validate> dobSubject = BehaviorSubject<Validate>();
  final BehaviorSubject<Validate> addressSubject = BehaviorSubject<Validate>();
  final BehaviorSubject<Validate> amountSubject = BehaviorSubject<Validate>();
  final BehaviorSubject<Validate> accountNumberSubject =
      BehaviorSubject<Validate>();
  // final textValue = BehaviorSubject<Validate>();

  Stream<String> get phoneNumberStream =>
      phoneNumberSubject.stream.transform(validate);
  Stream<String> get emailStream => emailSubject.stream.transform(validate);
  Stream<String> get otherNameStream =>
      othernameSubject.stream.transform(validate);
  Stream<String> get dobStream => dobSubject.stream.transform(validate);
  Stream<String> get addressStream => addressSubject.stream.transform(validate);
  Stream<String> get accountNumberStream =>
      accountNumberSubject.stream.transform(validate);
  Stream<String> get amountStream => amountSubject.stream.transform(validate);
  // Stream<String> get emailStream => emailSubject.stream.transform(validate);

  void process(Validate validate, BehaviorSubject<Validate> subject) {
    subject.sink.add(validate);
  }
  // void get dispose => textValue?.close();

  final validate = StreamTransformer<Validate, String>.fromHandlers(
    handleData: (data, sink) {
      // debugPrint(data.text);
      switch (data.validation) {
        case Validation.isRequired:
          if (Validator._isNotNull(data.text)) {
            sink.add(data.text);
          } else {
            sink.addError("Required field");
          }
          break;
        case Validation.isNotRequired:
          sink.add(data.text);
          break;
        case Validation.isDate:
          try {
            DateTime.parse(data.text);
            sink.add(data.text);
          } catch (e) {
            sink.addError("Invalid date try DD-MM-YYY");
            debugPrint(e.toString());
          }
          break;
        case Validation.isEmail:
          debugPrint("isemail");
          if (Validator.isEmail(data.text)) {
            sink.add(data.text);
          } else {
            sink.addError("Invalid email address");
          }
          break;
        case Validation.isPhoneNumber:
          if (Validator.isPhoneNumber(data.text)) {
            sink.add(data.text);
          } else {
            sink.addError("Invalid phone number");
          }
          break;
        case Validation.isAmount:
          if (Validator._isNotNull(data.text)) {
            try {
              double i = double.tryParse(data.text);

              i == null
                  ? sink.addError("You input must be a number")
                  : sink.add(i.toString());
              debugPrint(i.toString());
            } catch (e) {}
          } else {
            sink.add("Invalid input");
          }

          break;
        case Validation.isAccountNumber:
          String errorMessage = "Invalid account number";
          if (Validator.isAccountNumber(data.text)) {
            var acc = int.tryParse(data.text);
            acc == null ? sink.addError(errorMessage) : sink.add(data.text);
          } else {
            sink.addError(errorMessage);
          }
          break;
      }
      // }
    },
  );
}

enum Validation {
  isRequired,
  isDate,
  isNotRequired,
  isEmail,
  isPhoneNumber,
  isAccountNumber,
  isAmount
}

class Validate {
  final String text;
  final Validation validation;
  Validate(this.text, this.validation);
}

class Validator {
  static bool isEmail(String text) {
    debugPrint(text);
    final regex = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return (_isNotNull(text) && regex.hasMatch(text));
  }

  static bool isPhoneNumber(String text) {
    return _isNotNull(text) && text.length == 11;
  }

  static bool isAccountNumber(String text) {
    return _isNotNull(text) && text.length == 10;
  }

  // static bool isAmount(String text) {
  //   ///(\d+(\.\d+)?)/
  //   final regex = RegExp(r"(\d+(\.\d+)?)");
  //   return _isNotNull(text) && regex.hasMatch(text);
  // }

  static bool _isNotNull(String text) {
    return text != null && text.isNotEmpty;
  }

  static bool isNormalText(String text) {
    return _isNotNull(text) && text.length > 2;
  }

  static bool isAddress(String text) {
    return _isNotNull(text) && text.length > 10;
  }
}
