import 'package:flutter/material.dart';

class Imc {
  final String _id = UniqueKey().toString();
  String _peso = '';
  String _altura = '';
  String _resultado = '';

  Imc(this._resultado);

  String get id => _id;

  String get peso => _peso;

  String get altura => _altura;

  String get resultado => _resultado;

  set peso(String peso) {
    _peso = peso;
  }

  set altura(String altura) {
    _altura = altura;
  }

  set resultado(String resultado) {
    _resultado = resultado;
  }
}
