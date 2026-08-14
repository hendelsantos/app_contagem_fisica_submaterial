import 'dart:convert';

import 'package:http/http.dart' as http;

import 'models.dart';

class BackendSyncConfig {
  static const backendUrl = String.fromEnvironment('BACKEND_URL');
  static const apiToken = String.fromEnvironment('APP_API_TOKEN');

  static bool get habilitado =>
      backendUrl.trim().isNotEmpty && apiToken.trim().isNotEmpty;
}

class BackendSync {
  BackendSync({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;

  Future<void> enviarContagem({
    required SessaoDTO sessao,
    required List<ItemContagemDTO> itens,
    required List<MaterialDTO> materiais,
  }) async {
    if (!BackendSyncConfig.habilitado) {
      throw StateError('Envio online nao configurado neste APK.');
    }

    final base =
        BackendSyncConfig.backendUrl.trim().replaceAll(RegExp(r'/+$'), '');
    final uri = Uri.parse('$base/api/contagens/');
    final materiaisPorCodigo = {for (final m in materiais) m.codigo: m};
    final response = await _client.post(
      uri,
      headers: {
        'Content-Type': 'application/json; charset=utf-8',
        'X-App-Token': BackendSyncConfig.apiToken,
      },
      body: jsonEncode({
        'sessao': _sessaoJson(sessao),
        'itens': itens
            .map((item) =>
                _itemJson(item, materiaisPorCodigo[item.materialCodigo]))
            .toList(),
      }),
    );

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw StateError(
          'Falha no envio (${response.statusCode}): ${response.body}');
    }
  }

  Map<String, dynamic> _sessaoJson(SessaoDTO sessao) => {
        'id': sessao.id,
        'operadorNome': sessao.operadorNome,
        'operadorMatricula': sessao.operadorMatricula,
        'dataInicio': sessao.dataInicio.toIso8601String(),
        'dataFimPrevista': sessao.dataFimPrevista?.toIso8601String(),
        'dataFimReal': sessao.dataFimReal?.toIso8601String(),
        'status': sessao.status,
        'versaoCadastro': sessao.versaoCadastro,
        'aparelho': sessao.aparelho,
      };

  Map<String, dynamic> _itemJson(ItemContagemDTO item, MaterialDTO? material) =>
      {
        'id': item.id,
        'sessaoId': item.sessaoId,
        'materialCodigo': item.materialCodigo,
        'material': material == null
            ? null
            : {
                'codigo': material.codigo,
                'descricao': material.descricao,
                'fornecedor': material.fornecedor,
                'familia': material.familia,
                'unidade': material.unidade,
                'sobeSap': material.sobeSap,
                'nomeStock': material.nomeStock,
              },
        'estoqueAnterior': item.estoqueAnterior,
        'estoqueContado': item.temEstratificacao
            ? item.totalEstratificado
            : (item.estoqueContado ?? 0),
        'linhaEstoque': item.linhaEstoque,
        'containers': item.containers,
        'cubaEstoque': item.cubaEstoque,
        'outrosEstoque': item.outrosEstoque,
        'recebimentoTotal': item.recebimentoTotal ?? 0,
        'somaNotas': item.somaNotas,
        'observacao': item.observacao,
        'justificativa': item.justificativa,
        'justificativaFotoPath': item.justificativaFotoPath,
        'fotoPath': item.fotoPath,
        'status': item.status.name,
        'timestamp': item.timestamp.toIso8601String(),
        'notas': item.notas
            .map((nota) => {
                  'id': nota.id,
                  'numero': nota.numero,
                  'quantidade': nota.quantidade,
                  'dataRecebimento': nota.dataRecebimento?.toIso8601String(),
                  'fotoPath': nota.fotoPath,
                })
            .toList(),
      };
}
