import 'dart:io';

import 'package:contagem_fisica/data/seed.dart';
import 'package:contagem_fisica/data/tables.dart';
import 'package:contagem_fisica/domain/parametros.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'database.g.dart';

@DriftDatabase(tables: [
  Materiais,
  Fornecedores,
  EstoqueReferencia,
  Sessoes,
  ItensContagem,
  NotasRecebimento,
  Exports,
  ItensHistorico,
  Parametros,
  ConsumoEsperado,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_open());

  AppDatabase.forTesting(super.e);

  @override
  int get schemaVersion => 4;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
          await _semear();
          await _semearParametros();
        },
        onUpgrade: (m, from, to) async {
          if (from < 2) {
            await customStatement(
              "UPDATE materiais SET unidade = 'L' WHERE fornecedor = 'Axalta'",
            );
          }
          if (from < 3) {
            await m.createTable(itensHistorico);
          }
          if (from < 4) {
            await m.createTable(parametros);
            await m.createTable(consumoEsperado);
            await _semearParametros();
          }
        },
        beforeOpen: (details) async {
          if (details.wasCreated) return;
          await _garantirSeed();
          await _garantirParametros();
        },
      );

  Future<void> _semearParametros() async {
    await into(parametros).insert(ParametrosCompanion(
      id: const Value(1),
      toleranciaPct: const Value(kToleranciaPctDefault),
      toleranciaMinKg: const Value(kToleranciaMinKgDefault),
      alertaJanela: const Value(kAlertaJanelaDefault),
      pinAdminHash: Value(hashPin(kPinDefault)),
    ));
  }

  Future<void> _garantirParametros() async {
    final r = await (select(parametros)..where((t) => t.id.equals(1)))
        .getSingleOrNull();
    if (r == null) await _semearParametros();
  }

  Future<void> _semear() async {
    await batch((b) {
      b.insertAll(fornecedores, [
        for (var i = 0; i < kFornecedoresOrdem.length; i++)
          FornecedoresCompanion(
            nome: Value(kFornecedoresOrdem[i]),
            ordem: Value(i),
          ),
      ]);
      b.insertAll(materiais, [
        for (final m in kMateriaisSeed)
          MateriaisCompanion(
            codigo: Value(m.codigo),
            descricao: Value(m.descricao),
            fornecedor: Value(m.fornecedor),
            familia: Value(m.familia),
            unidade: Value(m.unidade),
            sobeSap: Value(m.sobeSap),
            ativo: const Value(true),
            nomeStock: Value(m.nomeStock),
          ),
      ]);
    });
  }

  Future<void> _garantirSeed() async {
    final total = await materiais.count().getSingle();
    if (total == 0) await _semear();
  }

  Future<List<MaterialCadastro>> listarMateriais({String? fornecedor}) {
    final q = select(materiais)
      ..orderBy([(t) => OrderingTerm.asc(t.descricao)]);
    if (fornecedor != null) {
      q.where((t) => t.fornecedor.equals(fornecedor) & t.ativo.equals(true));
    } else {
      q.where((t) => t.ativo.equals(true));
    }
    return q.get();
  }

  Future<MaterialCadastro?> materialPorCodigo(String codigo) {
    return (select(materiais)..where((t) => t.codigo.equals(codigo)))
        .getSingleOrNull();
  }

  Future<EstoqueReferenciaRow?> referenciaDoMaterial(String codigo) {
    return (select(estoqueReferencia)
          ..where((t) => t.materialCodigo.equals(codigo)))
        .getSingleOrNull();
  }

  Future<void> salvarReferencia({
    required String materialCodigo,
    required double estoqueFinalKg,
    String? sessaoOrigemId,
    required DateTime dataReferencia,
  }) async {
    await into(estoqueReferencia).insertOnConflictUpdate(
      EstoqueReferenciaCompanion(
        materialCodigo: Value(materialCodigo),
        estoqueFinalKg: Value(estoqueFinalKg),
        sessaoOrigemId: Value(sessaoOrigemId),
        dataReferencia: Value(dataReferencia),
      ),
    );
  }

  Future<SessaoRow?> sessaoPorId(String id) {
    return (select(sessoes)..where((t) => t.id.equals(id))).getSingleOrNull();
  }

  Future<List<SessaoRow>> listarSessoes() {
    return (select(sessoes)..orderBy([(t) => OrderingTerm.desc(t.dataInicio)]))
        .get();
  }

  Future<String> criarSessao({
    required String operadorNome,
    required String operadorMatricula,
    required DateTime dataInicio,
    DateTime? dataFimPrevista,
    required String versaoCadastro,
    String? aparelho,
  }) async {
    final id = DateTime.now().millisecondsSinceEpoch.toString();
    await into(sessoes).insert(SessoesCompanion(
      id: Value(id),
      operadorNome: Value(operadorNome),
      operadorMatricula: Value(operadorMatricula),
      dataInicio: Value(dataInicio),
      dataFimPrevista: Value(dataFimPrevista),
      status: const Value('em_andamento'),
      versaoCadastro: Value(versaoCadastro),
      aparelho: Value(aparelho),
    ));
    return id;
  }

  Future<void> finalizarSessao(String id, DateTime dataFimReal) async {
    await (update(sessoes)..where((t) => t.id.equals(id))).write(
      SessoesCompanion(
          status: const Value('finalizada'), dataFimReal: Value(dataFimReal)),
    );
  }

  Future<void> marcarSessaoExportada(String id) async {
    await (update(sessoes)..where((t) => t.id.equals(id))).write(
      const SessoesCompanion(status: Value('exportada')),
    );
  }

  Future<List<ItemContagemRow>> itensDaSessao(String sessaoId) {
    return (select(itensContagem)..where((t) => t.sessaoId.equals(sessaoId)))
        .get();
  }

  Future<ItemContagemRow?> itemDaSessaoPorMaterial(
      String sessaoId, String materialCodigo) {
    return (select(itensContagem)
          ..where((t) =>
              t.sessaoId.equals(sessaoId) &
              t.materialCodigo.equals(materialCodigo)))
        .getSingleOrNull();
  }

  Future<String> upsertItem({
    required String sessaoId,
    required String materialCodigo,
    required double estoqueAnterior,
    double? estoqueContado,
    double? recebimentoTotal,
    String? observacao,
    String? justificativa,
    String? justificativaFotoPath,
    String? fotoPath,
    required String status,
    DateTime? timestamp,
    String? operadorNome,
  }) async {
    final existente = await itemDaSessaoPorMaterial(sessaoId, materialCodigo);
    final agora = timestamp ?? DateTime.now();
    if (existente == null) {
      final id =
          '${sessaoId}_${materialCodigo}_${agora.millisecondsSinceEpoch}';
      await into(itensContagem).insert(ItensContagemCompanion(
        id: Value(id),
        sessaoId: Value(sessaoId),
        materialCodigo: Value(materialCodigo),
        estoqueAnterior: Value(estoqueAnterior),
        estoqueContado: Value(estoqueContado),
        recebimentoTotal: Value(recebimentoTotal),
        observacao: Value(observacao),
        justificativa: Value(justificativa),
        justificativaFotoPath: Value(justificativaFotoPath),
        fotoPath: Value(fotoPath),
        status: Value(status),
        timestamp: Value(agora),
      ));
      await _registrarHistorico(
        itemId: id,
        sessaoId: sessaoId,
        materialCodigo: materialCodigo,
        acao: 'criado',
        operadorNome: operadorNome,
        estoqueAnterior: estoqueAnterior,
        estoqueContado: estoqueContado,
        recebimentoTotal: recebimentoTotal,
        status: status,
        observacao: observacao,
        justificativa: justificativa,
        timestamp: agora,
      );
      return id;
    }
    final houveMudanca = existente.estoqueContado != estoqueContado ||
        existente.recebimentoTotal != recebimentoTotal ||
        existente.estoqueAnterior != estoqueAnterior ||
        existente.status != status ||
        existente.observacao != observacao ||
        existente.justificativa != justificativa;
    await (update(itensContagem)..where((t) => t.id.equals(existente.id)))
        .write(
      ItensContagemCompanion(
        estoqueAnterior: Value(estoqueAnterior),
        estoqueContado: Value(estoqueContado),
        recebimentoTotal: Value(recebimentoTotal),
        observacao: Value(observacao),
        justificativa: Value(justificativa),
        justificativaFotoPath: Value(justificativaFotoPath),
        fotoPath: Value(fotoPath),
        status: Value(status),
        timestamp: Value(agora),
      ),
    );
    if (houveMudanca) {
      await _registrarHistorico(
        itemId: existente.id,
        sessaoId: sessaoId,
        materialCodigo: materialCodigo,
        acao: 'editado',
        operadorNome: operadorNome,
        estoqueAnterior: estoqueAnterior,
        estoqueContado: estoqueContado,
        recebimentoTotal: recebimentoTotal,
        status: status,
        observacao: observacao,
        justificativa: justificativa,
        timestamp: agora,
      );
    }
    return existente.id;
  }

  Future<void> _registrarHistorico({
    required String itemId,
    required String sessaoId,
    required String materialCodigo,
    required String acao,
    String? operadorNome,
    double? estoqueAnterior,
    double? estoqueContado,
    double? recebimentoTotal,
    String? status,
    String? observacao,
    String? justificativa,
    required DateTime timestamp,
  }) async {
    final id =
        '${itemId}_hist_${timestamp.microsecondsSinceEpoch}_${acao.hashCode.abs()}';
    await into(itensHistorico).insert(ItensHistoricoCompanion(
      id: Value(id),
      itemId: Value(itemId),
      sessaoId: Value(sessaoId),
      materialCodigo: Value(materialCodigo),
      acao: Value(acao),
      operadorNome: Value(operadorNome ?? ''),
      estoqueAnterior: Value(estoqueAnterior),
      estoqueContado: Value(estoqueContado),
      recebimentoTotal: Value(recebimentoTotal),
      status: Value(status),
      observacao: Value(observacao),
      justificativa: Value(justificativa),
      timestamp: Value(timestamp),
    ));
  }

  Future<List<ItemHistoricoRow>> historicoDoItem(String itemId) {
    return (select(itensHistorico)
          ..where((t) => t.itemId.equals(itemId))
          ..orderBy([(t) => OrderingTerm.desc(t.timestamp)]))
        .get();
  }

  Future<List<ItemHistoricoRow>> historicoDoMaterialNaSessao(
      String sessaoId, String materialCodigo) {
    return (select(itensHistorico)
          ..where((t) =>
              t.sessaoId.equals(sessaoId) &
              t.materialCodigo.equals(materialCodigo))
          ..orderBy([(t) => OrderingTerm.desc(t.timestamp)]))
        .get();
  }

  Future<List<NotaRecebimentoRow>> notasDoItem(String itemId) {
    return (select(notasRecebimento)..where((t) => t.itemId.equals(itemId)))
        .get();
  }

  Future<void> adicionarNota({
    required String itemId,
    required String numero,
    required double quantidade,
    DateTime? dataRecebimento,
    String? fotoPath,
  }) async {
    final id = '${itemId}_nota_${DateTime.now().microsecondsSinceEpoch}';
    await into(notasRecebimento).insert(NotasRecebimentoCompanion(
      id: Value(id),
      itemId: Value(itemId),
      numero: Value(numero),
      quantidade: Value(quantidade),
      dataRecebimento: Value(dataRecebimento),
      fotoPath: Value(fotoPath),
    ));
  }

  Future<void> removerNota(String id) async {
    await (delete(notasRecebimento)..where((t) => t.id.equals(id))).go();
  }

  Future<void> removerNotasDoItem(String itemId) async {
    await (delete(notasRecebimento)..where((t) => t.itemId.equals(itemId)))
        .go();
  }

  Future<void> registrarExport({
    required String sessaoId,
    String? caminhoExcel,
    String? caminhoPdf,
  }) async {
    final id = '${sessaoId}_exp_${DateTime.now().millisecondsSinceEpoch}';
    await into(exports).insert(ExportsCompanion(
      id: Value(id),
      sessaoId: Value(sessaoId),
      caminhoExcel: Value(caminhoExcel),
      caminhoPdf: Value(caminhoPdf),
      timestamp: Value(DateTime.now()),
    ));
  }

  Future<ParametrosRow> obterParametros() {
    return (select(parametros)..where((t) => t.id.equals(1))).getSingle();
  }

  Future<void> salvarParametros({
    required double toleranciaPct,
    required double toleranciaMinKg,
    required String alertaJanela,
  }) async {
    await (update(parametros)..where((t) => t.id.equals(1))).write(
      ParametrosCompanion(
        toleranciaPct: Value(toleranciaPct),
        toleranciaMinKg: Value(toleranciaMinKg),
        alertaJanela: Value(alertaJanela),
      ),
    );
  }

  Future<bool> verificarPin(String pinEmTexto) async {
    final r = await obterParametros();
    return r.pinAdminHash == hashPin(pinEmTexto);
  }

  Future<void> alterarPin(String novoPinEmTexto) async {
    await (update(parametros)..where((t) => t.id.equals(1))).write(
      ParametrosCompanion(pinAdminHash: Value(hashPin(novoPinEmTexto))),
    );
  }

  Future<void> salvarConsumoEsperado(
      String materialCodigo, double consumoDiarioKg) async {
    await into(consumoEsperado).insertOnConflictUpdate(
      ConsumoEsperadoCompanion(
        materialCodigo: Value(materialCodigo),
        consumoDiarioKg: Value(consumoDiarioKg),
      ),
    );
  }

  Future<void> removerConsumoEsperado(String materialCodigo) async {
    await (delete(consumoEsperado)
          ..where((t) => t.materialCodigo.equals(materialCodigo)))
        .go();
  }

  Future<double?> consumoEsperadoDoMaterial(String materialCodigo) async {
    final r = await (select(consumoEsperado)
          ..where((t) => t.materialCodigo.equals(materialCodigo)))
        .getSingleOrNull();
    return r?.consumoDiarioKg;
  }

  Future<List<ConsumoEsperadoRow>> listarConsumoEsperado() {
    return (select(consumoEsperado)).get();
  }
}

LazyDatabase _open() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'contagem_fisica.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
