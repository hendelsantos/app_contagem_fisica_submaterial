import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

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

  @override
  Widget build(BuildContext context) {
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
            ],
          ),
        ),
      ),
    );
  }
}
