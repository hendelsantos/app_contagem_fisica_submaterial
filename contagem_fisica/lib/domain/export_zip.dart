import 'dart:io';

import 'package:archive/archive.dart';
import 'package:contagem_fisica/domain/models.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class GeradorZipAuditoria {
  Future<File> gerar({
    required SessaoDTO sessao,
    required List<ItemContagemDTO> itens,
    required File excel,
    required File pdf,
  }) async {
    final archive = Archive();
    final fotosAdicionadas = <String, int>{};
    final fotosManifesto = <String>[];

    await _adicionarArquivo(
        archive, excel, p.join('relatorios', p.basename(excel.path)));
    await _adicionarArquivo(
        archive, pdf, p.join('relatorios', p.basename(pdf.path)));

    for (final item in itens) {
      await _adicionarFoto(
        archive: archive,
        fotosAdicionadas: fotosAdicionadas,
        fotosManifesto: fotosManifesto,
        caminho: item.fotoPath,
        prefixo: '${item.materialCodigo}_contagem',
      );
      await _adicionarFoto(
        archive: archive,
        fotosAdicionadas: fotosAdicionadas,
        fotosManifesto: fotosManifesto,
        caminho: item.justificativaFotoPath,
        prefixo: '${item.materialCodigo}_justificativa',
      );
      for (final nota in item.notas) {
        await _adicionarFoto(
          archive: archive,
          fotosAdicionadas: fotosAdicionadas,
          fotosManifesto: fotosManifesto,
          caminho: nota.fotoPath,
          prefixo: '${item.materialCodigo}_nf_${_limparNome(nota.numero)}',
        );
      }
    }

    archive.addFile(ArchiveFile.string(
      'manifesto_fotos.txt',
      fotosManifesto.isEmpty
          ? 'Nenhuma foto encontrada nos caminhos gravados desta sessao.\n'
          : '${fotosManifesto.join('\n')}\n',
    ));

    final bytes = ZipEncoder().encode(archive)!;
    final dir = await getApplicationDocumentsDirectory();
    final nome =
        'auditoria_completa_${sessao.id}_${DateTime.now().millisecondsSinceEpoch}.zip';
    final file = File(p.join(dir.path, 'exports', nome));
    await file.parent.create(recursive: true);
    await file.writeAsBytes(bytes);
    return file;
  }

  Future<void> _adicionarArquivo(
      Archive archive, File file, String nomeNoZip) async {
    if (!await file.exists()) return;
    final bytes = await file.readAsBytes();
    archive.addFile(ArchiveFile(nomeNoZip, bytes.length, bytes));
  }

  Future<void> _adicionarFoto({
    required Archive archive,
    required Map<String, int> fotosAdicionadas,
    required List<String> fotosManifesto,
    required String? caminho,
    required String prefixo,
  }) async {
    final normalizado = caminho?.trim();
    if (normalizado == null || normalizado.isEmpty) return;

    final file = File(normalizado);
    if (!await file.exists()) {
      fotosManifesto.add('$normalizado -> nao encontrada');
      return;
    }

    final bytes = await file.readAsBytes();
    final ext =
        p.extension(file.path).isEmpty ? '.jpg' : p.extension(file.path);
    final base = _limparNome(prefixo);
    final contador = (fotosAdicionadas[base] ?? 0) + 1;
    fotosAdicionadas[base] = contador;
    final nomeNoZip =
        p.join('fotos', '$base${contador > 1 ? '_$contador' : ''}$ext');

    archive.addFile(ArchiveFile(nomeNoZip, bytes.length, bytes));
    fotosManifesto.add('$nomeNoZip <- $normalizado');
  }

  String _limparNome(String valor) {
    final ascii = valor.codeUnits.map((b) {
      final c = String.fromCharCode(b);
      return RegExp(r'[A-Za-z0-9_-]').hasMatch(c) ? c : '_';
    }).join();
    return ascii
        .replaceAll(RegExp(r'_+'), '_')
        .replaceAll(RegExp(r'^_|_$'), '');
  }
}
