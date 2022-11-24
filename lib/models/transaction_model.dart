import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class TransactionModel {
  DateTime data;
  double valor;
  int contaId;
  TransactionModel({
    required this.data,
    required this.valor,
    required this.contaId,
  });

  @override
  String toString() =>
      'TransactionModel(data: $data, valor: $valor, contaId: $contaId)';

  @override
  bool operator ==(covariant TransactionModel other) {
    if (identical(this, other)) return true;

    return other.data == data &&
        other.valor == valor &&
        other.contaId == contaId;
  }

  @override
  int get hashCode => data.hashCode ^ valor.hashCode ^ contaId.hashCode;

  TransactionModel copyWith({
    DateTime? data,
    double? valor,
    int? contaId,
  }) {
    return TransactionModel(
      data: data ?? this.data,
      valor: valor ?? this.valor,
      contaId: contaId ?? this.contaId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'data': data.millisecondsSinceEpoch,
      'valor': valor,
      'contaId': contaId,
    };
  }

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      data: DateTime.fromMillisecondsSinceEpoch(map['data'] as int),
      valor: map['valor'] as double,
      contaId: map['contaId'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory TransactionModel.fromJson(String source) =>
      TransactionModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
