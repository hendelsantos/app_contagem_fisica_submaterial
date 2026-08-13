import 'package:contagem_fisica/domain/models.dart';
import 'package:contagem_fisica/providers/database_provider.dart';
import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final fornecedoresProvider = FutureProvider<List<String>>((ref) async {
  final db = ref.watch(databaseProvider);
  final rows = await (db.select(db.fornecedores)
        ..orderBy([(t) => OrderingTerm.asc(t.ordem)]))
      .get();
  return rows.map((r) => r.nome).toList();
});

final materiaisPorFornecedorProvider =
    FutureProvider.family<List<MaterialDTO>, String>((ref, fornecedor) async {
  final db = ref.watch(databaseProvider);
  final rows = await db.listarMateriais(fornecedor: fornecedor);
  return rows
      .map((m) => MaterialDTO(
            codigo: m.codigo,
            descricao: m.descricao,
            fornecedor: m.fornecedor,
            familia: m.familia,
            unidade: m.unidade,
            sobeSap: m.sobeSap,
            nomeStock: m.nomeStock,
          ))
      .toList();
});

final todosMateriaisProvider = FutureProvider<List<MaterialDTO>>((ref) async {
  final db = ref.watch(databaseProvider);
  final rows = await db.listarMateriais();
  return rows
      .map((m) => MaterialDTO(
            codigo: m.codigo,
            descricao: m.descricao,
            fornecedor: m.fornecedor,
            familia: m.familia,
            unidade: m.unidade,
            sobeSap: m.sobeSap,
            nomeStock: m.nomeStock,
          ))
      .toList();
});

final materialPorCodigoProvider =
    FutureProvider.family<MaterialDTO?, String>((ref, codigo) async {
  final db = ref.watch(databaseProvider);
  final m = await db.materialPorCodigo(codigo);
  if (m == null) return null;
  return MaterialDTO(
    codigo: m.codigo,
    descricao: m.descricao,
    fornecedor: m.fornecedor,
    familia: m.familia,
    unidade: m.unidade,
    sobeSap: m.sobeSap,
    nomeStock: m.nomeStock,
  );
});

final referenciaMaterialProvider =
    FutureProvider.family<double?, String>((ref, codigo) async {
  final db = ref.watch(databaseProvider);
  final r = await db.referenciaDoMaterial(codigo);
  return r?.estoqueFinalKg;
});

final referenciaMaterialCompletaProvider =
    FutureProvider.family<ReferenciaMaterialDTO?, String>((ref, codigo) async {
  final db = ref.watch(databaseProvider);
  final r = await db.referenciaDoMaterial(codigo);
  if (r == null) return null;
  return ReferenciaMaterialDTO(
    materialCodigo: r.materialCodigo,
    estoqueFinalKg: r.estoqueFinalKg,
    dataReferencia: r.dataReferencia,
    sessaoOrigemId: r.sessaoOrigemId,
  );
});
