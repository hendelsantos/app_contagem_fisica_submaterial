import 'package:contagem_fisica/data/database.dart';
import 'package:contagem_fisica/domain/models.dart';
import 'package:contagem_fisica/providers/database_provider.dart';
import 'package:contagem_fisica/providers/materiais_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SessaoAtual extends AsyncNotifier<SessaoDTO?> {
  @override
  Future<SessaoDTO?> build() async => null;

  Future<String> iniciar({
    required String operadorNome,
    required String operadorMatricula,
    required DateTime dataInicio,
    DateTime? dataFimPrevista,
    String? aparelho,
  }) async {
    final db = ref.read(databaseProvider);
    final id = await db.criarSessao(
      operadorNome: operadorNome,
      operadorMatricula: operadorMatricula,
      dataInicio: dataInicio,
      dataFimPrevista: dataFimPrevista,
      versaoCadastro: 'seed-v1',
      aparelho: aparelho,
    );
    state = AsyncData(SessaoDTO(
      id: id,
      operadorNome: operadorNome,
      operadorMatricula: operadorMatricula,
      dataInicio: dataInicio,
      dataFimPrevista: dataFimPrevista,
      status: 'em_andamento',
      versaoCadastro: 'seed-v1',
      aparelho: aparelho,
    ));
    ref.invalidate(sessoesEmAndamentoProvider);
    return id;
  }

  Future<void> retomar(String sessaoId) async {
    final db = ref.read(databaseProvider);
    final sessao = await db.sessaoPorId(sessaoId);
    if (sessao == null) throw StateError('Sessão não encontrada.');
    if (sessao.status != 'em_andamento') {
      throw StateError('Apenas sessões em andamento podem ser retomadas.');
    }
    state = AsyncData(_sessaoDto(sessao));
  }

  Future<void> finalizar() async {
    final s = state.value;
    if (s == null) return;
    final db = ref.read(databaseProvider);
    await db.finalizarSessao(s.id, DateTime.now());
    state = AsyncData(SessaoDTO(
      id: s.id,
      operadorNome: s.operadorNome,
      operadorMatricula: s.operadorMatricula,
      dataInicio: s.dataInicio,
      dataFimPrevista: s.dataFimPrevista,
      dataFimReal: DateTime.now(),
      status: 'finalizada',
      versaoCadastro: s.versaoCadastro,
      aparelho: s.aparelho,
    ));
  }

  Future<void> limpar() async {
    state = const AsyncData(null);
    ref.invalidate(sessoesEmAndamentoProvider);
  }
}

final sessaoAtualProvider =
    AsyncNotifierProvider<SessaoAtual, SessaoDTO?>(SessaoAtual.new);

final itensSessaoProvider =
    FutureProvider.family<List<ItemContagemDTO>, String>((ref, sessaoId) async {
  final db = ref.read(databaseProvider);
  final itens = await db.itensDaSessao(sessaoId);
  final List<ItemContagemDTO> out = [];
  for (final it in itens) {
    final notas = await db.notasDoItem(it.id);
    out.add(ItemContagemDTO(
      id: it.id,
      sessaoId: it.sessaoId,
      materialCodigo: it.materialCodigo,
      estoqueAnterior: it.estoqueAnterior,
      estoqueContado: it.estoqueContado,
      linhaEstoque: it.linhaEstoque,
      containers: db.containersFromJson(it.containersJson),
      cubaEstoque: it.cubaEstoque,
      outrosEstoque: it.outrosEstoque,
      recebimentoTotal: it.recebimentoTotal,
      observacao: it.observacao,
      justificativa: it.justificativa,
      justificativaFotoPath: it.justificativaFotoPath,
      fotoPath: it.fotoPath,
      status: _parseStatus(it.status),
      timestamp: it.timestamp,
      notas: notas
          .map((n) => NotaRecebimentoDTO(
                id: n.id,
                numero: n.numero,
                quantidade: n.quantidade,
                dataRecebimento: n.dataRecebimento,
                fotoPath: n.fotoPath,
              ))
          .toList(),
    ));
  }
  return out;
});

final sessoesEmAndamentoProvider = FutureProvider<List<SessaoDTO>>((ref) async {
  final db = ref.read(databaseProvider);
  final sessoes = await db.listarSessoes();
  return sessoes
      .where((s) => s.status == 'em_andamento')
      .map(_sessaoDto)
      .toList();
});

SessaoDTO _sessaoDto(SessaoRow s) => SessaoDTO(
      id: s.id,
      operadorNome: s.operadorNome,
      operadorMatricula: s.operadorMatricula,
      dataInicio: s.dataInicio,
      dataFimPrevista: s.dataFimPrevista,
      dataFimReal: s.dataFimReal,
      status: s.status,
      versaoCadastro: s.versaoCadastro,
      aparelho: s.aparelho,
    );

StatusItem _parseStatus(String s) {
  switch (s) {
    case 'valido':
      return StatusItem.valido;
    case 'alerta':
      return StatusItem.alerta;
    case 'justificado':
      return StatusItem.justificado;
    case 'bloqueado':
      return StatusItem.bloqueado;
    default:
      return StatusItem.pendente;
  }
}

String statusParaDb(StatusItem s) {
  switch (s) {
    case StatusItem.valido:
      return 'valido';
    case StatusItem.alerta:
      return 'alerta';
    case StatusItem.justificado:
      return 'justificado';
    case StatusItem.bloqueado:
      return 'bloqueado';
    case StatusItem.pendente:
      return 'pendente';
  }
}

/// Resumo por fornecedor considerando sessão atual.
final resumosFornecedoresProvider =
    FutureProvider.family<List<ResumoFornecedor>, String>(
        (ref, sessaoId) async {
  final fornecedores = await ref.watch(fornecedoresProvider.future);
  final itens = await ref.watch(itensSessaoProvider(sessaoId).future);
  final db = ref.read(databaseProvider);
  final out = <ResumoFornecedor>[];
  for (final f in fornecedores) {
    final mats = await db.listarMateriais(fornecedor: f);
    final codigos = mats.map((m) => m.codigo).toSet();
    final itensF =
        itens.where((i) => codigos.contains(i.materialCodigo)).toList();
    final naoPendentes =
        itensF.where((i) => i.status != StatusItem.pendente).length;
    out.add(ResumoFornecedor(
      fornecedor: f,
      totalMateriais: mats.length,
      contados: naoPendentes,
      pendentes: mats.length - naoPendentes,
      comAlerta: itensF.where((i) => i.status == StatusItem.alerta).length,
      bloqueados: itensF.where((i) => i.status == StatusItem.bloqueado).length,
    ));
  }
  return out;
});
