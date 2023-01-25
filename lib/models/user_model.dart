// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  String uid;
  String? name;
  String? phone;
  String? email;
  double balance;
  UserModel({
    required this.uid,
    this.name,
    this.phone,
    this.email,
    required this.balance,
  });

  UserModel copyWith({
    String? uid,
    String? name,
    String? phone,
    String? email,
    double? balance,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      balance: balance ?? this.balance,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'name': name,
      'phone': phone,
      'email': email,
      'balance': balance,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] as String,
      name: map['name'] as String,
      phone: map['phone'] != null ? map['phone'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      balance: map['balance'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'UserModel(uid: $uid, name: $name, phone: $phone, email: $email, balance: $balance)';

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.uid == uid &&
        other.name == name &&
        other.phone == phone &&
        other.email == email &&
        other.balance == balance;
  }

  @override
  int get hashCode => uid.hashCode ^ name.hashCode ^ balance.hashCode;
}
