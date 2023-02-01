import '../../../models/credit_card_model.dart';

class CreditCardRegisterViewModel {
  final CreditCardModel? model;

  CreditCardRegisterViewModel({this.model});

  String get registerTitle => 'Cadastrar Cartão';
  String get editTitle => 'Editar Cartão';

  String get nicknameLabel => 'Apelido do cartão*';
  String get nicknameValidatorText => 'Digite um apelido válido';

  String get limitLabel => 'Limite*';
  String get spentLabel => 'Limite utilizado*';

  String get closeDateLabel => 'Dia de fechamento*';
  String get dueDateLabel => 'Dia de vencimento*';

  String get genericValueValidatorText => 'Digite um valor válido';
  String get genericDateValidatorText => 'Digite uma data válida';

  String get registerButton => 'Cadastrar';
  String get editButton => 'Salvar';

  Map<String, List<int>> get flagCodePrefix => {
        "visa": [4],
        "master": [51, 52, 53, 54, 55],
        "amex": [34, 37]
      };
}
