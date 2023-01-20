// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TransactionModel {
  String uid;
  String? id;
  DateTime date;
  double value;
  String type;
  String categoryId;
  String? description;
  TransactionModel({
    required this.uid,
    this.id,
    required this.date,
    required this.value,
    required this.type,
    required this.categoryId,
    this.description,
  });

  TransactionModel copyWith({
    String? uid,
    String? id,
    DateTime? date,
    double? value,
    String? type,
    String? categoryId,
    String? description,
  }) {
    return TransactionModel(
      uid: uid ?? this.uid,
      id: id ?? this.id,
      date: date ?? this.date,
      value: value ?? this.value,
      type: type ?? this.type,
      categoryId: categoryId ?? this.categoryId,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'id': id,
      'date': date.millisecondsSinceEpoch,
      'value': value,
      'type': type,
      'categoryId': categoryId,
      'description': description,
    };
  }

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      uid: map['uid'] as String,
      id: map['id'] != null ? map['id'] as String : null,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
      value: map['value'] as double,
      type: map['type'] as String,
      categoryId: map['categoryId'] as String,
      description:
          map['description'] != null ? map['description'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TransactionModel.fromJson(String source) =>
      TransactionModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TransactionModel(uid: $uid, id: $id, date: $date, value: $value, type: $type, categoryId: $categoryId, description: $description)';
  }

  @override
  bool operator ==(covariant TransactionModel other) {
    if (identical(this, other)) return true;

    return other.uid == uid &&
        other.id == id &&
        other.date == date &&
        other.value == value &&
        other.type == type &&
        other.categoryId == categoryId &&
        other.description == description;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        id.hashCode ^
        date.hashCode ^
        value.hashCode ^
        type.hashCode ^
        categoryId.hashCode ^
        description.hashCode;
  }
}
