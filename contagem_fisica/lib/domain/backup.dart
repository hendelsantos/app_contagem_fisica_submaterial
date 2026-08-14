import 'dart:convert';
import 'dart:io';

import 'package:contagem_fisica/data/database.dart';
import 'package:drift/drift.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class BackupData {
  final int versao;
  final DateTime data;
  final Map<String, List<Map<String, dynamic>>> tabelas;
  const BackupData({
    required this.versao,
    required this.data,
    required this.tabelas,
  });

  Map<String, dynamic> toJson() => {
        'versao': versao,
        'data': data.toIso8601String(),
        'tabelas': tabelas,
      };

  factory BackupData.fromJson(Map<String, dynamic> j) => BackupData(
        versao: (j['versao'] as num?)?.toInt() ?? 1,
        data: DateTime.tryParse(j['data'] as String? ?? '') ?? DateTime.now(),
        tabelas: (j['tabelas'] as Map<String, dynamic>?)?.map(
              (k, v) => MapEntry(
                k,
                (v as List)
                    .map((e) => Map<String, dynamic>.from(e as Map))
                    .toList(),
              ),
            ) ??
            const {},
      );
}

const int kVersaoBackup = 2;

Future<File> exportarBackup(AppDatabase db) async {
  final materiais = await db.select(db.materiais).get();
  final fornecedores = await db.select(db.fornecedores).get();
  final refs = await db.select(db.estoqueReferencia).get();
  final sessoes = await db.select(db.sessoes).get();
  final itens = await db.select(db.itensContagem).get();
  final notas = await db.select(db.notasRecebimento).get();
  final exports = await db.select(db.exports).get();
  final historico = await db.select(db.itensHistorico).get();

  final backup = BackupData(
    versao: kVersaoBackup,
    data: DateTime.now(),
    tabelas: {
      'materiais': materiais.map((r) => r.toJson()).toList(),
      'fornecedores': fornecedores.map((r) => r.toJson()).toList(),
      'estoque_referencia': refs.map((r) => r.toJson()).toList(),
      'sessoes': sessoes.map((r) => r.toJson()).toList(),
      'itens_contagem': itens.map((r) => r.toJson()).toList(),
      'notas_recebimento': notas.map((r) => r.toJson()).toList(),
      'exports': exports.map((r) => r.toJson()).toList(),
      'itens_historico': historico.map((r) => r.toJson()).toList(),
    },
  );

  final dir = await getApplicationDocumentsDirectory();
  final backupsDir = Directory(p.join(dir.path, 'backups'));
  if (!await backupsDir.exists()) {
    await backupsDir.create(recursive: true);
  }
  final ts =
      DateTime.now().toIso8601String().replaceAll(':', '-').split('.').first;
  final arquivo = File(p.join(backupsDir.path, 'backup_contagem_$ts.json'));
  await arquivo.writeAsString(
      const JsonEncoder.withIndent('  ').convert(backup.toJson()));
  return arquivo;
}

Future<BackupResumoImport> importarBackup(AppDatabase db, File arquivo) async {
  final conteudo = await arquivo.readAsString();
  final json = jsonDecode(conteudo) as Map<String, dynamic>;
  final backup = BackupData.fromJson(json);

  await db.transaction(() async {
    await db.customStatement('DELETE FROM itens_historico');
    await db.customStatement('DELETE FROM notas_recebimento');
    await db.customStatement('DELETE FROM itens_contagem');
    await db.customStatement('DELETE FROM exports');
    await db.customStatement('DELETE FROM sessoes');
    await db.customStatement('DELETE FROM estoque_referencia');
    await db.customStatement('DELETE FROM materiais');
    await db.customStatement('DELETE FROM fornecedores');

    await db.batch((b) {
      final mats = backup.tabelas['materiais'] ?? const [];
      for (final m in mats) {
        b.insert(db.materiais, _materiaisFromJson(m));
      }
      final forns = backup.tabelas['fornecedores'] ?? const [];
      for (final f in forns) {
        b.insert(db.fornecedores, _fornecedoresFromJson(f));
      }
      final refs = backup.tabelas['estoque_referencia'] ?? const [];
      for (final r in refs) {
        b.insert(db.estoqueReferencia, _refsFromJson(r));
      }
      final sess = backup.tabelas['sessoes'] ?? const [];
      for (final s in sess) {
        b.insert(db.sessoes, _sessoesFromJson(s));
      }
      final its = backup.tabelas['itens_contagem'] ?? const [];
      for (final i in its) {
        b.insert(db.itensContagem, _itensFromJson(i));
      }
      final nts = backup.tabelas['notas_recebimento'] ?? const [];
      for (final n in nts) {
        b.insert(db.notasRecebimento, _notasFromJson(n));
      }
      final exs = backup.tabelas['exports'] ?? const [];
      for (final e in exs) {
        b.insert(db.exports, _exportsFromJson(e));
      }
      final hist = backup.tabelas['itens_historico'] ?? const [];
      for (final h in hist) {
        b.insert(db.itensHistorico, _historicoFromJson(h));
      }
    });
  });

  return BackupResumoImport(
    sessoes: (backup.tabelas['sessoes'] ?? const []).length,
    itens: (backup.tabelas['itens_contagem'] ?? const []).length,
    notas: (backup.tabelas['notas_recebimento'] ?? const []).length,
    dataBackup: backup.data,
  );
}

