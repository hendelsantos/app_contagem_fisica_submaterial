import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as ppath;
import 'package:path_provider/path_provider.dart';

import '../domain/models.dart';
import '../domain/parametros.dart';
import '../domain/validacao.dart';
import '../providers/database_provider.dart';
import '../providers/materiais_provider.dart';
import '../providers/parametros_provider.dart';
import '../providers/sessao_provider.dart';

class _EstoquePadraoMaterial {
  final String label;
  final String campo;
  final double valor;

  const _EstoquePadraoMaterial({
    required this.label,
    required this.campo,
    required this.valor,
  });
}

const Map<String, List<_EstoquePadraoMaterial>> _estoquesPadraoPorMaterial = {
  'GB24020120109A074': [
    _EstoquePadraoMaterial(label: 'BANHO', campo: 'linha', valor: 6271),
  ],
  'GB25020120109A104': [
    _EstoquePadraoMaterial(label: 'BANHO', campo: 'linha', valor: 650),
  ],
  'GB24020120109A105': [
    _EstoquePadraoMaterial(label: 'BANHO', campo: 'linha', valor: 21),
  ],
  'GB25020120518A061': [
    _EstoquePadraoMaterial(label: 'BANHO', campo: 'linha', valor: 6000),
  ],
  'GB24020120518A062': [
    _EstoquePadraoMaterial(label: 'BANHO', campo: 'linha', valor: 81),
  ],
  'GB23020130802A072': [
    _EstoquePadraoMaterial(label: 'BANHO', campo: 'linha', valor: 90000),
  ],
  'GB23020130802A073': [
    _EstoquePadraoMaterial(label: 'BANHO', campo: 'linha', valor: 10500),
  ],
  'GB24020130313A017': [
    _EstoquePadraoMaterial(label: 'Cuba', campo: 'cuba', valor: 360),
  ],
  'GB23020121120A149': [
    _EstoquePadraoMaterial(label: 'Tubulação', campo: 'outros', valor: 300),
  ],
  'GB230201901240002': [
    _EstoquePadraoMaterial(label: 'Tubulação', campo: 'outros', valor: 300),
  ],
  'GB230201901240001': [
    _EstoquePadraoMaterial(label: 'Tubulação', campo: 'outros', valor: 300),
  ],
  'GB23020121120A137': [
    _EstoquePadraoMaterial(label: 'Tubulação', campo: 'outros', valor: 300),
  ],
  'GB230201901240014': [
    _EstoquePadraoMaterial(label: 'Tubulação', campo: 'outros', valor: 300),
  ],
  'GB230201901240010': [
    _EstoquePadraoMaterial(label: 'Tubulação', campo: 'outros', valor: 300),
  ],
  'GB230201901240009': [
    _EstoquePadraoMaterial(label: 'Tubulação', campo: 'outros', valor: 300),
  ],
  'GB230201901240008': [
    _EstoquePadraoMaterial(label: 'Tubulação', campo: 'outros', valor: 300),
  ],
  'GB230201504090010': [
    _EstoquePadraoMaterial(label: 'Tubulação', campo: 'outros', valor: 300),
  ],
  'GB230202511100002': [
    _EstoquePadraoMaterial(label: 'Tubulação', campo: 'outros', valor: 300),
  ],
  'GB23020120510A132': [
    _EstoquePadraoMaterial(label: 'Tubulação', campo: 'outros', valor: 300),
  ],
  'GB230201411250004': [
    _EstoquePadraoMaterial(label: 'Tubulação', campo: 'outros', valor: 300),
  ],
  'GB230201411250003': [
    _EstoquePadraoMaterial(label: 'Tubulação', campo: 'outros', valor: 300),
  ],
};

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
  final _linhaCtrl = TextEditingController();
  final _containerCtrls =
      List<TextEditingController>.generate(6, (_) => TextEditingController());
  final _containerCapacidadeCtrl = TextEditingController();
  final _containerQtdCtrl = TextEditingController();
  final _cubaCtrl = TextEditingController();
  final _outrosCtrl = TextEditingController();
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
  void initState() {
    super.initState();
    for (final ctrl in [
      _linhaCtrl,
      ..._containerCtrls,
      _cubaCtrl,
      _outrosCtrl,
    ]) {
      ctrl.addListener(_sincronizarTotalEstratificado);
    }
    _containerCapacidadeCtrl.addListener(_atualizarPreviewMultiplicacao);
    _containerQtdCtrl.addListener(_atualizarPreviewMultiplicacao);
  }

  @override
  void dispose() {
    _estoqueAntCtrl.dispose();
    _contadoCtrl.dispose();
    _linhaCtrl.dispose();
    for (final ctrl in _containerCtrls) {
      ctrl.dispose();
    }
    _containerCapacidadeCtrl.dispose();
    _containerQtdCtrl.dispose();
    _cubaCtrl.dispose();
    _outrosCtrl.dispose();
    _recebCtrl.dispose();
    _obsCtrl.dispose();
    _justCtrl.dispose();
    _notaNumCtrl.dispose();
    _notaQtdCtrl.dispose();
    super.dispose();
  }

  void _carregar(
      ItemContagemDTO? it, ReferenciaMaterialDTO? ref, MaterialDTO mat) {
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
    _linhaCtrl.text = _fmtNumeroCampo(it?.linhaEstoque);
    for (var i = 0; i < _containerCtrls.length; i++) {
      final value = i < (it?.containers.length ?? 0) ? it!.containers[i] : 0.0;
      _containerCtrls[i].text = value == 0 ? '' : value.toStringAsFixed(2);
    }
    _cubaCtrl.text = _fmtNumeroCampo(it?.cubaEstoque);
    _outrosCtrl.text = _fmtNumeroCampo(it?.outrosEstoque);
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
    final anterior =
        double.tryParse(_estoqueAntCtrl.text.replaceAll(',', '.')) ?? 0;
    final contado = _estoqueContadoAtual();
    final receb = double.tryParse(_recebCtrl.text.replaceAll(',', '.'));
    return ItemContagemDTO(
      id: _item?.id ?? '',
      sessaoId: _item?.sessaoId ?? '',
      materialCodigo: widget.codigo,
      estoqueAnterior: anterior,
      estoqueContado: contado,
      linhaEstoque: _parseOpcional(_linhaCtrl),
      containers: _containersAtuais(),
      cubaEstoque: _parseOpcional(_cubaCtrl),
      outrosEstoque: _parseOpcional(_outrosCtrl),
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
    final x =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 70);
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
    final nome =
        '${widget.codigo}_${DateTime.now().millisecondsSinceEpoch}.jpg';
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
      _notas = [
        ..._notas,
        NotaRecebimentoDTO(id: '', numero: num, quantidade: qtd)
      ];
      _notaNumCtrl.clear();
      _notaQtdCtrl.clear();
    });
  }

  void _removeNota(int i) =>
      setState(() => _notas = List.of(_notas)..removeAt(i));

  void _snack(String msg) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  double? _parseOpcional(TextEditingController ctrl) {
    final text = ctrl.text.trim();
    if (text.isEmpty) return null;
    return double.tryParse(text.replaceAll(',', '.'));
  }

  double? _parseObrigatorio(TextEditingController ctrl) {
    final text = ctrl.text.trim();
    if (text.isEmpty) return null;
    return double.tryParse(text.replaceAll(',', '.'));
  }

  String _fmtNumeroCampo(double? value) =>
      value == null || value == 0 ? '' : value.toStringAsFixed(2);

  List<double> _containersAtuais() =>
      _containerCtrls.map((ctrl) => _parseOpcional(ctrl) ?? 0.0).toList();

  bool _temEstratificacaoDigitada() =>
      _linhaCtrl.text.trim().isNotEmpty ||
      _containerCtrls.any((ctrl) => ctrl.text.trim().isNotEmpty) ||
      _cubaCtrl.text.trim().isNotEmpty ||
      _outrosCtrl.text.trim().isNotEmpty;

  double _totalEstratificadoAtual() =>
      (_parseOpcional(_linhaCtrl) ?? 0) +
      _containersAtuais().fold(0.0, (a, v) => a + v) +
      (_parseOpcional(_cubaCtrl) ?? 0) +
      (_parseOpcional(_outrosCtrl) ?? 0);

  double? _estoqueContadoAtual() {
    if (_temEstratificacaoDigitada()) return _totalEstratificadoAtual();
    return double.tryParse(_contadoCtrl.text.replaceAll(',', '.'));
  }

  void _sincronizarTotalEstratificado() {
    if (!_inicializado || !_temEstratificacaoDigitada()) return;
    final total = _totalEstratificadoAtual();
    final atual = double.tryParse(_contadoCtrl.text.replaceAll(',', '.'));
    if (atual != total) {
      _contadoCtrl.text = total.toStringAsFixed(2);
    }
    if (mounted) setState(() {});
  }

  void _atualizarPreviewMultiplicacao() {
    if (mounted) setState(() {});
  }

  double? _totalContainersMultiplicado() {
    final capacidade = _parseObrigatorio(_containerCapacidadeCtrl);
    final quantidade = _parseObrigatorio(_containerQtdCtrl);
    if (capacidade == null || quantidade == null) return null;
    return capacidade * quantidade;
  }

  void _aplicarMultiplicacaoContainers(String unidade) {
    final capacidade = _parseObrigatorio(_containerCapacidadeCtrl);
    final quantidade = _parseObrigatorio(_containerQtdCtrl);
    if (capacidade == null || quantidade == null) {
      _snack('Informe a quantidade por recipiente e o número de recipientes.');
      return;
    }
    if (capacidade < 0 || quantidade < 0) {
      _snack('Os valores não podem ser negativos.');
      return;
    }
    final total = capacidade * quantidade;
    final destino = _containerCtrls.indexWhere((c) => c.text.trim().isEmpty);
    final ctrl = destino >= 0 ? _containerCtrls[destino] : _containerCtrls.last;
    final valorAtual = _parseOpcional(ctrl) ?? 0;
    ctrl.text = (destino >= 0 ? total : valorAtual + total).toStringAsFixed(2);
    _containerCapacidadeCtrl.clear();
    _containerQtdCtrl.clear();
    _snack(
      '${capacidade.toStringAsFixed(2)} $unidade x '
      '${quantidade.toStringAsFixed(0)} recipientes aplicado nos containers.',
    );
  }

  void _aplicarEstoquePadrao(_EstoquePadraoMaterial padrao, String unidade) {
    final ctrl = switch (padrao.campo) {
      'linha' => _linhaCtrl,
      'cuba' => _cubaCtrl,
      _ => _outrosCtrl,
    };
    final atual = _parseOpcional(ctrl) ?? 0;
    ctrl.text = (atual + padrao.valor).toStringAsFixed(2);
    _snack(
      '${padrao.label} ${padrao.valor.toStringAsFixed(2)} $unidade aplicado.',
    );
  }

  Future<void> _salvar({required bool concluir}) async {
    if (concluir && !_formKey.currentState!.validate()) return;
    final sessao = ref.read(sessaoAtualProvider).valueOrNull;
    if (sessao == null || _material == null) return;

    final anterior =
        double.tryParse(_estoqueAntCtrl.text.replaceAll(',', '.')) ?? 0;
    final contado = concluir ? _estoqueContadoAtual() : null;
    final receb =
        concluir ? double.tryParse(_recebCtrl.text.replaceAll(',', '.')) : null;

    final db = ref.read(databaseProvider);
    final salvoEm = DateTime.now();
    final itemId = await db.upsertItem(
      sessaoId: sessao.id,
      materialCodigo: widget.codigo,
      estoqueAnterior: anterior,
      estoqueContado: contado,
      linhaEstoque: _parseOpcional(_linhaCtrl),
      containers: _containersAtuais(),
      cubaEstoque: _parseOpcional(_cubaCtrl),
      outrosEstoque: _parseOpcional(_outrosCtrl),
      recebimentoTotal: receb,
      observacao: _obsCtrl.text,
      justificativa: _justCtrl.text,
      justificativaFotoPath: _justFotoPath,
      fotoPath: _fotoPath,
      status: concluir ? 'pendente' : 'pendente',
      timestamp: salvoEm,
      operadorNome: sessao.operadorNome,
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
      setState(() {
        _item = ItemContagemDTO(
          id: itemId,
          sessaoId: sessao.id,
          materialCodigo: widget.codigo,
          estoqueAnterior: anterior,
          estoqueContado: contado,
          linhaEstoque: _parseOpcional(_linhaCtrl),
          containers: _containersAtuais(),
          cubaEstoque: _parseOpcional(_cubaCtrl),
          outrosEstoque: _parseOpcional(_outrosCtrl),
          recebimentoTotal: receb,
          observacao: _obsCtrl.text,
          justificativa: _justCtrl.text,
          justificativaFotoPath: _justFotoPath,
          fotoPath: _fotoPath,
          status: StatusItem.pendente,
          timestamp: salvoEm,
          notas: _notas,
        );
      });
      ref.invalidate(itensSessaoProvider(sessao.id));
      ref.invalidate(resumosFornecedoresProvider(sessao.id));
      _snack('Parcial salvo.');
      return;
    }

    final item = ItemContagemDTO(
      id: itemId,
      sessaoId: sessao.id,
      materialCodigo: widget.codigo,
      estoqueAnterior: anterior,
      estoqueContado: contado,
      linhaEstoque: _parseOpcional(_linhaCtrl),
      containers: _containersAtuais(),
      cubaEstoque: _parseOpcional(_cubaCtrl),
      outrosEstoque: _parseOpcional(_outrosCtrl),
      recebimentoTotal: receb,
      observacao: _obsCtrl.text,
      justificativa: _justCtrl.text,
      justificativaFotoPath: _justFotoPath,
      fotoPath: _fotoPath,
      status: StatusItem.pendente,
      timestamp: DateTime.now(),
      notas: _notas,
    );
    final r = validarItem(
      item,
      onComplete: true,
      params: ref.read(parametrosProvider).valueOrNull ??
          ParametrosGlobais.padrao(),
    );
    final status = statusResultante(item, r);
    final concluidoEm = DateTime.now();
    await db.upsertItem(
      sessaoId: sessao.id,
      materialCodigo: widget.codigo,
      estoqueAnterior: anterior,
      estoqueContado: contado,
      linhaEstoque: _parseOpcional(_linhaCtrl),
      containers: _containersAtuais(),
      cubaEstoque: _parseOpcional(_cubaCtrl),
      outrosEstoque: _parseOpcional(_outrosCtrl),
      recebimentoTotal: receb,
      observacao: _obsCtrl.text,
      justificativa: _justCtrl.text,
      justificativaFotoPath: _justFotoPath,
      fotoPath: _fotoPath,
      status: statusParaDb(status),
      timestamp: concluidoEm,
      operadorNome: sessao.operadorNome,
    );
    _item = ItemContagemDTO(
      id: itemId,
      sessaoId: sessao.id,
      materialCodigo: widget.codigo,
      estoqueAnterior: anterior,
      estoqueContado: contado,
      linhaEstoque: _parseOpcional(_linhaCtrl),
      containers: _containersAtuais(),
      cubaEstoque: _parseOpcional(_cubaCtrl),
      outrosEstoque: _parseOpcional(_outrosCtrl),
      recebimentoTotal: receb,
      observacao: _obsCtrl.text,
      justificativa: _justCtrl.text,
      justificativaFotoPath: _justFotoPath,
      fotoPath: _fotoPath,
      status: status,
      timestamp: concluidoEm,
      notas: _notas,
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
    final refAsync =
        ref.watch(referenciaMaterialCompletaProvider(widget.codigo));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Contagem do material'),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            tooltip: 'Auditoria do item',
            onPressed: () => context.push('/historico/${widget.codigo}'),
          ),
        ],
      ),
      body: matAsync.when(
        data: (mat) {
          if (mat == null) {
            return const Center(child: Text('Material não cadastrado.'));
          }
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
    final parametros =
        ref.watch(parametrosProvider).valueOrNull ?? ParametrosGlobais.padrao();
    final r = validarItem(item, onComplete: true, params: parametros);
    _requerJustificativa = requerJustificativa(item, params: parametros);
    final horarioRegistrado =
        _item != null && _item!.id.isNotEmpty ? _item!.timestamp : null;
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
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    Text('Código: ${mat.codigo}'),
                    Text(
                        'Família: ${mat.familia}  •  Unidade: ${mat.unidade} (fixa)  •  Fornecedor: ${mat.fornecedor}'),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.schedule, size: 18),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            horarioRegistrado == null
                                ? 'Horário do material: será registrado pela hora do celular.'
                                : 'Registrado pelo celular: ${_fmtData(horarioRegistrado)}',
                          ),
                        ),
                      ],
                    ),
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
                fillColor: !_estoqueAntEditavel ? Colors.grey.shade100 : null,
              ),
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
            ),
            const SizedBox(height: 8),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Estratificação do estoque',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text(
                      'Informe os saldos por local físico. O app soma tudo e preenche o estoque contado.',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 12),
                    _campoQuantidade(
                        _linhaCtrl, 'Linha / Banho / Tanque', mat.unidade),
                    const SizedBox(height: 8),
                    _estoquesPadrao(mat),
                    const SizedBox(height: 8),
                    _calculadoraContainers(mat.unidade),
                    const SizedBox(height: 8),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 3.2,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                      ),
                      itemCount: _containerCtrls.length,
                      itemBuilder: (context, index) => _campoQuantidade(
                        _containerCtrls[index],
                        'Container ${index + 1}',
                        mat.unidade,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                            child: _campoQuantidade(
                                _cubaCtrl, 'Cuba', mat.unidade)),
                        const SizedBox(width: 8),
                        Expanded(
                            child: _campoQuantidade(
                                _outrosCtrl, 'Outros', mat.unidade)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _contadoCtrl,
              readOnly: _temEstratificacaoDigitada(),
              decoration: InputDecoration(
                labelText: _temEstratificacaoDigitada()
                    ? 'Estoque contado calculado (${mat.unidade}) *'
                    : 'Estoque contado (${mat.unidade}) *',
                border: const OutlineInputBorder(),
                suffixText: mat.unidade,
                helperText: _temEstratificacaoDigitada()
                    ? 'Soma de linha + containers + cuba + outros.'
                    : 'Digite o total manualmente ou preencha a estratificação acima.',
                filled: _temEstratificacaoDigitada(),
                fillColor:
                    _temEstratificacaoDigitada() ? Colors.grey.shade100 : null,
              ),
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
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
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              validator: (v) {
                final n = double.tryParse(v?.replaceAll(',', '.') ?? '');
                if (n == null) return 'Número inválido';
                if (n < 0) return 'Não pode ser negativo';
                return null;
              },
            ),
            const SizedBox(height: 12),
            const Text('NFs / GRs',
                style: TextStyle(fontWeight: FontWeight.bold)),
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
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton.filled(
                    onPressed: _addNota, icon: const Icon(Icons.add)),
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
              Text(
                  'Soma das NFs/GRs: ${item.somaNotas.toStringAsFixed(2)} ${mat.unidade}'),
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
            if (_requerJustificativa ||
                r.avisos.any((a) => a.contains('justificada')))
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text('Justificativa de divergência *',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.red)),
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

  Widget _estoquesPadrao(MaterialDTO mat) {
    final padroes = _estoquesPadraoPorMaterial[mat.codigo] ?? const [];
    if (padroes.isEmpty) return const SizedBox.shrink();
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blueGrey.shade50,
        border: Border.all(color: Colors.blueGrey.shade100),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Medidas padrão da planilha stock',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final padrao in padroes)
                ActionChip(
                  avatar: const Icon(Icons.add, size: 18),
                  label: Text(
                    '${padrao.label}: '
                    '${padrao.valor.toStringAsFixed(2)} ${mat.unidade}',
                  ),
                  onPressed: () => _aplicarEstoquePadrao(padrao, mat.unidade),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _calculadoraContainers(String unidade) {
    final total = _totalContainersMultiplicado();
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Multiplicar recipientes iguais',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _containerCapacidadeCtrl,
                  decoration: InputDecoration(
                    labelText: 'Qtd. por recipiente',
                    border: const OutlineInputBorder(),
                    suffixText: unidade,
                  ),
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: TextFormField(
                  controller: _containerQtdCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Nº recipientes',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Text(
                  total == null
                      ? 'Ex.: 1000 x 20 IBCs'
                      : 'Total: ${total.toStringAsFixed(2)} $unidade',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
              FilledButton.icon(
                icon: const Icon(Icons.calculate),
                label: const Text('Aplicar'),
                onPressed: () => _aplicarMultiplicacaoContainers(unidade),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _campoQuantidade(
      TextEditingController controller, String label, String unidade) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        suffixText: unidade,
      ),
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      validator: (v) {
        final text = v?.trim() ?? '';
        if (text.isEmpty) return null;
        final n = double.tryParse(text.replaceAll(',', '.'));
        if (n == null) return 'Inválido';
        if (n < 0) return 'Negativo';
        return null;
      },
    );
  }
}
