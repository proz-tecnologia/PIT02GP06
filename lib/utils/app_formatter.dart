class AppFormatter {
  static final List<String> _mes = [
    '',
    'janeiro',
    'fevereito',
    'março',
    'abril',
    'maio',
    'junho',
    'julho',
    'agosto',
    'setembro',
    'outubro',
    'novembro',
    'dezembro',
  ];
  static String date(DateTime data) {
    return "${data.day}/${data.month}/${data.year}";
  }

  static String dateExtense(DateTime data) {
    return "${data.day} de ${_mes[data.month]} de ${data.year}";
  }

  static String dateExtenseOcultCurrentYear(DateTime data) {
    if (data.year == DateTime.now().year) {
      return "${data.day} de ${_mes[data.month]}";
    } else {
      return dateExtense(data);
    }
  }

  static String money(double value) {
    return value.toStringAsFixed(2).replaceFirst('.', ',');
  }

  static String moneyWithRs(double value) {
    return "R\$ ${money(value)}";
  }
}
