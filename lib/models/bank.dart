class Bank {
  final String name;
  final String code;
  Bank(this.name, this.code);
  factory Bank.fromJson(dynamic json) {
    return Bank(json["name"] as String, json["code"] as String);
  }
}