MateriaisCompanion _materiaisFromJson(Map<String, dynamic> j) =>
    MateriaisCompanion(
      codigo: Value(j['codigo'] as String),
      descricao: Value(j['descricao'] as String),
      fornecedor: Value(j['fornecedor'] as String),
      familia: Value(j['familia'] as String),
      unidade: Value(j['unidade'] as String),
      sobeSap: Value((j['sobeSap'] as num?)?.toInt() ?? 1),
      ativo: Value((j['ativo'] as bool?) ?? true),
      nomeStock: Value(j['nomeStock'] as String),
    );

FornecedoresCompanion _fornecedoresFromJson(Map<String, dynamic> j) =>
    FornecedoresCompanion(
      nome: Value(j['nome'] as String),
      ordem: Value((j['ordem'] as num).toInt()),
    );

EstoqueReferenciaCompanion _refsFromJson(Map<String, dynamic> j) =>
    EstoqueReferenciaCompanion(
      materialCodigo: Value(j['materialCodigo'] as String),
      estoqueFinalKg: Value((j['estoqueFinalKg'] as num).toDouble()),
      sessaoOrigemId: Value(j['sessaoOrigemId'] as String?),
      dataReferencia: Value(_parseDate(j['dataReferencia'])!),
    );

SessoesCompanion _sessoesFromJson(Map<String, dynamic> j) => SessoesCompanion(
      id: Value(j['id'] as String),
      operadorNome: Value(j['operadorNome'] as String),
      operadorMatricula: Value(j['operadorMatricula'] as String),
      dataInicio: Value(_parseDate(j['dataInicio'])!),
      dataFimPrevista: Value(_parseDate(j['dataFimPrevista'] as String?)),
      dataFimReal: Value(_parseDate(j['dataFimReal'] as String?)),
      status: Value(j['status'] as String),
      versaoCadastro: Value(j['versaoCadastro'] as String),
      aparelho: Value(j['aparelho'] as String?),
    );

ItensContagemCompanion _itensFromJson(Map<String, dynamic> j) =>
    ItensContagemCompanion(
      id: Value(j['id'] as String),
      sessaoId: Value(j['sessaoId'] as String),
      materialCodigo: Value(j['materialCodigo'] as String),
      estoqueAnterior: Value((j['estoqueAnterior'] as num).toDouble()),
      estoqueContado: Value((j['estoqueContado'] as num?)?.toDouble()),
      linhaEstoque: Value((j['linhaEstoque'] as num?)?.toDouble()),
      containersJson: Value(j['containersJson'] as String?),
      cubaEstoque: Value((j['cubaEstoque'] as num?)?.toDouble()),
      outrosEstoque: Value((j['outrosEstoque'] as num?)?.toDouble()),
      recebimentoTotal: Value((j['recebimentoTotal'] as num?)?.toDouble()),
      observacao: Value(j['observacao'] as String?),
      justificativa: Value(j['justificativa'] as String?),
      justificativaFotoPath: Value(j['justificativaFotoPath'] as String?),
      fotoPath: Value(j['fotoPath'] as String?),
      status: Value(j['status'] as String),
      timestamp: Value(_parseDate(j['timestamp'])!),
    );

NotasRecebimentoCompanion _notasFromJson(Map<String, dynamic> j) =>
    NotasRecebimentoCompanion(
      id: Value(j['id'] as String),
      itemId: Value(j['itemId'] as String),
      numero: Value(j['numero'] as String),
      quantidade: Value((j['quantidade'] as num).toDouble()),
      dataRecebimento: Value(_parseDate(j['dataRecebimento'] as String?)),
      fotoPath: Value(j['fotoPath'] as String?),
    );

ExportsCompanion _exportsFromJson(Map<String, dynamic> j) => ExportsCompanion(
      id: Value(j['id'] as String),
      sessaoId: Value(j['sessaoId'] as String),
      caminhoExcel: Value(j['caminhoExcel'] as String?),
      caminhoPdf: Value(j['caminhoPdf'] as String?),
      timestamp: Value(_parseDate(j['timestamp'])!),
    );

ItensHistoricoCompanion _historicoFromJson(Map<String, dynamic> j) =>
    ItensHistoricoCompanion(
      id: Value(j['id'] as String),
      itemId: Value(j['itemId'] as String),
      sessaoId: Value(j['sessaoId'] as String),
      materialCodigo: Value(j['materialCodigo'] as String),
      acao: Value(j['acao'] as String),
      operadorNome: Value(j['operadorNome'] as String? ?? ''),
      estoqueAnterior: Value((j['estoqueAnterior'] as num?)?.toDouble()),
      estoqueContado: Value((j['estoqueContado'] as num?)?.toDouble()),
      recebimentoTotal: Value((j['recebimentoTotal'] as num?)?.toDouble()),
      status: Value(j['status'] as String?),
      observacao: Value(j['observacao'] as String?),
      justificativa: Value(j['justificativa'] as String?),
      timestamp: Value(_parseDate(j['timestamp'])!),
    );

DateTime? _parseDate(dynamic v) {
  if (v == null) return null;
  if (v is DateTime) return v;
  if (v is String) return DateTime.tryParse(v);
  if (v is num) return DateTime.fromMillisecondsSinceEpoch(v.toInt());
  return null;
}

class BackupResumoImport {
  final int sessoes;
  final int itens;
  final int notas;
  final DateTime dataBackup;
  const BackupResumoImport({
    required this.sessoes,
    required this.itens,
    required this.notas,
    required this.dataBackup,
  });
}
