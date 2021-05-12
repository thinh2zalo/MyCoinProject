class AccountModel {
  final int id;
  final String privateKey;
  final String publicKey;
  final String accountName;
  final int amount;

  AccountModel({
    this.id,
    this.privateKey,
    this.publicKey,
    this.accountName,
    this.amount,
  });

  AccountModel coppyWith(
      {int amount,
      String privateKey,
      String publicKey,
      String accountName,
      int id}) {
    return AccountModel(
      accountName: accountName ?? this.accountName,
      privateKey: privateKey ?? this.privateKey,
      publicKey: publicKey ?? this.publicKey,
      id: id ?? this.id,
      amount: amount ?? this.amount,
    );
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["userId"] = id;
    map["privateKey"] = privateKey;
    map["publicKey"] = publicKey;
    map["accountName"] = accountName;
    return map;
  }
}
