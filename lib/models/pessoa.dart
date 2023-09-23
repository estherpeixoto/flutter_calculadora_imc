import 'package:flutter/material.dart';
import 'package:imc/exceptions/altura_invalida_exception.dart';
import 'package:imc/exceptions/peso_invalido_exception.dart';

class Pessoa {
  final String id = UniqueKey().toString();
  double _peso = 0;
  double _altura = 0;

  Pessoa(double peso, double altura) {
    setPeso(peso);
    setAltura(altura);
  }

  /// Setter for _peso
  void setPeso(double peso) {
    if (peso <= 0.0) {
      throw PesoInvalidoException();
    }

    _peso = peso;
  }

  /// Getter for _peso
  double getPeso() {
    return _peso;
  }

  /// Setter for _altura
  void setAltura(double altura) {
    if (altura <= 0.0) {
      throw AlturaInvalidaException();
    }

    _altura = altura;
  }

  /// Getter for _altura
  double getAltura() {
    return _altura;
  }
}