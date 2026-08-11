import 'dart:io';

import 'package:contagem_fisica/domain/models.dart';
import 'package:excel/excel.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

/// Gera um Excel compatível com `core/importers.py::importar_stock_operador`
/// do Streamlit HMB, mais uma aba extra de auditoria.
class GeradorExcel {
  static const _estoqueSheets = [
    'Estoque Henkel',
    'Estoque PPG',
    'Estoque Shinsung',
    'Estoque Wax',
    'Estoque Axalta',
  ];

  static const _qtdContainers = 6;
  static final _fmtData = DateFormat('dd/MM/yyyy');

  String _sheetFornecedor(String sheet) => sheet.replaceFirst('Estoque ', '');

  Future<File> gerar({
    required SessaoDTO sessao,
    required List<ItemContagemDTO> itens,
    required List<MaterialDTO> materiais,
  }) async {
    final excel = Excel.createExcel();
    final defaultSheet = excel.getDefaultSheet();
    if (defaultSheet != null) excel.delete(defaultSheet);

    final porFornecedor = <String, List<_Entrada>>{};
    for (final m in materiais) {
      final it = itens.firstWhere(
        (i) => i.materialCodigo == m.codigo,
        orElse: () => ItemContagemDTO(
          id: '',
          sessaoId: sessao.id,
          materialCodigo: m.codigo,
          estoqueAnterior: 0,
          status: StatusItem.pendente,
          timestamp: DateTime.now(),
        ),
      );
      porFornecedor.putIfAbsent(m.fornecedor, () => []);
      porFornecedor[m.fornecedor]!.add(_Entrada(m, it));
    }

    for (final sheet in _estoqueSheets) {
      final ws = excel[sheet];
      _escreverSheetFornecedor(ws, _sheetFornecedor(sheet), porFornecedor, sessao);
    }

    _escreverAuditoria(excel, sessao, itens, materiais);

    final bytes = excel.save();
    final dir = await getApplicationDocumentsDirectory();
    final nome = 'contagem_${sessao.id}_${DateTime.now().millisecondsSinceEpoch}.xlsx';
    final file = File(p.join(dir.path, 'exports', nome));
    await file.parent.create(recursive: true);
    await file.writeAsBytes(bytes!);
    return file;
  }

  CellIndex _ci(String ref) => CellIndex.indexByString(ref);

  void _escreverSheetFornecedor(
    Sheet ws,
    String fornecedor,
    Map<String, List<_Entrada>> porFornecedor,
    SessaoDTO sessao,
  ) {
    // A1 = "Data" mesclado verticalmente (A1:A3) para compat com layout original
    ws.cell(_ci('A1')).value = TextCellValue('Data');
    ws.merge(_ci('A1'), _ci('A3'));

    final mats = porFornecedor[fornecedor] ?? const <_Entrada>[];
    var col = 2;
    for (final entry in mats) {
      col = _escreverBloco(ws, entry, sessao, col);
    }
  }

  int _escreverBloco(Sheet ws, _Entrada entry, SessaoDTO sessao, int colInicio) {
    final m = entry.material;
    final it = entry.item;
    final totalCol = colInicio + _qtdContainers;
    final sistCol = totalCol + 1;
    final recebCol = sistCol + 1;
    final colFim = recebCol;

    // Linha 1: nome mesclado
    ws.cell(_ci('${_col(colInicio)}1')).value = TextCellValue(m.nomeStock);
    ws.merge(_ci('${_col(colInicio)}1'), _ci('${_col(colFim)}1'));

    // Linha 2: sub-cabeçalhos
    ws.cell(_ci('${_col(colInicio)}2')).value = TextCellValue('Inventário (Containers)');
    ws.merge(_ci('${_col(colInicio)}2'), _ci('${_col(colInicio + _qtdContainers - 1)}2'));
    ws.cell(_ci('${_col(totalCol)}2')).value = TextCellValue('Total (KG)');
    ws.cell(_ci('${_col(sistCol)}2')).value = TextCellValue('Estoque sistêmico');
    ws.cell(_ci('${_col(recebCol)}2')).value = TextCellValue('Recebimentos');

    // Linha 3: numeração containers
    for (var i = 0; i < _qtdContainers; i++) {
      ws.cell(_ci('${_col(colInicio + i)}3')).value = IntCellValue(i + 1);
    }

    final recebTotal = it.recebimentoTotal ?? 0.0;
    final contado = it.estoqueContado ?? 0.0;
    final dataInicio = sessao.dataInicio;
    final dataFim = sessao.dataFimReal ?? DateTime.now();

    const rowAbertura = 4;
    const rowFechamento = 5;

    ws.cell(_ci('A$rowAbertura')).value = TextCellValue(_fmtData.format(dataInicio));
    ws.cell(_ci('${_col(totalCol)}$rowAbertura')).value = DoubleCellValue(it.estoqueAnterior);
    ws.cell(_ci('${_col(recebCol)}$rowAbertura')).value = DoubleCellValue(0.0);

    ws.cell(_ci('A$rowFechamento')).value = TextCellValue(_fmtData.format(dataFim));
    ws.cell(_ci('${_col(totalCol)}$rowFechamento')).value = DoubleCellValue(contado);
    ws.cell(_ci('${_col(sistCol)}$rowFechamento')).value = DoubleCellValue(0.0);
    ws.cell(_ci('${_col(recebCol)}$rowFechamento')).value = DoubleCellValue(recebTotal);

    return colFim + 1;
  }

  void _escreverAuditoria(
    Excel excel,
    SessaoDTO sessao,
    List<ItemContagemDTO> itens,
    List<MaterialDTO> materiais,
  ) {
    const sheetName = 'Auditoria App';
    final ws = excel[sheetName];
    final cabecalho = [
      'operador',
      'matricula',
      'data_contagem',
      'fornecedor',
      'material_codigo',
      'material_descricao',
      'estoque_anterior',
      'estoque_contado',
      'recebimento_total',
      'soma_nf',
      'notas_nf_gr',
      'status',
      'justificativa',
      'foto',
      'timestamp_item',
    ];
    ws.appendRow(cabecalho.map((c) => TextCellValue(c)).toList());
    final matByCodigo = {for (final m in materiais) m.codigo: m};
    for (final it in itens) {
      final m = matByCodigo[it.materialCodigo];
      ws.appendRow([
        TextCellValue(sessao.operadorNome),
        TextCellValue(sessao.operadorMatricula),
        TextCellValue(sessao.dataInicio.toIso8601String()),
        TextCellValue(m?.fornecedor ?? ''),
        TextCellValue(it.materialCodigo),
        TextCellValue(m?.descricao ?? ''),
        DoubleCellValue(it.estoqueAnterior),
        DoubleCellValue(it.estoqueContado ?? 0),
        DoubleCellValue(it.recebimentoTotal ?? 0),
        DoubleCellValue(it.somaNotas),
        TextCellValue(it.notas.map((n) => '${n.numero}:${n.quantidade}').join('; ')),
        TextCellValue(it.status.label),
        TextCellValue(it.justificativa ?? ''),
        TextCellValue(it.fotoPath ?? it.justificativaFotoPath ?? ''),
        TextCellValue(it.timestamp.toIso8601String()),
      ]);
    }
  }

  String _col(int index) {
    var s = '';
    var n = index;
    while (n > 0) {
      final mod = (n - 1) % 26;
      s = String.fromCharCode(65 + mod) + s;
      n = (n - 1) ~/ 26;
    }
    return s;
  }
}

class _Entrada {
  final MaterialDTO material;
  final ItemContagemDTO item;
  const _Entrada(this.material, this.item);
}