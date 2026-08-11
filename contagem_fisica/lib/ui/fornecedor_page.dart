import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../domain/models.dart';
import '../providers/materiais_provider.dart';
import '../providers/sessao_provider.dart';

class FornecedorPage extends ConsumerWidget {
  final String fornecedor;
  const FornecedorPage(this.fornecedor, {super.key});

  @override
  Widget build(BuildContext context, ref) {
    final sessao = ref.watch(sessaoAtualProvider).valueOrNull;
    final materialesAsync = ref.watch(materiaisPorFornecedorProvider(fornecedor));
    final itensAsync = sessao == null
        ? const AsyncValue<List<ItemContagemDTO>>.loading()
        : ref.watch(itensSessaoProvider(sessao.id));

    return Scaffold(
      appBar: AppBar(title: Text('Estoque $fornecedor')),
      body: materialesAsync.when(
        data: (materiais) => itensAsync.when(
          data: (itens) {
            final byCodigo = {for (final i in itens) i.materialCodigo: i};
            return ListView.builder(
              itemCount: materiais.length,
              itemBuilder: (c, idx) {
                final m = materiais[idx];
                final it = byCodigo[m.codigo];
                final status = it?.status ?? StatusItem.pendente;
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: _color(status),
                    child: Text('${idx + 1}', style: const TextStyle(color: Colors.white)),
                  ),
                  title: Text(m.descricao),
                  subtitle: Text('${m.codigo} • ${m.familia} • ${m.unidade} • ${status.label}'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => context.push('/material/${m.codigo}'),
                );
              },
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('Erro: $e')),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Erro: $e')),
      ),
    );
  }

  Color _color(StatusItem s) {
    switch (s) {
      case StatusItem.valido:
        return Colors.green;
      case StatusItem.alerta:
        return Colors.amber;
      case StatusItem.justificado:
        return Colors.blue;
      case StatusItem.bloqueado:
        return Colors.red;
      case StatusItem.pendente:
        return Colors.grey;
    }
  }
}