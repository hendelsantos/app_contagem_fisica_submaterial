import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';

import '../domain/backup.dart';
import '../providers/database_provider.dart';
import '../providers/sessao_provider.dart';

class BackupPage extends ConsumerStatefulWidget {
  const BackupPage({super.key});

  @override
  ConsumerState<BackupPage> createState() => _BackupPageState();
}

class _BackupPageState extends ConsumerState<BackupPage> {
  bool _processando = false;
  String? _status;
  bool _erro = false;

  Future<void> _exportar() async {
    setState(() {
      _processando = true;
      _status = null;
      _erro = false;
    });
    try {
      final db = ref.read(databaseProvider);
      final arquivo = await exportarBackup(db);
      await Share.shareXFiles(
        [XFile(arquivo.path)],
        subject: 'Backup Contagem Física HMB',
      );
      setState(() {
        _status = 'Backup gerado: ${arquivo.path.split('/').last}';
      });
    } catch (e) {
      setState(() {
        _status = 'Erro ao exportar: $e';
        _erro = true;
      });
    } finally {
      setState(() => _processando = false);
    }
  }

  Future<void> _importar() async {
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Importar backup'),
        content: const Text(
          'Importar um backup SUBSTITUI todos os dados atuais do app '
          'pelos dados do arquivo.\n\n'
          'Esta ação não pode ser desfeita. Recomendado apenas em '
          'aparelho novo ou após restauração de fábrica.\n\n'
          'Continuar?',
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancelar')),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Importar e substituir'),
          ),
        ],
      ),
    );
    if (confirmar != true) return;

    setState(() {
      _processando = true;
      _status = null;
      _erro = false;
    });
    try {
      final res = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['json'],
        withData: false,
      );
      if (res == null || res.files.isEmpty) {
        setState(() {
          _status = 'Nenhum arquivo selecionado.';
        });
        return;
      }
      final path = res.files.first.path;
      if (path == null) {
        setState(() {
          _status = 'Não foi possível acessar o arquivo.';
          _erro = true;
        });
        return;
      }
      final db = ref.read(databaseProvider);
      final r = await importarBackup(db, File(path));
      ref.invalidate(sessaoAtualProvider);
      setState(() {
        _status = 'Backup importado: ${r.sessoes} sessões, '
            '${r.itens} itens, ${r.notas} notas. '
            'Backup original de ${r.dataBackup.day}/${r.dataBackup.month}/${r.dataBackup.year}.';
      });
    } catch (e) {
      setState(() {
        _status = 'Erro ao importar: $e';
        _erro = true;
      });
    } finally {
      setState(() => _processando = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Backup e restauração')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: const [Icon(Icons.upload_file, color: Color(0xFF1565C0)), SizedBox(width: 8), Text('Exportar backup', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16))]),
                    const SizedBox(height: 8),
                    const Text(
                      'Gera um arquivo JSON com todas as sessões, itens, notas fiscais, '
                      'fornecedores, materiais e referências de estoque do app. '
                      'Use para trocar de aparelho ou guardar cópia de segurança.',
                      style: TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 10),
                    FilledButton.icon(
                      onPressed: _processando ? null : _exportar,
                      icon: const Icon(Icons.share),
                      label: const Text('Gerar e compartilhar backup'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: const [Icon(Icons.restore, color: Colors.red), SizedBox(width: 8), Text('Importar backup', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16))]),
                    const SizedBox(height: 8),
                    const Text(
                      'Restaura um backup de um arquivo JSON. SUBSTITUI todos os dados '
                      'atuais do aparelho. Use em aparelho novo ou após reset.',
                      style: TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 10),
                    FilledButton.icon(
                      onPressed: _processando ? null : _importar,
                      style: FilledButton.styleFrom(backgroundColor: Colors.red),
                      icon: const Icon(Icons.file_upload),
                      label: const Text('Escolher arquivo e importar'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Observações', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF0D47A1), fontSize: 14)),
                    SizedBox(height: 6),
                    Text(
                      'As fotos de divergência não são incluídas no backup (apenas o caminho '
                      'delas). Se você restaurar em outro aparelho, os caminhos das fotos '
                      'não apontarão para arquivos existentes, mas os dados da contagem '
                      'ficam íntegros.\n\n'
                      'Recomendamos gerar um backup após concluir cada sessão de contagem '
                      'e guardar em local seguro (nuvem, e-mail, pen drive).',
                      style: TextStyle(fontSize: 13),
                    ),
                  ],
                ),
              ),
            ),
            if (_status != null) ...[
              const SizedBox(height: 14),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _erro ? Colors.red.withOpacity(0.1) : Colors.green.withOpacity(0.1),
                  border: Border.all(color: _erro ? Colors.red : Colors.green),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(_erro ? Icons.error_outline : Icons.check_circle, color: _erro ? Colors.red : Colors.green),
                    const SizedBox(width: 8),
                    Expanded(child: Text(_status!, style: const TextStyle(fontSize: 14))),
                  ],
                ),
              ),
            ],
            if (_processando) ...[
              const SizedBox(height: 16),
              const Center(child: CircularProgressIndicator()),
            ],
          ],
        ),
      ),
    );
  }
}