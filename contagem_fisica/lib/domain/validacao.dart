import 'package:contagem_fisica/domain/models.dart';
import 'package:contagem_fisica/domain/parametros.dart';

/// Tolerância: max(pct% do estoque anterior, mínimo configurado em Kg/L)
/// Conforme item 6.4 do plano. Os parâmetros vêm do admin (tabela `parametros`).
double toleranciaAumento(
  double estoqueAnterior, {
  double pct = kToleranciaPctDefault,
  double minKg = kToleranciaMinKgDefault,
}) {
  final abs = estoqueAnterior.abs();
  final pctValue = abs * pct;
  return pctValue > minKg ? pctValue : minKg;
}

enum TipoBloqueio {
  estoqueNegativo,
  recebimentoNegativo,
  notaNegativa,
  semNota,
  somaNotasDiferente,
  aumentoSemRecebimento,
}

class ResultadoValidacao {
  final bool ok;
  final List<TipoBloqueio> bloqueios;
  final List<String> avisos;
  final double aumentoSemRecebimento;

  const ResultadoValidacao({
    required this.ok,
    required this.bloqueios,
    required this.avisos,
    required this.aumentoSemRecebimento,
  });

  bool get bloqueado => bloqueios.isNotEmpty;
}

/// Valida o item de contagem conforme as regras anti-erro (item 6 do plano).
/// onComplete define se está tentando concluir o material (true) ou apenas
/// salvando parcial (false).
ResultadoValidacao validarItem(
  ItemContagemDTO item, {
  bool onComplete = true,
  ParametrosGlobais? params,
}) {
  final p = params ?? ParametrosGlobais.padrao();
  final blocos = <TipoBloqueio>[];
  final avisos = <String>[];

  if (onComplete) {
    if (item.estoqueContado == null) {
      blocos.add(TipoBloqueio.estoqueNegativo);
      avisos.add('Estoque contado é obrigatório.');
    }
    if (item.recebimentoTotal == null) {
      blocos.add(TipoBloqueio.estoqueNegativo);
      avisos.add('Recebimento é obrigatório (pode ser 0).');
    }
  }

  final contado = item.estoqueContado;
  final receb = item.recebimentoTotal;

  if (contado != null && contado < 0) {
    blocos.add(TipoBloqueio.estoqueNegativo);
    avisos.add('Estoque contado não pode ser negativo.');
  }
  if (receb != null && receb < 0) {
    blocos.add(TipoBloqueio.recebimentoNegativo);
    avisos.add('Recebimento não pode ser negativo.');
  }
  for (final n in item.notas) {
    if (n.quantidade < 0) {
      blocos.add(TipoBloqueio.notaNegativa);
      avisos.add('Quantidade da NF/GR ${n.numero} não pode ser negativa.');
    }
  }

  if (onComplete && receb != null && receb > 0) {
    final soma = item.somaNotas;
    if (item.notas.isEmpty) {
      blocos.add(TipoBloqueio.semNota);
      avisos.add('Recebimento > 0 exige ao menos uma NF/GR.');
    } else if ((soma - receb).abs() > 0.01) {
      blocos.add(TipoBloqueio.somaNotasDiferente);
      avisos.add(
          'Soma das NFs/GRs (${soma.toStringAsFixed(2)}) não bate com Recebimento (${receb.toStringAsFixed(2)}).');
    }
  }

  var aumentoSemRecebimento = 0.0;
  if (onComplete && contado != null && receb != null) {
    final aumento = contado - item.estoqueAnterior - receb;
    final tol = toleranciaAumento(
      item.estoqueAnterior,
      pct: p.toleranciaPct,
      minKg: p.toleranciaMinKg,
    );
    if (aumento > tol) {
      aumentoSemRecebimento = aumento;
      final justificado =
          (item.justificativa != null && item.justificativa!.trim().isNotEmpty);
      avisos.add(
          'Estoque aumentou ${aumento.toStringAsFixed(2)} sem recebimento registrado. Tolerância: ${tol.toStringAsFixed(2)}.');
      if (!justificado) {
        blocos.add(TipoBloqueio.aumentoSemRecebimento);
      } else {
        avisos.add('Divergência justificada com observação (foto opcional).');
      }
    }
  }

  return ResultadoValidacao(
    ok: blocos.isEmpty,
    bloqueios: blocos,
    avisos: avisos,
    aumentoSemRecebimento: aumentoSemRecebimento,
  );
}

/// Indica quando a justificativa textual é recomendada/exigida (item 6.8):
/// - há aumento sem recebimento;
/// - há consumo fisicamente impossível (negativo);
/// - já existe justificativa preenchida.
/// A foto torna-se opcional — apenas a observação escrita é exigida para
/// considerar a divergência justificada.
bool requerJustificativa(ItemContagemDTO item, {ParametrosGlobais? params}) {
  final p = params ?? ParametrosGlobais.padrao();
  final contado = item.estoqueContado;
  final receb = item.recebimentoTotal;
  if (contado == null || receb == null) return false;
  final aumento = contado - item.estoqueAnterior - receb;
  final tol = toleranciaAumento(
    item.estoqueAnterior,
    pct: p.toleranciaPct,
    minKg: p.toleranciaMinKg,
  );
  if (aumento > tol) return true;
  final consumo = item.consumoFisicoEstimado;
  if (consumo < 0) return true;
  if (item.justificativa != null && item.justificativa!.trim().isNotEmpty)
    return true;
  return false;
}

StatusItem statusResultante(ItemContagemDTO item, ResultadoValidacao r) {
  if (item.estoqueContado == null || item.recebimentoTotal == null) {
    return StatusItem.pendente;
  }
  if (r.bloqueado) return StatusItem.bloqueado;
  if (r.avisos.isNotEmpty && r.avisos.any((a) => a.contains('justificada'))) {
    return StatusItem.justificado;
  }
  if (r.avisos.isNotEmpty) return StatusItem.alerta;
  return StatusItem.valido;
}
