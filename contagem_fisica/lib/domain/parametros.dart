import 'dart:convert';

import 'package:crypto/crypto.dart';

const String kPinDefault = '0000';
const double kToleranciaPctDefault = 0.02;
const double kToleranciaMinKgDefault = 1.0;
const String kAlertaJanelaDefault = 'diaria';

const Set<String> kAlertaJanelaValores = {'diaria', 'semanal'};

String hashPin(String pinEmTexto) {
  final bytes = utf8.encode(pinEmTexto);
  return sha256.convert(bytes).toString();
}

class ParametrosGlobais {
  final double toleranciaPct;
  final double toleranciaMinKg;
  final String alertaJanela;
  final String pinAdminHash;

  const ParametrosGlobais({
    required this.toleranciaPct,
    required this.toleranciaMinKg,
    required this.alertaJanela,
    required this.pinAdminHash,
  });

  factory ParametrosGlobais.padrao() => const ParametrosGlobais(
        toleranciaPct: kToleranciaPctDefault,
        toleranciaMinKg: kToleranciaMinKgDefault,
        alertaJanela: kAlertaJanelaDefault,
        pinAdminHash: '',
      );
}