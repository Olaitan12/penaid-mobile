class JWTModel {
  final String userId;
  final String clientName;
  final String surname;
  final String firstname;
  final String role;
  final int iat;
  final int exp;
  JWTModel(this.userId, this.firstname, this.surname, this.clientName,
      this.role, this.iat, this.exp);

  factory JWTModel.fromJson(Map json) {
    return JWTModel(
        json["uuid"] as String,
        json["firstname"] as String,
        json["surname"] as String,
        json["name"] as String,
        json["role"] as String,
        json["iat"],
        json["exp"]);
  }
}
