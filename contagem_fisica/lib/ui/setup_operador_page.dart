import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../providers/sessao_provider.dart';

class SetupOperadorPage extends ConsumerStatefulWidget {
  const SetupOperadorPage({super.key});

  @override
  ConsumerState<SetupOperadorPage> createState() => _SetupOperadorPageState();
}

class _SetupOperadorPageState extends ConsumerState<SetupOperadorPage> {
  final _formKey = GlobalKey<FormState>();
  final _nomeCtrl = TextEditingController();
  final _matriculaCtrl = TextEditingController();
  DateTime _inicio = DateTime.now();
  DateTime _fimPrevisto = DateTime.now().add(const Duration(hours: 8));

  @override
  void dispose() {
    _nomeCtrl.dispose();
    _matriculaCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickDateTime(bool isInicio) async {
    final d = await showDatePicker(
      context: context,
      initialDate: isInicio ? _inicio : _fimPrevisto,
      firstDate: DateTime(2024),
      lastDate: DateTime(2100),
    );
    if (d == null) return;
    if (!mounted) return;
    final t = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(isInicio ? _inicio : _fimPrevisto),
    );
    if (t == null) return;
    final dt = DateTime(d.year, d.month, d.day, t.hour, t.minute);
    setState(() {
      if (isInicio) {
        _inicio = dt;
      } else {
        _fimPrevisto = dt;
      }
    });
  }

  Future<void> _iniciar() async {
    if (!_formKey.currentState!.validate()) return;
    if (!_fimPrevisto.isAfter(_inicio)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('A data/hora final precisa ser depois do início.')),
      );
      return;
    }
    await ref.read(sessaoAtualProvider.notifier).iniciar(
          operadorNome: _nomeCtrl.text.trim(),
          operadorMatricula: _matriculaCtrl.text.trim(),
          dataInicio: _inicio,
          dataFimPrevista: _fimPrevisto,
        );
    if (mounted) context.go('/home');
  }

  @override
  Widget build(BuildContext context) {
    final fmt = DateFormat('dd/MM/yyyy HH:mm');
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
                'Informe os dados do operador e o período da contagem.',
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
              const SizedBox(height: 12),
              TextFormField(
                controller: _matriculaCtrl,
                decoration: const InputDecoration(
                  labelText: 'Matrícula *',
                  border: OutlineInputBorder(),
                ),
                validator: (v) =>
                    v == null || v.trim().isEmpty ? 'Obrigatório' : null,
              ),
              const SizedBox(height: 16),
              ListTile(
                title: const Text('Início da contagem'),
                subtitle: Text(fmt.format(_inicio)),
                trailing: const Icon(Icons.event),
                onTap: () => _pickDateTime(true),
              ),
              ListTile(
                title: const Text('Fim previsto'),
                subtitle: Text(fmt.format(_fimPrevisto)),
                trailing: const Icon(Icons.event),
                onTap: () => _pickDateTime(false),
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
