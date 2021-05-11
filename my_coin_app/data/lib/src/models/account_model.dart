class AccountModel {
  final int id;
  final String privateKey;
  final String publicKey;
  final accountName;

  AccountModel({this.id, this.privateKey, this.publicKey, this.accountName});

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["userId"] = id;
    map["privateKey"] = privateKey;
    map["publicKey"] = publicKey;
    map["accountName"] = accountName;

    return map;
  }
}
