// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  String uid;
  String name;
  double balance;
  UserModel({
    required this.uid,
    required this.name,
    required this.balance,
  });

  UserModel copyWith({
    String? uid,
    String? name,
    double? balance,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      balance: balance ?? this.balance,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'name': name,
      'balance': balance,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] as String,
      name: map['name'] as String,
      balance: map['balance'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'UserModel(uid: $uid, name: $name, balance: $balance)';

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.uid == uid && other.name == name && other.balance == balance;
  }

  @override
  int get hashCode => uid.hashCode ^ name.hashCode ^ balance.hashCode;
}
