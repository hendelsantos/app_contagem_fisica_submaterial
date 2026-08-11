import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../domain/models.dart';
import '../providers/sessao_provider.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final sessao = ref.watch(sessaoAtualProvider).valueOrNull;
    final resumos = sessao == null
        ? const AsyncValue<List<ResumoFornecedor>>.loading()
        : ref.watch(resumosFornecedoresProvider(sessao.id));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Contagem Física'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Encerrar sessão',
            onPressed: () async {
              await ref.read(sessaoAtualProvider.notifier).limpar();
              if (context.mounted) context.go('/');
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (sessao != null)
            Padding(
              padding: const EdgeInsets.all(12),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    'Operador: ${sessao.operadorNome} (${sessao.operadorMatricula})\n'
                    'Início: ${_fmt(sessao.dataInicio)}  |  Fim previsto: ${_fmt(sessao.dataFimPrevista ?? sessao.dataInicio)}',
                  ),
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.summarize),
                    label: const Text('Resumo'),
                    onPressed: () => context.push('/resumo'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: FilledButton.icon(
                    icon: const Icon(Icons.file_download),
                    label: const Text('Exportar'),
                    onPressed: () => context.push('/export'),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: resumos.when(
              data: (lista) => ListView(
                children: [
                  for (final r in lista) _CardFornecedor(resumo: r),
                ],
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('Erro: $e')),
            ),
          ),
        ],
      ),
    );
  }

  String _fmt(DateTime d) => '${d.day}/${d.month}/${d.year} ${d.hour.toString().padLeft(2, '0')}:${d.minute.toString().padLeft(2, '0')}';
}

class _CardFornecedor extends StatelessWidget {
  final ResumoFornecedor resumo;
  const _CardFornecedor({required this.resumo});

  @override
  Widget build(BuildContext context) {
    final concluido = resumo.concluido && resumo.contados == resumo.totalMateriais;
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: concluido
              ? Colors.green
              : resumo.bloqueados > 0
                  ? Colors.red
                  : resumo.pendentes > 0
                      ? Colors.amber
                      : Colors.blue,
          child: const Icon(Icons.factory, color: Colors.white),
        ),
        title: Text(resumo.fornecedor, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(
            'Total: ${resumo.totalMateriais} | Contados: ${resumo.contados} | Pendentes: ${resumo.pendentes} | Alertas: ${resumo.comAlerta} | Bloqueios: ${resumo.bloqueados}'),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => context.push('/fornecedor/${resumo.fornecedor}'),
      ),
    );
  }
}