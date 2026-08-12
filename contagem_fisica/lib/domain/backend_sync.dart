import 'dart:convert';

import 'package:contagem_fisica/domain/models.dart';
import 'package:http/http.dart' as http;

class BackendSync {
  static const backendUrl = String.fromEnvironment(
    'BACKEND_URL',
    defaultValue: 'https://backend-production-3a35.up.railway.app',
  );
  static const appToken = String.fromEnvironment('APP_API_TOKEN');

  bool get configurado => backendUrl.isNotEmpty && appToken.isNotEmpty;

  Future<void> enviarContagem({
    required SessaoDTO sessao,
    required List<ItemContagemDTO> itens,
    required List<MaterialDTO> materiais,
  }) async {
    if (!configurado) {
      throw StateError('Backend nao configurado no APK.');
    }

    final uri = Uri.parse('$backendUrl/api/contagens/');
    final matByCodigo = {for (final m in materiais) m.codigo: m};
    final payload = {
      'sessao': {
        'id': sessao.id,
        'operadorNome': sessao.operadorNome,
        'operadorMatricula': sessao.operadorMatricula,
        'dataInicio': sessao.dataInicio.toIso8601String(),
        'dataFimReal': sessao.dataFimReal?.toIso8601String(),
        'status': sessao.status,
        'versaoCadastro': sessao.versaoCadastro,
        'aparelho': sessao.aparelho,
      },
      'itens': [
        for (final item in itens)
          {
            'id': item.id,
            'materialCodigo': item.materialCodigo,
            'material': _materialJson(matByCodigo[item.materialCodigo]),
            'estoqueAnterior': item.estoqueAnterior,
            'estoqueContado': item.estoqueContado,
            'recebimentoTotal': item.recebimentoTotal,
            'somaNotas': item.somaNotas,
            'status': item.status.label,
            'justificativa': item.justificativa,
            'observacao': item.observacao,
            'fotoPath': item.fotoPath,
            'justificativaFotoPath': item.justificativaFotoPath,
            'timestamp': item.timestamp.toIso8601String(),
            'notas': [
              for (final nota in item.notas)
                {
                  'numero': nota.numero,
                  'quantidade': nota.quantidade,
                  'dataRecebimento': nota.dataRecebimento?.toIso8601String(),
                  'fotoPath': nota.fotoPath,
                },
            ],
          },
      ],
    };

    final response = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'X-App-Token': appToken,
      },
      body: jsonEncode(payload),
    );

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw StateError(
          'Falha ao enviar para o backend: ${response.statusCode}');
    }
  }

  Map<String, Object?> _materialJson(MaterialDTO? material) {
    if (material == null) return {};
    return {
      'codigo': material.codigo,
      'descricao': material.descricao,
      'fornecedor': material.fornecedor,
      'familia': material.familia,
      'unidade': material.unidade,
      'sobeSap': material.sobeSap,
      'nomeStock': material.nomeStock,
    };
  }
}
