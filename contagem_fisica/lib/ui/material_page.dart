import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as ppath;
import 'package:path_provider/path_provider.dart';

import '../domain/models.dart';
import '../domain/validacao.dart';
import '../providers/database_provider.dart';
import '../providers/materiais_provider.dart';
import '../providers/sessao_provider.dart';

class MaterialPage extends ConsumerStatefulWidget {
  final String codigo;
  const MaterialPage(this.codigo, {super.key});

  @override
  ConsumerState<MaterialPage> createState() => _MaterialPageState();
}

class _MaterialPageState extends ConsumerState<MaterialPage> {
  final _formKey = GlobalKey<FormState>();
  final _estoqueAntCtrl = TextEditingController();
  final _contadoCtrl = TextEditingController();
  final _recebCtrl = TextEditingController();
  final _obsCtrl = TextEditingController();
  final _justCtrl = TextEditingController();
  final _notaNumCtrl = TextEditingController();
  final _notaQtdCtrl = TextEditingController();

  bool _inicializado = false;
  bool _requerJustificativa = false;
  String? _fotoPath;
  String? _justFotoPath;
  List<NotaRecebimentoDTO> _notas = [];
  StatusItem _status = StatusItem.pendente;
  ItemContagemDTO? _item;
  MaterialDTO? _material;
  ReferenciaMaterialDTO? _ref;
  bool _estoqueAntEditavel = false;

  @override
  void dispose() {
    _estoqueAntCtrl.dispose();
    _contadoCtrl.dispose();
    _recebCtrl.dispose();
    _obsCtrl.dispose();
    _justCtrl.dispose();
    _notaNumCtrl.dispose();
    _notaQtdCtrl.dispose();
    super.dispose();
  }

  void _carregar(ItemContagemDTO? it, ReferenciaMaterialDTO? ref, MaterialDTO mat) {
    _item = it;
    _material = mat;
    _ref = ref;
    final valorRef = ref?.estoqueFinalKg;
    final temItem = it != null;
    final temRef = ref != null;
    if (temItem && it.estoqueAnterior > 0) {
      _estoqueAntCtrl.text = it.estoqueAnterior.toStringAsFixed(2);
      _estoqueAntEditavel = false;
    } else if (temRef) {
      _estoqueAntCtrl.text = valorRef!.toStringAsFixed(2);
      _estoqueAntEditavel = false;
    } else {
      _estoqueAntCtrl.text = '0.00';
      _estoqueAntEditavel = true;
    }
    _contadoCtrl.text = it?.estoqueContado?.toStringAsFixed(2) ?? '';
    _recebCtrl.text = it?.recebimentoTotal?.toStringAsFixed(2) ?? '0';
    _obsCtrl.text = it?.observacao ?? '';
    _justCtrl.text = it?.justificativa ?? '';
    _fotoPath = it?.fotoPath;
    _justFotoPath = it?.justificativaFotoPath;
    _notas = List.of(it?.notas ?? const []);
    _status = it?.status ?? StatusItem.pendente;
    _inicializado = true;
  }

  ItemContagemDTO _itemAtual() {
    final anterior = double.tryParse(_estoqueAntCtrl.text.replaceAll(',', '.')) ?? 0;
    final contado = double.tryParse(_contadoCtrl.text.replaceAll(',', '.'));
    final receb = double.tryParse(_recebCtrl.text.replaceAll(',', '.'));
    return ItemContagemDTO(
      id: _item?.id ?? '',
      sessaoId: _item?.sessaoId ?? '',
      materialCodigo: widget.codigo,
      estoqueAnterior: anterior,
      estoqueContado: contado,
      recebimentoTotal: receb,
      observacao: _obsCtrl.text,
      justificativa: _justCtrl.text,
      justificativaFotoPath: _justFotoPath,
      fotoPath: _fotoPath,
      status: _status,
      timestamp: DateTime.now(),
      notas: _notas,
    );
  }

  Future<void> _tirarFoto(bool isJustificativa) async {
    final picker = ImagePicker();
    final x = await picker.pickImage(source: ImageSource.camera, imageQuality: 70);
    if (x == null) return;
    Directory dir;
    try {
      dir = Directory('/storage/emulated/0/ContagemFisica/fotos');
      await dir.create(recursive: true);
    } catch (_) {
      final appDir = await getApplicationDocumentsDirectory();
      dir = Directory(ppath.join(appDir.path, 'fotos'));
      await dir.create(recursive: true);
    }
    final nome = '${widget.codigo}_${DateTime.now().millisecondsSinceEpoch}.jpg';
    final caminho = ppath.join(dir.path, nome);
    final bytes = await x.readAsBytes();
    await File(caminho).writeAsBytes(bytes);
    setState(() {
      if (isJustificativa) {
        _justFotoPath = caminho;
      } else {
        _fotoPath = caminho;
      }
    });
  }

