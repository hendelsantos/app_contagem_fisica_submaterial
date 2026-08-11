enum StatusItem { pendente, valido, alerta, justificado, bloqueado }

extension StatusItemX on StatusItem {
  String get label {
    switch (this) {
      case StatusItem.pendente:
        return 'Pendente';
      case StatusItem.valido:
        return 'Válido';
      case StatusItem.alerta:
        return 'Alerta';
      case StatusItem.justificado:
        return 'Justificado';
      case StatusItem.bloqueado:
        return 'Bloqueado';
    }
  }
}

class MaterialDTO {
  final String codigo;
  final String descricao;
  final String fornecedor;
  final String familia;
  final String unidade;
  final int sobeSap;
  final String nomeStock;

  const MaterialDTO({
    required this.codigo,
    required this.descricao,
    required this.fornecedor,
    required this.familia,
    required this.unidade,
    required this.sobeSap,
    required this.nomeStock,
  });
}

class NotaRecebimentoDTO {
  final String id;
  final String numero;
  final double quantidade;
  final DateTime? dataRecebimento;
  final String? fotoPath;

  const NotaRecebimentoDTO({
    required this.id,
    required this.numero,
    required this.quantidade,
    this.dataRecebimento,
    this.fotoPath,
  });
}

class ItemContagemDTO {
  final String id;
  final String sessaoId;
  final String materialCodigo;
  final double estoqueAnterior;
  final double? estoqueContado;
  final double? recebimentoTotal;
  final String? observacao;
  final String? justificativa;
  final String? justificativaFotoPath;
  final String? fotoPath;
  final StatusItem status;
  final DateTime timestamp;
  final List<NotaRecebimentoDTO> notas;

  const ItemContagemDTO({
    required this.id,
    required this.sessaoId,
    required this.materialCodigo,
    required this.estoqueAnterior,
    this.estoqueContado,
    this.recebimentoTotal,
    this.observacao,
    this.justificativa,
    this.justificativaFotoPath,
    this.fotoPath,
    required this.status,
    required this.timestamp,
    this.notas = const [],
  });

  double get somaNotas => notas.fold(0.0, (a, n) => a + n.quantidade);
  double get consumoFisicoEstimado =>
      estoqueAnterior + (recebimentoTotal ?? 0) - (estoqueContado ?? 0);
}

class SessaoDTO {
  final String id;
  final String operadorNome;
  final String operadorMatricula;
  final DateTime dataInicio;
  final DateTime? dataFimPrevista;
  final DateTime? dataFimReal;
  final String status;
  final String versaoCadastro;
  final String? aparelho;

  const SessaoDTO({
    required this.id,
    required this.operadorNome,
    required this.operadorMatricula,
    required this.dataInicio,
    this.dataFimPrevista,
    this.dataFimReal,
    required this.status,
    required this.versaoCadastro,
    this.aparelho,
  });
}

class ResumoFornecedor {
  final String fornecedor;
  final int totalMateriais;
  final int contados;
  final int pendentes;
  final int comAlerta;
  final int bloqueados;

  const ResumoFornecedor({
    required this.fornecedor,
    required this.totalMateriais,
    required this.contados,
    required this.pendentes,
    required this.comAlerta,
    required this.bloqueados,
  });

  bool get concluido => pendentes == 0 && bloqueados == 0;
}