import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../domain/models.dart';
import '../providers/sessao_provider.dart';

class SetupOperadorPage extends ConsumerStatefulWidget {
  const SetupOperadorPage({super.key});

  @override
  ConsumerState<SetupOperadorPage> createState() => _SetupOperadorPageState();
}

class _SetupOperadorPageState extends ConsumerState<SetupOperadorPage> {
  final _formKey = GlobalKey<FormState>();
  final _nomeCtrl = TextEditingController();

  @override
  void dispose() {
    _nomeCtrl.dispose();
    super.dispose();
  }

  Future<void> _iniciar() async {
    if (!_formKey.currentState!.validate()) return;
    final agora = DateTime.now();
    await ref.read(sessaoAtualProvider.notifier).iniciar(
          operadorNome: _nomeCtrl.text.trim(),
          operadorMatricula: '',
          dataInicio: agora,
          dataFimPrevista: null,
        );
    if (mounted) context.go('/home');
  }

  Future<void> _retomar(String sessaoId) async {
    await ref.read(sessaoAtualProvider.notifier).retomar(sessaoId);
    if (mounted) context.go('/home');
  }

  @override
  Widget build(BuildContext context) {
    final sessoesAsync = ref.watch(sessoesEmAndamentoProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Início da contagem'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: 'Admin',
            onPressed: () => context.push('/admin'),
          ),
          IconButton(
            icon: const Icon(Icons.info_outline),
            tooltip: 'Sobre o app',
            onPressed: () => context.push('/sobre'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const Text(
                'Informe o nome do operador. Os horários serão registrados pela hora do celular.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _nomeCtrl,
                decoration: const InputDecoration(
                  labelText: 'Nome do operador *',
                  border: OutlineInputBorder(),
                ),
                validator: (v) =>
                    v == null || v.trim().isEmpty ? 'Obrigatório' : null,
              ),
              const SizedBox(height: 24),
              FilledButton.icon(
                icon: const Icon(Icons.play_arrow),
                label: const Text('Iniciar contagem'),
                onPressed: _iniciar,
              ),
              const SizedBox(height: 24),
              sessoesAsync.when(
                data: (sessoes) {
                  if (sessoes.isEmpty) return const SizedBox.shrink();
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'Sessões em andamento',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      for (final sessao in sessoes)
                        _SessaoEmAndamentoCard(
                          sessao: sessao,
                          onRetomar: () => _retomar(sessao.id),
                        ),
                    ],
                  );
                },
                loading: () => const SizedBox.shrink(),
                error: (e, _) => Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    'Erro ao carregar sessões: $e',
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SessaoEmAndamentoCard extends StatelessWidget {
  final SessaoDTO sessao;
  final VoidCallback onRetomar;

  const _SessaoEmAndamentoCard({
    required this.sessao,
    required this.onRetomar,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const CircleAvatar(
          child: Icon(Icons.history),
        ),
        title: Text(_operador(sessao)),
        subtitle: Text('Iniciada em ${_fmt(sessao.dataInicio)}'),
        trailing: FilledButton(
          onPressed: onRetomar,
          child: const Text('Retomar'),
        ),
      ),
    );
  }

  String _fmt(DateTime d) =>
      '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/'
      '${d.year} ${d.hour.toString().padLeft(2, '0')}:${d.minute.toString().padLeft(2, '0')}';

  String _operador(SessaoDTO sessao) {
    final matricula = sessao.operadorMatricula.trim();
    if (matricula.isEmpty) return sessao.operadorNome;
    return '${sessao.operadorNome} ($matricula)';
  }
}