  void _addNota() {
    final num = _notaNumCtrl.text.trim();
    final qtd = double.tryParse(_notaQtdCtrl.text.replaceAll(',', '.'));
    if (num.isEmpty || qtd == null || qtd < 0) {
      _snack('Informe número e quantidade válida (>= 0).');
      return;
    }
    setState(() {
      _notas = [..._notas, NotaRecebimentoDTO(id: '', numero: num, quantidade: qtd)];
      _notaNumCtrl.clear();
      _notaQtdCtrl.clear();
    });
  }

  void _removeNota(int i) => setState(() => _notas = List.of(_notas)..removeAt(i));

  void _snack(String msg) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  Future<void> _salvar({required bool concluir}) async {
    if (concluir && !_formKey.currentState!.validate()) return;
    final sessao = ref.read(sessaoAtualProvider).valueOrNull;
    if (sessao == null || _material == null) return;

    final anterior = double.tryParse(_estoqueAntCtrl.text.replaceAll(',', '.')) ?? 0;
    final contado = concluir ? double.tryParse(_contadoCtrl.text.replaceAll(',', '.')) : null;
    final receb = concluir ? double.tryParse(_recebCtrl.text.replaceAll(',', '.')) : null;

    final db = ref.read(databaseProvider);
    final itemId = await db.upsertItem(
      sessaoId: sessao.id,
      materialCodigo: widget.codigo,
      estoqueAnterior: anterior,
      estoqueContado: contado,
      recebimentoTotal: receb,
      observacao: _obsCtrl.text,
      justificativa: _justCtrl.text,
      justificativaFotoPath: _justFotoPath,
      fotoPath: _fotoPath,
      status: concluir ? 'pendente' : 'pendente',
    );
    await db.removerNotasDoItem(itemId);
    for (final n in _notas) {
      await db.adicionarNota(
        itemId: itemId,
        numero: n.numero,
        quantidade: n.quantidade,
      );
    }

    if (!concluir) {
      _snack('Parcial salvo.');
      return;
    }

    final item = ItemContagemDTO(
      id: itemId,
      sessaoId: sessao.id,
      materialCodigo: widget.codigo,
      estoqueAnterior: anterior,
      estoqueContado: contado,
      recebimentoTotal: receb,
      observacao: _obsCtrl.text,
      justificativa: _justCtrl.text,
      justificativaFotoPath: _justFotoPath,
      fotoPath: _fotoPath,
      status: StatusItem.pendente,
      timestamp: DateTime.now(),
      notas: _notas,
    );
    final r = validarItem(item, onComplete: true);
    final status = statusResultante(item, r);
    await db.upsertItem(
      sessaoId: sessao.id,
      materialCodigo: widget.codigo,
      estoqueAnterior: anterior,
      estoqueContado: contado,
      recebimentoTotal: receb,
      observacao: _obsCtrl.text,
      justificativa: _justCtrl.text,
      justificativaFotoPath: _justFotoPath,
      fotoPath: _fotoPath,
      status: statusParaDb(status),
    );
    if (r.bloqueado) {
      ref.invalidate(itensSessaoProvider(sessao.id));
      ref.invalidate(resumosFornecedoresProvider(sessao.id));
      _snack(r.avisos.join('\n'));
      return;
    }
    // ao concluir válido, grava referência (última contagem válida)
    if (contado != null) {
      await db.salvarReferencia(
        materialCodigo: widget.codigo,
        estoqueFinalKg: contado,
        sessaoOrigemId: sessao.id,
        dataReferencia: DateTime.now(),
      );
    }
    // invalida providers para contadores refletirem novo status
    ref.invalidate(itensSessaoProvider(sessao.id));
    ref.invalidate(resumosFornecedoresProvider(sessao.id));
    ref.invalidate(referenciaMaterialCompletaProvider(widget.codigo));
    _snack('Material concluído: ${status.label}.');
    if (mounted) context.pop();
  }

  String _fmtData(DateTime d) =>
      '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/'
      '${d.year} ${d.hour.toString().padLeft(2, '0')}:${d.minute.toString().padLeft(2, '0')}';

