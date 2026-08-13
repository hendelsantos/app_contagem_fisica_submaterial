import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/database.dart';
import '../providers/database_provider.dart';
import '../providers/sessao_provider.dart';

class HistoricoPage extends ConsumerStatefulWidget {
  final String codigo;
  const HistoricoPage(this.codigo, {super.key});

  @override
  ConsumerState<HistoricoPage> createState() => _HistoricoPageState();
}

class _HistoricoPageState extends ConsumerState<HistoricoPage> {
  List<ItemHistoricoRow>? _historico;

  @override
  void initState() {
    super.initState();
    _carregar();
  }

  Future<void> _carregar() async {
    final sessao = ref.read(sessaoAtualProvider).valueOrNull;
    if (sessao == null) return;
    final db = ref.read(databaseProvider);
    final h = await db.historicoDoMaterialNaSessao(sessao.id, widget.codigo);
    if (!mounted) return;
    setState(() => _historico = h);
  }

  String _fmt(DateTime d) =>
      '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/'
      '${d.year} ${d.hour.toString().padLeft(2, '0')}:${d.minute.toString().padLeft(2, '0')}';

  String _acaoLabel(String a) {
    switch (a) {
      case 'criado':
        return 'Criado';
      case 'editado':
        return 'Editado';
      default:
        return a;
    }
  }

  Color _acaoCor(String a) {
    switch (a) {
      case 'criado':
        return const Color(0xFF2E7D32);
      case 'editado':
        return const Color(0xFF1565C0);
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Auditoria do item')),
      body: _historico == null
          ? const Center(child: CircularProgressIndicator())
          : _historico!.isEmpty
              ? const Center(
                  child: Padding(
                    padding: EdgeInsets.all(24),
                    child: Text(
                      'Nenhuma edição registrada neste item.\n\n'
                      'Cada vez que o operador salva ou conclui o item, uma entrada é adicionada aqui.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Color(0xFF757575)),
                    ),
                  ),
                )
              : ListView.separated(
                  padding: const EdgeInsets.all(12),
                  itemCount: _historico!.length,
                  separatorBuilder: (_, __) => const Divider(height: 0),
                  itemBuilder: (_, i) {
                    final h = _historico![i];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: _acaoCor(h.acao).withOpacity(0.15),
                        child: Icon(
                          h.acao == 'criado' ? Icons.add : Icons.edit,
                          color: _acaoCor(h.acao),
                        ),
                      ),
                      title: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: _acaoCor(h.acao),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              _acaoLabel(h.acao),
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              h.operadorNome.isEmpty
                                  ? 'Operador'
                                  : h.operadorNome,
                              style: const TextStyle(fontSize: 13),
                            ),
                          ),
                        ],
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(_fmt(h.timestamp),
                                style: const TextStyle(
                                    fontSize: 12, color: Color(0xFF757575))),
                            const SizedBox(height: 4),
                            Wrap(
                              spacing: 10,
                              runSpacing: 2,
                              children: [
                                if (h.estoqueContado != null)
                                  _chip('Contado',
                                      h.estoqueContado!.toStringAsFixed(2)),
                                if (h.recebimentoTotal != null)
                                  _chip('Recebimento',
                                      h.recebimentoTotal!.toStringAsFixed(2)),
                                if (h.estoqueAnterior != null)
                                  _chip('Anterior',
                                      h.estoqueAnterior!.toStringAsFixed(2)),
                                if (h.status != null)
                                  _chip('Status', h.status!,
                                      color: _statusCor(h.status!)),
                              ],
                            ),
                            if (h.justificativa != null &&
                                h.justificativa!.isNotEmpty) ...[
                              const SizedBox(height: 4),
                              Text(
                                'Justificativa: ${h.justificativa}',
                                style: const TextStyle(
                                    fontSize: 12, fontStyle: FontStyle.italic),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }

  Widget _chip(String label, String valor, {Color? color}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
      decoration: BoxDecoration(
        color: (color ?? Colors.grey).withOpacity(0.1),
        border: Border.all(color: (color ?? Colors.grey).withOpacity(0.4)),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        '$label: $valor',
        style: TextStyle(fontSize: 11, color: color ?? Colors.black87),
      ),
    );
  }

  Color _statusCor(String s) {
    switch (s) {
      case 'valido':
        return const Color(0xFF2E7D32);
      case 'alerta':
        return const Color(0xFFFFA000);
      case 'justificado':
        return const Color(0xFF1565C0);
      case 'bloqueado':
        return const Color(0xFFC62828);
      default:
        return Colors.grey;
    }
  }
}
