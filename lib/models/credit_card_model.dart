// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CreditCardModel {
  String? id;
  String uid;
  String flag;
  String nickname;
  double limit;
  double spent;
  DateTime closeDate;
  DateTime dueDate;
  CreditCardModel({
    this.id,
    required this.uid,
    required this.flag,
    required this.nickname,
    required this.limit,
    required this.spent,
    required this.closeDate,
    required this.dueDate,
  });

  CreditCardModel copyWith({
    String? id,
    String? uid,
    String? flag,
    String? nickname,
    double? limit,
    double? spent,
    DateTime? closeDate,
    DateTime? dueDate,
  }) {
    return CreditCardModel(
      id: id ?? this.id,
      uid: uid ?? this.uid,
      flag: flag ?? this.flag,
      nickname: nickname ?? this.nickname,
      limit: limit ?? this.limit,
      spent: spent ?? this.spent,
      closeDate: closeDate ?? this.closeDate,
      dueDate: dueDate ?? this.dueDate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'uid': uid,
      'flag': flag,
      'nickname': nickname,
      'limit': limit,
      'spent': spent,
      'closeDate': closeDate.millisecondsSinceEpoch,
      'dueDate': dueDate.millisecondsSinceEpoch,
    };
  }

  factory CreditCardModel.fromMap(Map<String, dynamic> map) {
    return CreditCardModel(
      id: map['id'] != null ? map['id'] as String : null,
      uid: map['uid'] as String,
      flag: map['flag'] as String,
      nickname: map['nickname'] as String,
      limit: map['limit'] as double,
      spent: map['spent'] as double,
      closeDate: DateTime.fromMillisecondsSinceEpoch(map['closeDate'] as int),
      dueDate: DateTime.fromMillisecondsSinceEpoch(map['dueDate'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory CreditCardModel.fromJson(String source) =>
      CreditCardModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CreditCardModel(id: $id, uid: $uid, flag: $flag, nickname: $nickname, limit: $limit, spent: $spent, closeDate: $closeDate, dueDate: $dueDate)';
  }

  @override
  bool operator ==(covariant CreditCardModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.uid == uid &&
        other.flag == flag &&
        other.nickname == nickname &&
        other.limit == limit &&
        other.spent == spent &&
        other.closeDate == closeDate &&
        other.dueDate == dueDate;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        uid.hashCode ^
        flag.hashCode ^
        nickname.hashCode ^
        limit.hashCode ^
        spent.hashCode ^
        closeDate.hashCode ^
        dueDate.hashCode;
  }
}