  @override
  Widget build(BuildContext context) {
    final matAsync = ref.watch(materialPorCodigoProvider(widget.codigo));
    final sessao = ref.watch(sessaoAtualProvider).valueOrNull;
    final itensAsync = sessao == null
        ? const AsyncValue<List<ItemContagemDTO>>.loading()
        : ref.watch(itensSessaoProvider(sessao.id));
    final refAsync = ref.watch(referenciaMaterialCompletaProvider(widget.codigo));

    return Scaffold(
      appBar: AppBar(title: const Text('Contagem do material')),
      body: matAsync.when(
        data: (mat) {
          if (mat == null) return const Center(child: Text('Material não cadastrado.'));
          return itensAsync.when(
            data: (itens) {
              if (!_inicializado) {
                final it = itens.firstWhere(
                  (i) => i.materialCodigo == widget.codigo,
                  orElse: () => ItemContagemDTO(
                    id: '',
                    sessaoId: sessao?.id ?? '',
                    materialCodigo: widget.codigo,
                    estoqueAnterior: refAsync.valueOrNull?.estoqueFinalKg ?? 0,
                    status: StatusItem.pendente,
                    timestamp: DateTime.now(),
                  ),
                );
                _carregar(it, refAsync.valueOrNull, mat);
              }
              return _buildForm(mat);
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(child: Text('Erro: $e')),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Erro: $e')),
      ),
    );
  }

  Widget _buildForm(MaterialDTO mat) {
    final item = _itemAtual();
    final r = validarItem(item, onComplete: true);
    _requerJustificativa = requerJustificativa(item);
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(mat.descricao,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    Text('Código: ${mat.codigo}'),
                    Text('Família: ${mat.familia}  •  Unidade: ${mat.unidade} (fixa)  •  Fornecedor: ${mat.fornecedor}'),
                    const SizedBox(height: 8),
                    if (r.avisos.isNotEmpty)
                      Container(
                        padding: const EdgeInsets.all(8),
                        color: r.bloqueado
                            ? Colors.red.withOpacity(0.15)
                            : Colors.amber.withOpacity(0.15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for (final a in r.avisos) Text('• $a'),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _estoqueAntCtrl,
              readOnly: !_estoqueAntEditavel,
              decoration: InputDecoration(
                labelText: 'Estoque anterior (referência)',
                border: const OutlineInputBorder(),
                helperText: _ref != null
                    ? 'Última contagem em ${_fmtData(_ref!.dataReferencia)}.\n'
                      'Ponderado automaticamente pelo app.'
                    : 'Primeira contagem: digite o estoque inicial '
                      '(em ${mat.unidade}). Próximas contagens usarão '
                      'o saldo automaticamente.',
                suffixText: mat.unidade,
                filled: !_estoqueAntEditavel,
                fillColor: !_estoqueAntEditavel
                    ? Colors.grey.shade100
                    : null,
              ),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _contadoCtrl,
              decoration: InputDecoration(
                labelText: 'Estoque contado (${mat.unidade}) *',
                border: const OutlineInputBorder(),
                suffixText: mat.unidade,
              ),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              validator: (v) {
                final n = double.tryParse(v?.replaceAll(',', '.') ?? '');
                if (n == null) return 'Número inválido';
                if (n < 0) return 'Não pode ser negativo';
                return null;
              },
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _recebCtrl,
              decoration: InputDecoration(
                labelText: 'Recebimento total no período (${mat.unidade}) *',
                border: const OutlineInputBorder(),
                suffixText: mat.unidade,
              ),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              validator: (v) {
                final n = double.tryParse(v?.replaceAll(',', '.') ?? '');
                if (n == null) return 'Número inválido';
                if (n < 0) return 'Não pode ser negativo';
                return null;
              },
            ),
            const SizedBox(height: 12),
            const Text('NFs / GRs', style: TextStyle(fontWeight: FontWeight.bold)),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: TextFormField(
                    controller: _notaNumCtrl,
                    decoration: const InputDecoration(
                      labelText: 'Número',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  flex: 2,
                  child: TextFormField(
                    controller: _notaQtdCtrl,
                    decoration: InputDecoration(
                      labelText: 'Quantidade (${mat.unidade})',
                      border: const OutlineInputBorder(),
                    ),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton.filled(onPressed: _addNota, icon: const Icon(Icons.add)),
              ],
            ),
            if (_notas.isNotEmpty) ...[
              const SizedBox(height: 8),
              for (var i = 0; i < _notas.length; i++)
                ListTile(
                  dense: true,
                  leading: const Icon(Icons.receipt_long),
                  title: Text(_notas[i].numero),
                  subtitle: Text('Qtd: ${_notas[i].quantidade} ${mat.unidade}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => _removeNota(i),
                  ),
                ),
              const Divider(),
              Text('Soma das NFs/GRs: ${item.somaNotas.toStringAsFixed(2)} ${mat.unidade}'),
            ],
            const SizedBox(height: 12),
            TextFormField(
              controller: _obsCtrl,
              decoration: const InputDecoration(
                labelText: 'Observação',
                border: OutlineInputBorder(),
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 8),
            if (_requerJustificativa || r.avisos.any((a) => a.contains('justificada')))
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
const Text('Justificativa de divergência *',
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
                TextFormField(
                  controller: _justCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Explique a divergência',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        icon: const Icon(Icons.photo_camera),
                        label: Text(_justFotoPath == null
                            ? 'Anexar foto (opcional)'
                            : 'Foto anexada'),
                        onPressed: () => _tirarFoto(true),
                      ),
                    ),
                  ],
                ),
                ],
              ),
            const SizedBox(height: 16),
            if (r.bloqueado)
              Container(
                padding: const EdgeInsets.all(8),
                color: Colors.red.withOpacity(0.1),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [for (final a in r.avisos) Text('• $a')],
                ),
              ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.save),
                    label: const Text('Salvar parcial'),
                    onPressed: () => _salvar(concluir: false),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: FilledButton.icon(
                    icon: const Icon(Icons.check),
                    label: const Text('Concluir item'),
                    onPressed: () => _salvar(concluir: true),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}