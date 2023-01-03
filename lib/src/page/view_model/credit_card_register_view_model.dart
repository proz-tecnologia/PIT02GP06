import '../../../models/credit_card_model.dart';

class CreditCardRegisterViewModel {
  final CreditCardModel? model;

  CreditCardRegisterViewModel({this.model});

  String get registerTitle => 'Cadastrar Cartão';
  String get editTitle => 'Editar Cartão';

  String get nicknameLabel => 'Apelido do cartão*';
  String get nicknameValidatorText => 'Digite um apelido válido';

  String get flagLabel => 'Bandeira*';
  String get flagValidatorText => 'Digite um apelido válido';

  String get limitLabel => 'Limite*';
  String get spentLabel => 'Limite utilizado*';

  String get closeDateLabel => 'Dia de fechamento*';
  String get dueDateLabel => 'Dia de vencimento*';

  String get genericValueValidatorText => 'Digite um valor válido';
  String get genericDateValidatorText => 'Digite uma data válida';

  String get registerButton => 'Cadastrar';
  String get editButton => 'Salvar';
}
