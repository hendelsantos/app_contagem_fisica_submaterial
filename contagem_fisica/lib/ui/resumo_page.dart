import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../domain/models.dart';
import '../providers/materiais_provider.dart';
import '../providers/sessao_provider.dart';

class ResumoPage extends ConsumerWidget {
  const ResumoPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final sessao = ref.watch(sessaoAtualProvider).valueOrNull;
    if (sessao == null) {
      return const Scaffold(body: Center(child: Text('Sem sessão.')));
    }
    final materiais =
        ref.watch(todosMateriaisProvider).valueOrNull ?? const <MaterialDTO>[];
    final itensAsync = ref.watch(itensSessaoProvider(sessao.id));
    final resumos =
        ref.watch(resumosFornecedoresProvider(sessao.id)).valueOrNull ??
            const <ResumoFornecedor>[];

    return Scaffold(
      appBar: AppBar(title: const Text('Resumo da contagem')),
      body: itensAsync.when(
        data: (itens) {
          final byCodigo = {for (final i in itens) i.materialCodigo: i};
          final pendentes = materiais.where((m) {
            final it = byCodigo[m.codigo];
            final st = it?.status ?? StatusItem.pendente;
            return st == StatusItem.pendente || st == StatusItem.bloqueado;
          }).toList();
          final todosConcluidos = pendentes.isEmpty;
          final divergencias = itens.where((i) =>
              i.status == StatusItem.alerta ||
              i.status == StatusItem.justificado ||
              i.status == StatusItem.bloqueado);

          return ListView(
            padding: const EdgeInsets.all(12),
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Operador: ${_operador(sessao)}'),
                      Text(
                          'Materiais: ${materiais.length} | Itens contados: ${itens.length}'),
                      Text('Divergências: ${divergencias.length}'),
                      if (!todosConcluidos)
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                              '${pendentes.length} materiais pendentes/bloqueados.',
                              style: const TextStyle(color: Colors.red)),
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),
              const Text('Fornecedores',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              for (final r in resumos)
                ListTile(
                  title: Text(r.fornecedor),
                  subtitle: Text('contados ${r.contados}/${r.totalMateriais} / '
                      'pendentes ${r.pendentes} / alertas ${r.comAlerta} / bloqueios ${r.bloqueados}'),
                  trailing: r.concluido && r.contados == r.totalMateriais
                      ? const Icon(Icons.check_circle, color: Colors.green)
                      : const Icon(Icons.pending, color: Colors.amber),
                ),
              const SizedBox(height: 8),
              const Text('Pendentes/bloqueados',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              if (pendentes.isEmpty) const Text('Nenhum.'),
              for (final m in pendentes)
                ListTile(
                  leading: const Icon(Icons.warning, color: Colors.red),
                  title: Text(m.descricao),
                  subtitle: Text(
                      '${m.codigo} • ${byCodigo[m.codigo]?.status.label ?? StatusItem.pendente.label}'),
                  onTap: () => context.push('/material/${m.codigo}'),
                ),
              const SizedBox(height: 16),
              FilledButton.icon(
                icon: const Icon(Icons.file_download),
                label: const Text('Ir para exportação'),
                onPressed:
                    todosConcluidos ? () => context.push('/export') : null,
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Erro: $e')),
      ),
    );
  }

  String _operador(SessaoDTO sessao) {
    final matricula = sessao.operadorMatricula.trim();
    if (matricula.isEmpty) return sessao.operadorNome;
    return '${sessao.operadorNome} ($matricula)';
  }
}
