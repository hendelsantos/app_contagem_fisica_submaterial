import 'dart:io';

import 'package:contagem_fisica/domain/models.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class GeradorPdf {
  static final _fmt = DateFormat('dd/MM/yyyy HH:mm');

  Future<File> gerar({
    required SessaoDTO sessao,
    required List<ItemContagemDTO> itens,
    required List<MaterialDTO> materiais,
  }) async {
    final matByCodigo = {for (final m in materiais) m.codigo: m};
    final doc = pw.Document();

    doc.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (ctx) => [
          pw.Header(
            level: 0,
            child: pw.Text('Relatório de Auditoria — Contagem Física',
                style:
                    pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
          ),
          pw.Paragraph(text: 'Operador: ${_operador(sessao)}'),
          pw.Paragraph(
              text: 'Início pelo celular: ${_fmt.format(sessao.dataInicio)}'),
          pw.Paragraph(
              text:
                  'Fim: ${sessao.dataFimReal != null ? _fmt.format(sessao.dataFimReal!) : '-'}'),
          pw.SizedBox(height: 12),
          pw.TableHelper.fromTextArray(
            headerAlignment: pw.Alignment.centerLeft,
            cellAlignment: pw.Alignment.centerLeft,
            headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
            cellStyle: const pw.TextStyle(fontSize: 8),
            headers: [
              'Fornecedor',
              'Material',
              'Anterior',
              'Estratificação',
              'Receb.',
              'Contado',
              'Status',
              'Horário'
            ],
            data: [
              for (final it in itens)
                [
                  matByCodigo[it.materialCodigo]?.fornecedor ?? '',
                  matByCodigo[it.materialCodigo]?.descricao ??
                      it.materialCodigo,
                  it.estoqueAnterior.toStringAsFixed(2),
                  _estratificacao(it),
                  (it.recebimentoTotal ?? 0).toStringAsFixed(2),
                  (it.temEstratificacao
                          ? it.totalEstratificado
                          : (it.estoqueContado ?? 0))
                      .toStringAsFixed(2),
                  it.status.label,
                  _fmt.format(it.timestamp),
                ],
            ],
          ),
          pw.SizedBox(height: 16),
          pw.Header(level: 1, child: pw.Text('Divergências justificadas')),
          ...itens
              .where((i) =>
                  i.justificativa != null && i.justificativa!.trim().isNotEmpty)
              .map((i) => pw.Paragraph(
                    text:
                        '${matByCodigo[i.materialCodigo]?.descricao ?? i.materialCodigo}: ${i.justificativa}',
                  )),
        ],
      ),
    );

    final bytes = await doc.save();
    final dir = await getApplicationDocumentsDirectory();
    final nome =
        'auditoria_${sessao.id}_${DateTime.now().millisecondsSinceEpoch}.pdf';
    final file = File(p.join(dir.path, 'exports', nome));
    await file.parent.create(recursive: true);
    await file.writeAsBytes(bytes);
    return file;
  }

  String _operador(SessaoDTO sessao) {
    final matricula = sessao.operadorMatricula.trim();
    if (matricula.isEmpty) return sessao.operadorNome;
    return '${sessao.operadorNome} ($matricula)';
  }

  String _estratificacao(ItemContagemDTO item) {
    if (!item.temEstratificacao) return '-';
    final partes = <String>[];
    if (item.linhaEstoque != null) {
      partes.add('Linha ${item.linhaEstoque!.toStringAsFixed(2)}');
    }
    for (var i = 0; i < item.containers.length; i++) {
      final value = item.containers[i];
      if (value != 0) partes.add('C${i + 1} ${value.toStringAsFixed(2)}');
    }
    if (item.cubaEstoque != null) {
      partes.add('Cuba ${item.cubaEstoque!.toStringAsFixed(2)}');
    }
    if (item.outrosEstoque != null) {
      partes.add('Outros ${item.outrosEstoque!.toStringAsFixed(2)}');
    }
    return partes.join(' / ');
  }
}
