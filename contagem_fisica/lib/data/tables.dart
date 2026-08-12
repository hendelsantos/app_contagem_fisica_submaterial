import 'package:drift/drift.dart';

@DataClassName('MaterialCadastro')
class Materiais extends Table {
  TextColumn get codigo => text()();
  TextColumn get descricao => text()();
  TextColumn get fornecedor => text()();
  TextColumn get familia => text()();
  TextColumn get unidade => text()();
  IntColumn get sobeSap => integer().withDefault(const Constant(1))();
  BoolColumn get ativo => boolean().withDefault(const Constant(true))();
  TextColumn get nomeStock => text()();

  @override
  Set<Column<Object>> get primaryKey => {codigo};
}

@DataClassName('FornecedorRow')
class Fornecedores extends Table {
  TextColumn get nome => text()();
  IntColumn get ordem => integer()();

  @override
  Set<Column<Object>> get primaryKey => {nome};
}

@DataClassName('EstoqueReferenciaRow')
class EstoqueReferencia extends Table {
  TextColumn get materialCodigo => text()();
  RealColumn get estoqueFinalKg => real()();
  TextColumn get sessaoOrigemId => text().nullable()();
  DateTimeColumn get dataReferencia => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {materialCodigo};
}

@DataClassName('SessaoRow')
class Sessoes extends Table {
  TextColumn get id => text()();
  TextColumn get operadorNome => text()();
  TextColumn get operadorMatricula => text()();
  DateTimeColumn get dataInicio => dateTime()();
  DateTimeColumn get dataFimPrevista => dateTime().nullable()();
  DateTimeColumn get dataFimReal => dateTime().nullable()();
  TextColumn get status => text()();
  TextColumn get versaoCadastro => text()();
  TextColumn get aparelho => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('ItemContagemRow')
class ItensContagem extends Table {
  TextColumn get id => text()();
  TextColumn get sessaoId => text()();
  TextColumn get materialCodigo => text()();
  RealColumn get estoqueAnterior => real()();
  RealColumn get estoqueContado => real().nullable()();
  RealColumn get recebimentoTotal => real().nullable()();
  TextColumn get observacao => text().nullable()();
  TextColumn get justificativa => text().nullable()();
  TextColumn get justificativaFotoPath => text().nullable()();
  TextColumn get fotoPath => text().nullable()();
  TextColumn get status => text()();
  DateTimeColumn get timestamp => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('NotaRecebimentoRow')
class NotasRecebimento extends Table {
  TextColumn get id => text()();
  TextColumn get itemId => text()();
  TextColumn get numero => text()();
  RealColumn get quantidade => real()();
  DateTimeColumn get dataRecebimento => dateTime().nullable()();
  TextColumn get fotoPath => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('ExportRow')
class Exports extends Table {
  TextColumn get id => text()();
  TextColumn get sessaoId => text()();
  TextColumn get caminhoExcel => text().nullable()();
  TextColumn get caminhoPdf => text().nullable()();
  DateTimeColumn get timestamp => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('ItemHistoricoRow')
class ItensHistorico extends Table {
  TextColumn get id => text()();
  TextColumn get itemId => text()();
  TextColumn get sessaoId => text()();
  TextColumn get materialCodigo => text()();
  TextColumn get acao => text()();
  TextColumn get operadorNome => text()();
  RealColumn get estoqueAnterior => real().nullable()();
  RealColumn get estoqueContado => real().nullable()();
  RealColumn get recebimentoTotal => real().nullable()();
  TextColumn get status => text().nullable()();
  TextColumn get observacao => text().nullable()();
  TextColumn get justificativa => text().nullable()();
  DateTimeColumn get timestamp => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}