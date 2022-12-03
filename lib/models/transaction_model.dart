// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TransactionModel {
  DateTime data;
  double valor;
  int contaId;
  String type;
  TransactionModel({
    required this.data,
    required this.valor,
    required this.contaId,
    required this.type,
  });

  TransactionModel copyWith({
    DateTime? data,
    double? valor,
    int? contaId,
    String? type,
  }) {
    return TransactionModel(
      data: data ?? this.data,
      valor: valor ?? this.valor,
      contaId: contaId ?? this.contaId,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'data': data.millisecondsSinceEpoch,
      'valor': valor,
      'contaId': contaId,
      'type': type,
    };
  }

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      data: DateTime.fromMillisecondsSinceEpoch(map['data'] as int),
      valor: map['valor'] as double,
      contaId: map['contaId'] as int,
      type: map['type'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TransactionModel.fromJson(String source) =>
      TransactionModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TransactionModel(data: $data, valor: $valor, contaId: $contaId, type: $type)';
  }

  @override
  bool operator ==(covariant TransactionModel other) {
    if (identical(this, other)) return true;

    return other.data == data &&
        other.valor == valor &&
        other.contaId == contaId &&
        other.type == type;
  }

  @override
  int get hashCode {
    return data.hashCode ^ valor.hashCode ^ contaId.hashCode ^ type.hashCode;
  }
}
