// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  String uuid;
  String name;
  double balance;
  UserModel({
    required this.uuid,
    required this.name,
    required this.balance,
  });

  UserModel copyWith({
    String? uuid,
    String? name,
    double? balance,
  }) {
    return UserModel(
      uuid: uuid ?? this.uuid,
      name: name ?? this.name,
      balance: balance ?? this.balance,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uuid': uuid,
      'name': name,
      'balance': balance,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uuid: map['uuid'] as String,
      name: map['name'] as String,
      balance: map['balance'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'UserModel(uuid: $uuid, name: $name, balance: $balance)';

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.uuid == uuid && other.name == name && other.balance == balance;
  }

  @override
  int get hashCode => uuid.hashCode ^ name.hashCode ^ balance.hashCode;
}
