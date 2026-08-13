import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/database.dart';
import '../domain/parametros.dart';
import '../providers/database_provider.dart';
import '../providers/materiais_provider.dart';
import '../providers/parametros_provider.dart';

class AdminPage extends ConsumerStatefulWidget {
  const AdminPage({super.key});

  @override
  ConsumerState<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends ConsumerState<AdminPage> {
  bool _autenticado = false;
  final _pinCtrl = TextEditingController();
  String? _erroPin;

  @override
  void dispose() {
    _pinCtrl.dispose();
    super.dispose();
  }

  Future<void> _entrar() async {
    final pin = _pinCtrl.text.trim();
    if (pin.isEmpty) {
      setState(() => _erroPin = 'Informe o PIN.');
      return;
    }
    final db = ref.read(databaseProvider);
    final ok = await db.verificarPin(pin);
    if (!mounted) return;
    if (ok) {
      setState(() {
        _autenticado = true;
        _erroPin = null;
        _pinCtrl.clear();
      });
    } else {
      setState(() => _erroPin = 'PIN incorreto.');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_autenticado) return _buildLogin(context);
    return _buildPainel(context);
  }

  Widget _buildLogin(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Área do admin')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 320),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Icon(Icons.lock_outline,
                    size: 64, color: Color(0xFF1565C0)),
                const SizedBox(height: 12),
                const Text(
                  'Digite o PIN administrativo para acessar os parâmetros do app.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _pinCtrl,
                  obscureText: true,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                    labelText: 'PIN',
                    border: const OutlineInputBorder(),
                    errorText: _erroPin,
                  ),
                  onSubmitted: (_) => _entrar(),
                ),
                const SizedBox(height: 12),
                FilledButton.icon(
                  icon: const Icon(Icons.login),
                  label: const Text('Entrar'),
                  onPressed: _entrar,
                ),
                const SizedBox(height: 8),
                Text(
                  'PIN padrão de fábrica: $kPinDefault. Troque após o primeiro acesso.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPainel(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Administração'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Travar admin',
            onPressed: () => setState(() => _autenticado = false),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: const [
          _CardParametrosGlobais(),
          SizedBox(height: 12),
          _CardTrocarPin(),
          SizedBox(height: 12),
          _CardConsumoEsperado(),
          SizedBox(height: 12),
          _CardAlertas(),
          SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _CardParametrosGlobais extends ConsumerStatefulWidget {
  const _CardParametrosGlobais();

  @override
  ConsumerState<_CardParametrosGlobais> createState() =>
      _CardParametrosGlobaisState();
}

class _CardParametrosGlobaisState
    extends ConsumerState<_CardParametrosGlobais> {
  final _pctCtrl = TextEditingController();
  final _minCtrl = TextEditingController();
  String _janela = kAlertaJanelaDefault;
  bool _inicializado = false;
  bool _salvando = false;

  @override
  void dispose() {
    _pctCtrl.dispose();
    _minCtrl.dispose();
    super.dispose();
  }

  Future<void> _salvar() async {
    final pct = double.tryParse(_pctCtrl.text.replaceAll(',', '.'));
    final min = double.tryParse(_minCtrl.text.replaceAll(',', '.'));
    if (pct == null || pct < 0 || pct > 1) {
      _snack('Tolerância % inválida (entre 0 e 1, ex: 0.02).');
      return;
    }
    if (min == null || min < 0) {
      _snack('Tolerância mínima inválida (>= 0).');
      return;
    }
    setState(() => _salvando = true);
    final db = ref.read(databaseProvider);
    await db.salvarParametros(
      toleranciaPct: pct,
      toleranciaMinKg: min,
      alertaJanela: _janela,
    );
    ref.invalidate(parametrosProvider);
    if (!mounted) return;
    setState(() => _salvando = false);
    _snack('Parâmetros salvos.');
  }

  void _snack(String msg) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    final paramsAsync = ref.watch(parametrosProvider);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Parâmetros globais',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 8),
            paramsAsync.when(
              loading: () => const Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Center(child: CircularProgressIndicator()),
              ),
              error: (e, _) => Text('Erro ao carregar: $e'),
              data: (p) {
                if (!_inicializado) {
                  _pctCtrl.text = p.toleranciaPct.toStringAsFixed(2);
                  _minCtrl.text = p.toleranciaMinKg.toStringAsFixed(2);
                  _janela = kAlertaJanelaValores.contains(p.alertaJanela)
                      ? p.alertaJanela
                      : kAlertaJanelaDefault;
                  _inicializado = true;
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: _pctCtrl,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      decoration: const InputDecoration(
                        labelText: 'Tolerância % (fração: 0.02 = 2%)',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _minCtrl,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      decoration: const InputDecoration(
                        labelText: 'Tolerância mínima (Kg/L)',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      value: _janela,
                      decoration: const InputDecoration(
                        labelText: 'Janela de alerta',
                        border: OutlineInputBorder(),
                      ),
                      items: const [
                        DropdownMenuItem(
                            value: 'diaria', child: Text('Diária')),
                        DropdownMenuItem(
                            value: 'semanal', child: Text('Semanal')),
                      ],
                      onChanged: (v) =>
                          setState(() => _janela = v ?? kAlertaJanelaDefault),
                    ),
                    const SizedBox(height: 12),
                    FilledButton.icon(
                      icon: _salvando
                          ? const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(strokeWidth: 2))
                          : const Icon(Icons.save),
                      label: const Text('Salvar parâmetros'),
                      onPressed: _salvando ? null : _salvar,
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _CardTrocarPin extends ConsumerStatefulWidget {
  const _CardTrocarPin();

  @override
  ConsumerState<_CardTrocarPin> createState() => _CardTrocarPinState();
}

class _CardTrocarPinState extends ConsumerState<_CardTrocarPin> {
  final _atualCtrl = TextEditingController();
  final _novoCtrl = TextEditingController();
  final _confCtrl = TextEditingController();
  bool _salvando = false;

  @override
  void dispose() {
    _atualCtrl.dispose();
    _novoCtrl.dispose();
    _confCtrl.dispose();
    super.dispose();
  }

  Future<void> _trocar() async {
    final atual = _atualCtrl.text.trim();
    final novo = _novoCtrl.text.trim();
    final conf = _confCtrl.text.trim();
    if (atual.isEmpty || novo.isEmpty || conf.isEmpty) {
      _snack('Preencha os três campos.');
      return;
    }
    if (novo.length < 4 || !RegExp(r'^[0-9]+$').hasMatch(novo)) {
      _snack('Novo PIN deve ter ao menos 4 dígitos numéricos.');
      return;
    }
    if (novo != conf) {
      _snack('Confirmação não confere com o novo PIN.');
      return;
    }
    setState(() => _salvando = true);
    final db = ref.read(databaseProvider);
    final ok = await db.verificarPin(atual);
    if (!mounted) return;
    if (!ok) {
      setState(() => _salvando = false);
      _snack('PIN atual incorreto.');
      return;
    }
    await db.alterarPin(novo);
    setState(() => _salvando = false);
    _atualCtrl.clear();
    _novoCtrl.clear();
    _confCtrl.clear();
    _snack('PIN alterado.');
  }

  void _snack(String msg) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Trocar PIN admin',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 8),
            TextField(
              controller: _atualCtrl,
              obscureText: true,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: const InputDecoration(
                labelText: 'PIN atual',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _novoCtrl,
              obscureText: true,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: const InputDecoration(
                labelText: 'Novo PIN (mín. 4 dígitos)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _confCtrl,
              obscureText: true,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: const InputDecoration(
                labelText: 'Confirmar novo PIN',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            FilledButton.icon(
              icon: _salvando
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2))
                  : const Icon(Icons.lock_reset),
              label: const Text('Trocar PIN'),
              onPressed: _salvando ? null : _trocar,
            ),
          ],
        ),
      ),
    );
  }
}

class _CardConsumoEsperado extends ConsumerStatefulWidget {
  const _CardConsumoEsperado();

  @override
  ConsumerState<_CardConsumoEsperado> createState() =>
      _CardConsumoEsperadoState();
}

class _CardConsumoEsperadoState extends ConsumerState<_CardConsumoEsperado> {
  final Map<String, TextEditingController> _controllers = {};
  bool _inicializado = false;

  @override
  void dispose() {
    for (final c in _controllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _salvarTudo() async {
    final db = ref.read(databaseProvider);
    for (final entry in _controllers.entries) {
      final codigo = entry.key;
      final txt = entry.value.text.trim();
      final v = double.tryParse(txt.replaceAll(',', '.'));
      if (v == null || v <= 0) {
        await db.removerConsumoEsperado(codigo);
      } else {
        await db.salvarConsumoEsperado(codigo, v);
      }
    }
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Consumo diário esperado salvo.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final matsAsync = ref.watch(todosMateriaisProvider);
    final consumosFut = ref.watch(consumoEsperadoMapProvider);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Consumo diário esperado (Kg/L)',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 4),
            const Text(
              'Deixe em branco para não monitorar. Alertas disparam quando o '
              'consumo real foge de [50%, 150%] do esperado.',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            consumosFut.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Text('Erro: $e'),
              data: (consumos) {
                return matsAsync.when(
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (e, _) => Text('Erro: $e'),
                  data: (mats) {
                    if (!_inicializado) {
                      for (final m in mats) {
                        final v = consumos[m.codigo];
                        final c = TextEditingController(
                            text: v == null ? '' : v.toStringAsFixed(2));
                        _controllers[m.codigo] = c;
                      }
                      _inicializado = true;
                    }
                    return Column(
                      children: [
                        for (final m in mats)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    '${m.descricao}\n${m.codigo} · ${m.fornecedor}',
                                    style: const TextStyle(fontSize: 13),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: TextField(
                                    controller: _controllers[m.codigo],
                                    keyboardType:
                                        const TextInputType.numberWithOptions(
                                            decimal: true),
                                    decoration: const InputDecoration(
                                      labelText: 'Kg/L/dia',
                                      border: OutlineInputBorder(),
                                      isDense: true,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        const SizedBox(height: 8),
                        FilledButton.icon(
                          icon: const Icon(Icons.save),
                          label: const Text('Salvar consumo esperado'),
                          onPressed: _salvarTudo,
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _CardAlertas extends ConsumerWidget {
  const _CardAlertas();

  @override
  Widget build(BuildContext context, ref) {
    final alertas = ref.watch(alertasConsumoProvider);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Alertas de consumo',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 4),
            const Text(
              'Materiais com consumo real fora de [50%, 150%] do esperado '
              'na última sessão finalizada.',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            alertas.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Text('Erro: $e'),
              data: (lista) {
                if (lista.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                        'Nenhum alerta. Cadastre consumo esperado para monitorar.'),
                  );
                }
                return Column(
                  children: [
                    for (final a in lista)
                      ListTile(
                        dense: true,
                        leading: const Icon(Icons.warning_amber,
                            color: Colors.amber),
                        title: Text(a.descricao),
                        subtitle: Text(
                          'Consumo real: ${a.consumoReal.toStringAsFixed(2)} · '
                          'Esperado: ${a.esperado.toStringAsFixed(2)} · '
                          'Ratio: ${(a.ratio * 100).toStringAsFixed(0)}%',
                        ),
                      ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

final consumoEsperadoMapProvider =
    FutureProvider<Map<String, double>>((ref) async {
  final db = ref.watch(databaseProvider);
  final rows = await db.listarConsumoEsperado();
  return {for (final r in rows) r.materialCodigo: r.consumoDiarioKg};
});

class AlertaConsumo {
  final String materialCodigo;
  final String descricao;
  final double consumoReal;
  final double esperado;
  final double ratio;
  const AlertaConsumo({
    required this.materialCodigo,
    required this.descricao,
    required this.consumoReal,
    required this.esperado,
    required this.ratio,
  });
}

final alertasConsumoProvider = FutureProvider<List<AlertaConsumo>>((ref) async {
  final db = ref.watch(databaseProvider);
  final esperados = await ref.watch(consumoEsperadoMapProvider.future);
  if (esperados.isEmpty) return const [];
  final sessoes = await db.listarSessoes();
  SessaoRow? ultima;
  for (final s in sessoes) {
    if (s.status == 'finalizada' || s.status == 'exportada') {
      ultima = s;
      break;
    }
  }
  if (ultima == null) return const [];
  final itens = await db.itensDaSessao(ultima.id);
  final mats = await db.listarMateriais();
  final descPorCodigo = {for (final m in mats) m.codigo: m.descricao};
  final out = <AlertaConsumo>[];
  for (final it in itens) {
    final esp = esperados[it.materialCodigo];
    if (esp == null || esp <= 0) continue;
    final contado = it.estoqueContado;
    if (contado == null) continue;
    final consumoReal =
        it.estoqueAnterior + (it.recebimentoTotal ?? 0) - contado;
    if (consumoReal < 0) continue;
    final ratio = consumoReal / esp;
    if (ratio < 0.5 || ratio > 1.5) {
      out.add(AlertaConsumo(
        materialCodigo: it.materialCodigo,
        descricao: descPorCodigo[it.materialCodigo] ?? it.materialCodigo,
        consumoReal: consumoReal,
        esperado: esp,
        ratio: ratio,
      ));
    }
  }
  out.sort((a, b) => a.ratio.compareTo(b.ratio));
  return out;
});
