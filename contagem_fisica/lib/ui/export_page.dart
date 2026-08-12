import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';

import '../domain/backend_sync.dart';
import '../domain/export_excel.dart';
import '../domain/export_pdf.dart';
import '../domain/export_zip.dart';
import '../providers/database_provider.dart';
import '../providers/materiais_provider.dart';
import '../providers/sessao_provider.dart';

class ExportPage extends ConsumerStatefulWidget {
  const ExportPage({super.key});

  @override
  ConsumerState<ExportPage> createState() => _ExportPageState();
}

class _ExportPageState extends ConsumerState<ExportPage> {
  bool _gerando = false;
  bool _enviandoBackend = false;
  String? _excelPath;
  String? _pdfPath;
  String? _zipPath;
  String? _erro;
  String? _backendOk;

  Future<void> _gerar() async {
    setState(() {
      _gerando = true;
      _erro = null;
    });
    try {
      final sessao = ref.read(sessaoAtualProvider).valueOrNull;
      if (sessao == null) throw StateError('Sem sessão ativa.');
      final db = ref.read(databaseProvider);
      final materiais = await ref.read(todosMateriaisProvider.future);
      final itens = await ref.read(itensSessaoProvider(sessao.id).future);

      final excel = await GeradorExcel().gerar(
        sessao: sessao,
        itens: itens,
        materiais: materiais,
      );
      await db.registrarExport(sessaoId: sessao.id, caminhoExcel: excel.path);

      final pdf = await GeradorPdf().gerar(
        sessao: sessao,
        itens: itens,
        materiais: materiais,
      );
      await db.registrarExport(sessaoId: sessao.id, caminhoPdf: pdf.path);
      final zip = await GeradorZipAuditoria().gerar(
        sessao: sessao,
        itens: itens,
        excel: excel,
        pdf: pdf,
      );
      await ref.read(sessaoAtualProvider.notifier).finalizar();
      await db.marcarSessaoExportada(sessao.id);

      setState(() {
        _excelPath = excel.path;
        _pdfPath = pdf.path;
        _zipPath = zip.path;
      });
    } catch (e) {
      setState(() => _erro = e.toString());
    } finally {
      if (mounted) setState(() => _gerando = false);
    }
  }

  Future<void> _enviarBackend() async {
    setState(() {
      _enviandoBackend = true;
      _erro = null;
      _backendOk = null;
    });
    try {
      final sessao = ref.read(sessaoAtualProvider).valueOrNull;
      if (sessao == null) throw StateError('Sem sessão ativa.');
      final materiais = await ref.read(todosMateriaisProvider.future);
      final itens = await ref.read(itensSessaoProvider(sessao.id).future);
      await BackendSync().enviarContagem(
        sessao: sessao,
        itens: itens,
        materiais: materiais,
      );
      setState(() => _backendOk = 'Dados enviados para o backend.');
    } catch (e) {
      setState(() => _erro = e.toString());
    } finally {
      if (mounted) setState(() => _enviandoBackend = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final backendConfigurado = BackendSync().configurado;
    return Scaffold(
      appBar: AppBar(title: const Text('Exportar contagem')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('O Excel é compatível com o importador do Streamlit '
                '(core/importers.py::importar_stock_operador). '
                'Importe o arquivo gerado no Streamlit, no passo de Stock do Operador.'),
            const SizedBox(height: 12),
            if (_erro != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Text('Erro: $_erro',
                    style: const TextStyle(color: Colors.red)),
              ),
            if (_backendOk != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Text(_backendOk!,
                    style: const TextStyle(color: Colors.green)),
              ),
            FilledButton.icon(
              icon: const Icon(Icons.folder_zip),
              label: const Text('Gerar pacote de auditoria'),
              onPressed: _gerando ? null : _gerar,
            ),
            const SizedBox(height: 8),
            OutlinedButton.icon(
              icon: const Icon(Icons.cloud_upload),
              label: const Text('Compartilhar dados no backend'),
              onPressed: !backendConfigurado || _enviandoBackend
                  ? null
                  : _enviarBackend,
            ),
            const SizedBox(height: 16),
            if (_zipPath != null)
              Card(
                child: ListTile(
                  leading: const Icon(Icons.folder_zip, color: Colors.blueGrey),
                  title: const Text('Pacote ZIP de auditoria gerado'),
                  subtitle: Text(_zipPath!),
                  trailing: IconButton(
                    icon: const Icon(Icons.share),
                    onPressed: () => Share.shareXFiles([XFile(_zipPath!)],
                        text: 'Contagem física — pacote de auditoria'),
                  ),
                ),
              ),
            if (_excelPath != null)
              Card(
                child: ListTile(
                  leading: const Icon(Icons.table_view, color: Colors.green),
                  title: const Text('Excel gerado'),
                  subtitle: Text(_excelPath!),
                  trailing: IconButton(
                    icon: const Icon(Icons.share),
                    onPressed: () => Share.shareXFiles([XFile(_excelPath!)],
                        text: 'Contagem física — Excel'),
                  ),
                ),
              ),
            if (_pdfPath != null)
              Card(
                child: ListTile(
                  leading: const Icon(Icons.picture_as_pdf, color: Colors.red),
                  title: const Text('PDF de auditoria gerado'),
                  subtitle: Text(_pdfPath!),
                  trailing: IconButton(
                    icon: const Icon(Icons.share),
                    onPressed: () => Share.shareXFiles([XFile(_pdfPath!)],
                        text: 'Contagem física — PDF auditoria'),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
