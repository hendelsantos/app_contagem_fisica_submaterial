import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';

import '../domain/export_excel.dart';
import '../domain/export_pdf.dart';
import '../domain/export_zip.dart';
import '../domain/sync_backend.dart';
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
  String? _excelPath;
  String? _pdfPath;
  String? _zipPath;
  String? _erro;
  bool _enviandoOnline = false;
  bool _enviadoOnline = false;

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

      if (BackendSyncConfig.habilitado) {
        await _enviarOnline(silencioso: true);
      }
    } catch (e) {
      setState(() => _erro = e.toString());
    } finally {
      if (mounted) setState(() => _gerando = false);
    }
  }

  Future<void> _enviarExcelWhatsApp() async {
    final path = _excelPath;
    if (path == null) return;
    await Share.shareXFiles(
      [XFile(path)],
      text: 'Contagem física HMB — Excel para importação',
      subject: 'Contagem física HMB',
    );
  }

  Future<void> _enviarOnline({bool silencioso = false}) async {
    setState(() {
      _enviandoOnline = true;
      _erro = null;
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

      if (mounted) {
        setState(() => _enviadoOnline = true);
      }
    } catch (e) {
      if (!silencioso && mounted) {
        setState(() => _erro = e.toString());
      }
    } finally {
      if (mounted) {
        setState(() => _enviandoOnline = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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
            FilledButton.icon(
              icon: const Icon(Icons.folder_zip),
              label: const Text('Gerar pacote de auditoria'),
              onPressed: _gerando ? null : _gerar,
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
            if (_zipPath != null && BackendSyncConfig.habilitado)
              Card(
                child: ListTile(
                  leading: Icon(
                    _enviadoOnline ? Icons.cloud_done : Icons.cloud_upload,
                    color: _enviadoOnline ? Colors.green : Colors.blue,
                  ),
                  title: Text(_enviadoOnline
                      ? 'Dados enviados para a página'
                      : 'Enviar dados online'),
                  subtitle: const Text(
                      'Quando houver internet, envia a contagem para o painel online.'),
                  trailing: IconButton(
                    icon: _enviandoOnline
                        ? const SizedBox(
                            width: 22,
                            height: 22,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.send),
                    onPressed: _enviandoOnline ? null : _enviarOnline,
                  ),
                ),
              ),
            if (_zipPath != null && !BackendSyncConfig.habilitado)
              const Card(
                child: ListTile(
                  leading: Icon(Icons.cloud_off, color: Colors.blueGrey),
                  title: Text('Envio online desativado'),
                  subtitle: Text(
                      'Este APK foi gerado sem BACKEND_URL e APP_API_TOKEN.'),
                ),
              ),
            if (_excelPath != null)
              Card(
                child: Column(
                  children: [
                    ListTile(
                      leading:
                          const Icon(Icons.table_view, color: Colors.green),
                      title: const Text('Excel gerado'),
                      subtitle: Text(_excelPath!),
                      trailing: IconButton(
                        icon: const Icon(Icons.share),
                        onPressed: () => Share.shareXFiles([XFile(_excelPath!)],
                            text: 'Contagem física — Excel'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      child: SizedBox(
                        width: double.infinity,
                        child: FilledButton.icon(
                          icon: const Icon(Icons.chat),
                          label: const Text('Enviar Excel pelo WhatsApp'),
                          onPressed: _enviarExcelWhatsApp,
                        ),
                      ),
                    ),
                  ],
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
