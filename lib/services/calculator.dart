import 'package:imc/models/imc_sqflite_model.dart';

class Calculator {
  double calculate(ImcSQFliteModel imc) {
    double result = imc.weight / (imc.height * imc.height);
    return double.parse(result.toStringAsFixed(2));
  }

  String result(ImcSQFliteModel imc) {
    double result = calculate(imc);

    if (result < 16) {
      return 'Magreza grave';
    }

    if (result < 17) {
      return 'Magreza moderada';
    }

    if (result < 18.5) {
      return 'Magreza leve';
    }

    if (result < 25) {
      return 'Saudável';
    }

    if (result < 30) {
      return 'Sobrepeso';
    }

    if (result < 35) {
      return 'Obesidade Grau I';
    }

    if (result < 40) {
      return 'Obesidade Grau II (severa)';
    }

    return 'Obesidade Grau III (mórbida)';
  }
}
