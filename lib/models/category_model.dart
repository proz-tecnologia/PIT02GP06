// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CategoryModel {
  String uid;
  String? id;
  String genre;
  int color;
  String type;
  int count;

  CategoryModel({
    required this.uid,
    this.id,
    required this.genre,
    required this.color,
    required this.type,
    this.count = 0,
  });

  void incrementCount() {
    count++;
  }

  void decrementCount() {
    count--;
  }

  CategoryModel copyWith({
    String? uid,
    String? id,
    String? genre,
    int? color,
    String? type,
    int? count,
  }) {
    return CategoryModel(
      uid: uid ?? this.uid,
      id: id ?? this.id,
      genre: genre ?? this.genre,
      color: color ?? this.color,
      type: type ?? this.type,
      count: count ?? this.count,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'id': id,
      'genre': genre,
      'color': color,
      'type': type,
      'count': count,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      uid: map['uid'] as String,
      id: map['id'] != null ? map['id'] as String : null,
      genre: map['genre'] as String,
      color: map['color'] as int,
      type: map['type'] as String,
      count: map['count'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryModel.fromJson(String source) =>
      CategoryModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CategoryModel(uid: $uid, id: $id, genre: $genre, color: $color, type: $type, count: $count)';
  }

  @override
  bool operator ==(covariant CategoryModel other) {
    if (identical(this, other)) return true;

    return other.uid == uid &&
        other.id == id &&
        other.genre == genre &&
        other.color == color &&
        other.type == type &&
        other.count == count;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        id.hashCode ^
        genre.hashCode ^
        color.hashCode ^
        type.hashCode ^
        count.hashCode;
  }
}
