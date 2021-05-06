
abstract class BaseEntity {
  String id;

  String get table;

  Map<String, dynamic> toJson();

  external T fromJsonConvert<T extends BaseEntity>(Map<String, dynamic> json);
}