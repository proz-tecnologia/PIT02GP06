// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CategoryModel {
  String genre;
  int color;
  String type;
  CategoryModel({
    required this.genre,
    required this.color,
    required this.type,
  });

  CategoryModel copyWith({
    String? genre,
    int? color,
    String? type,
  }) {
    return CategoryModel(
      genre: genre ?? this.genre,
      color: color ?? this.color,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'genre': genre,
      'color': color,
      'type': type,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      genre: map['genre'] as String,
      color: map['color'] as int,
      type: map['type'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryModel.fromJson(String source) =>
      CategoryModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'CategoryModel(genre: $genre, color: $color, type: $type)';

  @override
  bool operator ==(covariant CategoryModel other) {
    if (identical(this, other)) return true;

    return other.genre == genre && other.color == color && other.type == type;
  }

  @override
  int get hashCode => genre.hashCode ^ color.hashCode ^ type.hashCode;
}
