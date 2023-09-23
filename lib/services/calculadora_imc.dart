import 'package:imc/models/pessoa.dart';

class CalculadoraImc {
  double calcular(Pessoa pessoa) {
    double imc = pessoa.getPeso() / (pessoa.getAltura() * pessoa.getAltura());
    return double.parse(imc.toStringAsFixed(2));
  }

  String resultado(Pessoa pessoa) {
    double imc = calcular(pessoa);

    if (imc < 16) {
      return 'Magreza grave';
    }

    if (imc < 17) {
      return 'Magreza moderada';
    }

    if (imc < 18.5) {
      return 'Magreza leve';
    }

    if (imc < 25) {
      return 'Saudável';
    }

    if (imc < 30) {
      return 'Sobrepeso';
    }

    if (imc < 35) {
      return 'Obesidade Grau I';
    }

    if (imc < 40) {
      return 'Obesidade Grau II (severa)';
    }

    return 'Obesidade Grau III (mórbida)';
  }
}