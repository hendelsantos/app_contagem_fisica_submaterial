// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $MateriaisTable extends Materiais
    with TableInfo<$MateriaisTable, MaterialCadastro> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MateriaisTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _codigoMeta = const VerificationMeta('codigo');
  @override
  late final GeneratedColumn<String> codigo = GeneratedColumn<String>(
      'codigo', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descricaoMeta =
      const VerificationMeta('descricao');
  @override
  late final GeneratedColumn<String> descricao = GeneratedColumn<String>(
      'descricao', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _fornecedorMeta =
      const VerificationMeta('fornecedor');
  @override
  late final GeneratedColumn<String> fornecedor = GeneratedColumn<String>(
      'fornecedor', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _familiaMeta =
      const VerificationMeta('familia');
  @override
  late final GeneratedColumn<String> familia = GeneratedColumn<String>(
      'familia', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _unidadeMeta =
      const VerificationMeta('unidade');
  @override
  late final GeneratedColumn<String> unidade = GeneratedColumn<String>(
      'unidade', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _sobeSapMeta =
      const VerificationMeta('sobeSap');
  @override
  late final GeneratedColumn<int> sobeSap = GeneratedColumn<int>(
      'sobe_sap', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(1));
  static const VerificationMeta _ativoMeta = const VerificationMeta('ativo');
  @override
  late final GeneratedColumn<bool> ativo = GeneratedColumn<bool>(
      'ativo', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("ativo" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _nomeStockMeta =
      const VerificationMeta('nomeStock');
  @override
  late final GeneratedColumn<String> nomeStock = GeneratedColumn<String>(
      'nome_stock', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        codigo,
        descricao,
        fornecedor,
        familia,
        unidade,
        sobeSap,
        ativo,
        nomeStock
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'materiais';
  @override
  VerificationContext validateIntegrity(Insertable<MaterialCadastro> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('codigo')) {
      context.handle(_codigoMeta,
          codigo.isAcceptableOrUnknown(data['codigo']!, _codigoMeta));
    } else if (isInserting) {
      context.missing(_codigoMeta);
    }
    if (data.containsKey('descricao')) {
      context.handle(_descricaoMeta,
          descricao.isAcceptableOrUnknown(data['descricao']!, _descricaoMeta));
    } else if (isInserting) {
      context.missing(_descricaoMeta);
    }
    if (data.containsKey('fornecedor')) {
      context.handle(
          _fornecedorMeta,
          fornecedor.isAcceptableOrUnknown(
              data['fornecedor']!, _fornecedorMeta));
    } else if (isInserting) {
      context.missing(_fornecedorMeta);
    }
    if (data.containsKey('familia')) {
      context.handle(_familiaMeta,
          familia.isAcceptableOrUnknown(data['familia']!, _familiaMeta));
    } else if (isInserting) {
      context.missing(_familiaMeta);
    }
    if (data.containsKey('unidade')) {
      context.handle(_unidadeMeta,
          unidade.isAcceptableOrUnknown(data['unidade']!, _unidadeMeta));
    } else if (isInserting) {
      context.missing(_unidadeMeta);
    }
    if (data.containsKey('sobe_sap')) {
      context.handle(_sobeSapMeta,
          sobeSap.isAcceptableOrUnknown(data['sobe_sap']!, _sobeSapMeta));
    }
    if (data.containsKey('ativo')) {
      context.handle(
          _ativoMeta, ativo.isAcceptableOrUnknown(data['ativo']!, _ativoMeta));
    }
    if (data.containsKey('nome_stock')) {
      context.handle(_nomeStockMeta,
          nomeStock.isAcceptableOrUnknown(data['nome_stock']!, _nomeStockMeta));
    } else if (isInserting) {
      context.missing(_nomeStockMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {codigo};
  @override
  MaterialCadastro map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MaterialCadastro(
      codigo: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}codigo'])!,
      descricao: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}descricao'])!,
      fornecedor: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}fornecedor'])!,
      familia: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}familia'])!,
      unidade: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}unidade'])!,
      sobeSap: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sobe_sap'])!,
      ativo: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}ativo'])!,
      nomeStock: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}nome_stock'])!,
    );
  }

  @override
  $MateriaisTable createAlias(String alias) {
    return $MateriaisTable(attachedDatabase, alias);
  }
}

class MaterialCadastro extends DataClass
    implements Insertable<MaterialCadastro> {
  final String codigo;
  final String descricao;
  final String fornecedor;
  final String familia;
  final String unidade;
  final int sobeSap;
  final bool ativo;
  final String nomeStock;
  const MaterialCadastro(
      {required this.codigo,
      required this.descricao,
      required this.fornecedor,
      required this.familia,
      required this.unidade,
      required this.sobeSap,
      required this.ativo,
      required this.nomeStock});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['codigo'] = Variable<String>(codigo);
    map['descricao'] = Variable<String>(descricao);
    map['fornecedor'] = Variable<String>(fornecedor);
    map['familia'] = Variable<String>(familia);
    map['unidade'] = Variable<String>(unidade);
    map['sobe_sap'] = Variable<int>(sobeSap);
    map['ativo'] = Variable<bool>(ativo);
    map['nome_stock'] = Variable<String>(nomeStock);
    return map;
  }

  MateriaisCompanion toCompanion(bool nullToAbsent) {
    return MateriaisCompanion(
      codigo: Value(codigo),
      descricao: Value(descricao),
      fornecedor: Value(fornecedor),
      familia: Value(familia),
      unidade: Value(unidade),
      sobeSap: Value(sobeSap),
      ativo: Value(ativo),
      nomeStock: Value(nomeStock),
    );
  }

  factory MaterialCadastro.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MaterialCadastro(
      codigo: serializer.fromJson<String>(json['codigo']),
      descricao: serializer.fromJson<String>(json['descricao']),
      fornecedor: serializer.fromJson<String>(json['fornecedor']),
      familia: serializer.fromJson<String>(json['familia']),
      unidade: serializer.fromJson<String>(json['unidade']),
      sobeSap: serializer.fromJson<int>(json['sobeSap']),
      ativo: serializer.fromJson<bool>(json['ativo']),
      nomeStock: serializer.fromJson<String>(json['nomeStock']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'codigo': serializer.toJson<String>(codigo),
      'descricao': serializer.toJson<String>(descricao),
      'fornecedor': serializer.toJson<String>(fornecedor),
      'familia': serializer.toJson<String>(familia),
      'unidade': serializer.toJson<String>(unidade),
      'sobeSap': serializer.toJson<int>(sobeSap),
      'ativo': serializer.toJson<bool>(ativo),
      'nomeStock': serializer.toJson<String>(nomeStock),
    };
  }

  MaterialCadastro copyWith(
          {String? codigo,
          String? descricao,
          String? fornecedor,
          String? familia,
          String? unidade,
          int? sobeSap,
          bool? ativo,
          String? nomeStock}) =>
      MaterialCadastro(
        codigo: codigo ?? this.codigo,
        descricao: descricao ?? this.descricao,
        fornecedor: fornecedor ?? this.fornecedor,
        familia: familia ?? this.familia,
        unidade: unidade ?? this.unidade,
        sobeSap: sobeSap ?? this.sobeSap,
        ativo: ativo ?? this.ativo,
        nomeStock: nomeStock ?? this.nomeStock,
      );
  MaterialCadastro copyWithCompanion(MateriaisCompanion data) {
    return MaterialCadastro(
      codigo: data.codigo.present ? data.codigo.value : this.codigo,
      descricao: data.descricao.present ? data.descricao.value : this.descricao,
      fornecedor:
          data.fornecedor.present ? data.fornecedor.value : this.fornecedor,
      familia: data.familia.present ? data.familia.value : this.familia,
      unidade: data.unidade.present ? data.unidade.value : this.unidade,
      sobeSap: data.sobeSap.present ? data.sobeSap.value : this.sobeSap,
      ativo: data.ativo.present ? data.ativo.value : this.ativo,
      nomeStock: data.nomeStock.present ? data.nomeStock.value : this.nomeStock,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MaterialCadastro(')
          ..write('codigo: $codigo, ')
          ..write('descricao: $descricao, ')
          ..write('fornecedor: $fornecedor, ')
          ..write('familia: $familia, ')
          ..write('unidade: $unidade, ')
          ..write('sobeSap: $sobeSap, ')
          ..write('ativo: $ativo, ')
          ..write('nomeStock: $nomeStock')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(codigo, descricao, fornecedor, familia,
      unidade, sobeSap, ativo, nomeStock);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MaterialCadastro &&
          other.codigo == this.codigo &&
          other.descricao == this.descricao &&
          other.fornecedor == this.fornecedor &&
          other.familia == this.familia &&
          other.unidade == this.unidade &&
          other.sobeSap == this.sobeSap &&
          other.ativo == this.ativo &&
          other.nomeStock == this.nomeStock);
}

class MateriaisCompanion extends UpdateCompanion<MaterialCadastro> {
  final Value<String> codigo;
  final Value<String> descricao;
  final Value<String> fornecedor;
  final Value<String> familia;
  final Value<String> unidade;
  final Value<int> sobeSap;
  final Value<bool> ativo;
  final Value<String> nomeStock;
  final Value<int> rowid;
  const MateriaisCompanion({
    this.codigo = const Value.absent(),
    this.descricao = const Value.absent(),
    this.fornecedor = const Value.absent(),
    this.familia = const Value.absent(),
    this.unidade = const Value.absent(),
    this.sobeSap = const Value.absent(),
    this.ativo = const Value.absent(),
    this.nomeStock = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MateriaisCompanion.insert({
    required String codigo,
    required String descricao,
    required String fornecedor,
    required String familia,
    required String unidade,
    this.sobeSap = const Value.absent(),
    this.ativo = const Value.absent(),
    required String nomeStock,
    this.rowid = const Value.absent(),
  })  : codigo = Value(codigo),
        descricao = Value(descricao),
        fornecedor = Value(fornecedor),
        familia = Value(familia),
        unidade = Value(unidade),
        nomeStock = Value(nomeStock);
  static Insertable<MaterialCadastro> custom({
    Expression<String>? codigo,
    Expression<String>? descricao,
    Expression<String>? fornecedor,
    Expression<String>? familia,
    Expression<String>? unidade,
    Expression<int>? sobeSap,
    Expression<bool>? ativo,
    Expression<String>? nomeStock,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (codigo != null) 'codigo': codigo,
      if (descricao != null) 'descricao': descricao,
      if (fornecedor != null) 'fornecedor': fornecedor,
      if (familia != null) 'familia': familia,
      if (unidade != null) 'unidade': unidade,
      if (sobeSap != null) 'sobe_sap': sobeSap,
      if (ativo != null) 'ativo': ativo,
      if (nomeStock != null) 'nome_stock': nomeStock,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MateriaisCompanion copyWith(
      {Value<String>? codigo,
      Value<String>? descricao,
      Value<String>? fornecedor,
      Value<String>? familia,
      Value<String>? unidade,
      Value<int>? sobeSap,
      Value<bool>? ativo,
      Value<String>? nomeStock,
      Value<int>? rowid}) {
    return MateriaisCompanion(
      codigo: codigo ?? this.codigo,
      descricao: descricao ?? this.descricao,
      fornecedor: fornecedor ?? this.fornecedor,
      familia: familia ?? this.familia,
      unidade: unidade ?? this.unidade,
      sobeSap: sobeSap ?? this.sobeSap,
      ativo: ativo ?? this.ativo,
      nomeStock: nomeStock ?? this.nomeStock,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (codigo.present) {
      map['codigo'] = Variable<String>(codigo.value);
    }
    if (descricao.present) {
      map['descricao'] = Variable<String>(descricao.value);
    }
    if (fornecedor.present) {
      map['fornecedor'] = Variable<String>(fornecedor.value);
    }
    if (familia.present) {
      map['familia'] = Variable<String>(familia.value);
    }
    if (unidade.present) {
      map['unidade'] = Variable<String>(unidade.value);
    }
    if (sobeSap.present) {
      map['sobe_sap'] = Variable<int>(sobeSap.value);
    }
    if (ativo.present) {
      map['ativo'] = Variable<bool>(ativo.value);
    }
    if (nomeStock.present) {
      map['nome_stock'] = Variable<String>(nomeStock.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MateriaisCompanion(')
          ..write('codigo: $codigo, ')
          ..write('descricao: $descricao, ')
          ..write('fornecedor: $fornecedor, ')
          ..write('familia: $familia, ')
          ..write('unidade: $unidade, ')
          ..write('sobeSap: $sobeSap, ')
          ..write('ativo: $ativo, ')
          ..write('nomeStock: $nomeStock, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $FornecedoresTable extends Fornecedores
    with TableInfo<$FornecedoresTable, FornecedorRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FornecedoresTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _nomeMeta = const VerificationMeta('nome');
  @override
  late final GeneratedColumn<String> nome = GeneratedColumn<String>(
      'nome', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _ordemMeta = const VerificationMeta('ordem');
  @override
  late final GeneratedColumn<int> ordem = GeneratedColumn<int>(
      'ordem', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [nome, ordem];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'fornecedores';
  @override
  VerificationContext validateIntegrity(Insertable<FornecedorRow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('nome')) {
      context.handle(
          _nomeMeta, nome.isAcceptableOrUnknown(data['nome']!, _nomeMeta));
    } else if (isInserting) {
      context.missing(_nomeMeta);
    }
    if (data.containsKey('ordem')) {
      context.handle(
          _ordemMeta, ordem.isAcceptableOrUnknown(data['ordem']!, _ordemMeta));
    } else if (isInserting) {
      context.missing(_ordemMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {nome};
  @override
  FornecedorRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FornecedorRow(
      nome: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}nome'])!,
      ordem: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}ordem'])!,
    );
  }

  @override
  $FornecedoresTable createAlias(String alias) {
    return $FornecedoresTable(attachedDatabase, alias);
  }
}

class FornecedorRow extends DataClass implements Insertable<FornecedorRow> {
  final String nome;
  final int ordem;
  const FornecedorRow({required this.nome, required this.ordem});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['nome'] = Variable<String>(nome);
    map['ordem'] = Variable<int>(ordem);
    return map;
  }

  FornecedoresCompanion toCompanion(bool nullToAbsent) {
    return FornecedoresCompanion(
      nome: Value(nome),
      ordem: Value(ordem),
    );
  }

  factory FornecedorRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FornecedorRow(
      nome: serializer.fromJson<String>(json['nome']),
      ordem: serializer.fromJson<int>(json['ordem']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'nome': serializer.toJson<String>(nome),
      'ordem': serializer.toJson<int>(ordem),
    };
  }

  FornecedorRow copyWith({String? nome, int? ordem}) => FornecedorRow(
        nome: nome ?? this.nome,
        ordem: ordem ?? this.ordem,
      );
  FornecedorRow copyWithCompanion(FornecedoresCompanion data) {
    return FornecedorRow(
      nome: data.nome.present ? data.nome.value : this.nome,
      ordem: data.ordem.present ? data.ordem.value : this.ordem,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FornecedorRow(')
          ..write('nome: $nome, ')
          ..write('ordem: $ordem')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(nome, ordem);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FornecedorRow &&
          other.nome == this.nome &&
          other.ordem == this.ordem);
}

class FornecedoresCompanion extends UpdateCompanion<FornecedorRow> {
  final Value<String> nome;
  final Value<int> ordem;
  final Value<int> rowid;
  const FornecedoresCompanion({
    this.nome = const Value.absent(),
    this.ordem = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FornecedoresCompanion.insert({
    required String nome,
    required int ordem,
    this.rowid = const Value.absent(),
  })  : nome = Value(nome),
        ordem = Value(ordem);
  static Insertable<FornecedorRow> custom({
    Expression<String>? nome,
    Expression<int>? ordem,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (nome != null) 'nome': nome,
      if (ordem != null) 'ordem': ordem,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FornecedoresCompanion copyWith(
      {Value<String>? nome, Value<int>? ordem, Value<int>? rowid}) {
    return FornecedoresCompanion(
      nome: nome ?? this.nome,
      ordem: ordem ?? this.ordem,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (nome.present) {
      map['nome'] = Variable<String>(nome.value);
    }
    if (ordem.present) {
      map['ordem'] = Variable<int>(ordem.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FornecedoresCompanion(')
          ..write('nome: $nome, ')
          ..write('ordem: $ordem, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $EstoqueReferenciaTable extends EstoqueReferencia
    with TableInfo<$EstoqueReferenciaTable, EstoqueReferenciaRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EstoqueReferenciaTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _materialCodigoMeta =
      const VerificationMeta('materialCodigo');
  @override
  late final GeneratedColumn<String> materialCodigo = GeneratedColumn<String>(
      'material_codigo', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _estoqueFinalKgMeta =
      const VerificationMeta('estoqueFinalKg');
  @override
  late final GeneratedColumn<double> estoqueFinalKg = GeneratedColumn<double>(
      'estoque_final_kg', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _sessaoOrigemIdMeta =
      const VerificationMeta('sessaoOrigemId');
  @override
  late final GeneratedColumn<String> sessaoOrigemId = GeneratedColumn<String>(
      'sessao_origem_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _dataReferenciaMeta =
      const VerificationMeta('dataReferencia');
  @override
  late final GeneratedColumn<DateTime> dataReferencia =
      GeneratedColumn<DateTime>('data_referencia', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [materialCodigo, estoqueFinalKg, sessaoOrigemId, dataReferencia];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'estoque_referencia';
  @override
  VerificationContext validateIntegrity(
      Insertable<EstoqueReferenciaRow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('material_codigo')) {
      context.handle(
          _materialCodigoMeta,
          materialCodigo.isAcceptableOrUnknown(
              data['material_codigo']!, _materialCodigoMeta));
    } else if (isInserting) {
      context.missing(_materialCodigoMeta);
    }
    if (data.containsKey('estoque_final_kg')) {
      context.handle(
          _estoqueFinalKgMeta,
          estoqueFinalKg.isAcceptableOrUnknown(
              data['estoque_final_kg']!, _estoqueFinalKgMeta));
    } else if (isInserting) {
      context.missing(_estoqueFinalKgMeta);
    }
    if (data.containsKey('sessao_origem_id')) {
      context.handle(
          _sessaoOrigemIdMeta,
          sessaoOrigemId.isAcceptableOrUnknown(
              data['sessao_origem_id']!, _sessaoOrigemIdMeta));
    }
    if (data.containsKey('data_referencia')) {
      context.handle(
          _dataReferenciaMeta,
          dataReferencia.isAcceptableOrUnknown(
              data['data_referencia']!, _dataReferenciaMeta));
    } else if (isInserting) {
      context.missing(_dataReferenciaMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {materialCodigo};
  @override
  EstoqueReferenciaRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EstoqueReferenciaRow(
      materialCodigo: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}material_codigo'])!,
      estoqueFinalKg: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}estoque_final_kg'])!,
      sessaoOrigemId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}sessao_origem_id']),
      dataReferencia: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}data_referencia'])!,
    );
  }

  @override
  $EstoqueReferenciaTable createAlias(String alias) {
    return $EstoqueReferenciaTable(attachedDatabase, alias);
  }
}

class EstoqueReferenciaRow extends DataClass
    implements Insertable<EstoqueReferenciaRow> {
  final String materialCodigo;
  final double estoqueFinalKg;
  final String? sessaoOrigemId;
  final DateTime dataReferencia;
  const EstoqueReferenciaRow(
      {required this.materialCodigo,
      required this.estoqueFinalKg,
      this.sessaoOrigemId,
      required this.dataReferencia});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['material_codigo'] = Variable<String>(materialCodigo);
    map['estoque_final_kg'] = Variable<double>(estoqueFinalKg);
    if (!nullToAbsent || sessaoOrigemId != null) {
      map['sessao_origem_id'] = Variable<String>(sessaoOrigemId);
    }
    map['data_referencia'] = Variable<DateTime>(dataReferencia);
    return map;
  }

  EstoqueReferenciaCompanion toCompanion(bool nullToAbsent) {
    return EstoqueReferenciaCompanion(
      materialCodigo: Value(materialCodigo),
      estoqueFinalKg: Value(estoqueFinalKg),
      sessaoOrigemId: sessaoOrigemId == null && nullToAbsent
          ? const Value.absent()
          : Value(sessaoOrigemId),
      dataReferencia: Value(dataReferencia),
    );
  }

  factory EstoqueReferenciaRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EstoqueReferenciaRow(
      materialCodigo: serializer.fromJson<String>(json['materialCodigo']),
      estoqueFinalKg: serializer.fromJson<double>(json['estoqueFinalKg']),
      sessaoOrigemId: serializer.fromJson<String?>(json['sessaoOrigemId']),
      dataReferencia: serializer.fromJson<DateTime>(json['dataReferencia']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'materialCodigo': serializer.toJson<String>(materialCodigo),
      'estoqueFinalKg': serializer.toJson<double>(estoqueFinalKg),
      'sessaoOrigemId': serializer.toJson<String?>(sessaoOrigemId),
      'dataReferencia': serializer.toJson<DateTime>(dataReferencia),
    };
  }

  EstoqueReferenciaRow copyWith(
          {String? materialCodigo,
          double? estoqueFinalKg,
          Value<String?> sessaoOrigemId = const Value.absent(),
          DateTime? dataReferencia}) =>
      EstoqueReferenciaRow(
        materialCodigo: materialCodigo ?? this.materialCodigo,
        estoqueFinalKg: estoqueFinalKg ?? this.estoqueFinalKg,
        sessaoOrigemId:
            sessaoOrigemId.present ? sessaoOrigemId.value : this.sessaoOrigemId,
        dataReferencia: dataReferencia ?? this.dataReferencia,
      );
  EstoqueReferenciaRow copyWithCompanion(EstoqueReferenciaCompanion data) {
    return EstoqueReferenciaRow(
      materialCodigo: data.materialCodigo.present
          ? data.materialCodigo.value
          : this.materialCodigo,
      estoqueFinalKg: data.estoqueFinalKg.present
          ? data.estoqueFinalKg.value
          : this.estoqueFinalKg,
      sessaoOrigemId: data.sessaoOrigemId.present
          ? data.sessaoOrigemId.value
          : this.sessaoOrigemId,
      dataReferencia: data.dataReferencia.present
          ? data.dataReferencia.value
          : this.dataReferencia,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EstoqueReferenciaRow(')
          ..write('materialCodigo: $materialCodigo, ')
          ..write('estoqueFinalKg: $estoqueFinalKg, ')
          ..write('sessaoOrigemId: $sessaoOrigemId, ')
          ..write('dataReferencia: $dataReferencia')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      materialCodigo, estoqueFinalKg, sessaoOrigemId, dataReferencia);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EstoqueReferenciaRow &&
          other.materialCodigo == this.materialCodigo &&
          other.estoqueFinalKg == this.estoqueFinalKg &&
          other.sessaoOrigemId == this.sessaoOrigemId &&
          other.dataReferencia == this.dataReferencia);
}

class EstoqueReferenciaCompanion extends UpdateCompanion<EstoqueReferenciaRow> {
  final Value<String> materialCodigo;
  final Value<double> estoqueFinalKg;
  final Value<String?> sessaoOrigemId;
  final Value<DateTime> dataReferencia;
  final Value<int> rowid;
  const EstoqueReferenciaCompanion({
    this.materialCodigo = const Value.absent(),
    this.estoqueFinalKg = const Value.absent(),
    this.sessaoOrigemId = const Value.absent(),
    this.dataReferencia = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  EstoqueReferenciaCompanion.insert({
    required String materialCodigo,
    required double estoqueFinalKg,
    this.sessaoOrigemId = const Value.absent(),
    required DateTime dataReferencia,
    this.rowid = const Value.absent(),
  })  : materialCodigo = Value(materialCodigo),
        estoqueFinalKg = Value(estoqueFinalKg),
        dataReferencia = Value(dataReferencia);
  static Insertable<EstoqueReferenciaRow> custom({
    Expression<String>? materialCodigo,
    Expression<double>? estoqueFinalKg,
    Expression<String>? sessaoOrigemId,
    Expression<DateTime>? dataReferencia,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (materialCodigo != null) 'material_codigo': materialCodigo,
      if (estoqueFinalKg != null) 'estoque_final_kg': estoqueFinalKg,
      if (sessaoOrigemId != null) 'sessao_origem_id': sessaoOrigemId,
      if (dataReferencia != null) 'data_referencia': dataReferencia,
      if (rowid != null) 'rowid': rowid,
    });
  }

  EstoqueReferenciaCompanion copyWith(
      {Value<String>? materialCodigo,
      Value<double>? estoqueFinalKg,
      Value<String?>? sessaoOrigemId,
      Value<DateTime>? dataReferencia,
      Value<int>? rowid}) {
    return EstoqueReferenciaCompanion(
      materialCodigo: materialCodigo ?? this.materialCodigo,
      estoqueFinalKg: estoqueFinalKg ?? this.estoqueFinalKg,
      sessaoOrigemId: sessaoOrigemId ?? this.sessaoOrigemId,
      dataReferencia: dataReferencia ?? this.dataReferencia,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (materialCodigo.present) {
      map['material_codigo'] = Variable<String>(materialCodigo.value);
    }
    if (estoqueFinalKg.present) {
      map['estoque_final_kg'] = Variable<double>(estoqueFinalKg.value);
    }
    if (sessaoOrigemId.present) {
      map['sessao_origem_id'] = Variable<String>(sessaoOrigemId.value);
    }
    if (dataReferencia.present) {
      map['data_referencia'] = Variable<DateTime>(dataReferencia.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EstoqueReferenciaCompanion(')
          ..write('materialCodigo: $materialCodigo, ')
          ..write('estoqueFinalKg: $estoqueFinalKg, ')
          ..write('sessaoOrigemId: $sessaoOrigemId, ')
          ..write('dataReferencia: $dataReferencia, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SessoesTable extends Sessoes with TableInfo<$SessoesTable, SessaoRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SessoesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _operadorNomeMeta =
      const VerificationMeta('operadorNome');
  @override
  late final GeneratedColumn<String> operadorNome = GeneratedColumn<String>(
      'operador_nome', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _operadorMatriculaMeta =
      const VerificationMeta('operadorMatricula');
  @override
  late final GeneratedColumn<String> operadorMatricula =
      GeneratedColumn<String>('operador_matricula', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dataInicioMeta =
      const VerificationMeta('dataInicio');
  @override
  late final GeneratedColumn<DateTime> dataInicio = GeneratedColumn<DateTime>(
      'data_inicio', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _dataFimPrevistaMeta =
      const VerificationMeta('dataFimPrevista');
  @override
  late final GeneratedColumn<DateTime> dataFimPrevista =
      GeneratedColumn<DateTime>('data_fim_prevista', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _dataFimRealMeta =
      const VerificationMeta('dataFimReal');
  @override
  late final GeneratedColumn<DateTime> dataFimReal = GeneratedColumn<DateTime>(
      'data_fim_real', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _versaoCadastroMeta =
      const VerificationMeta('versaoCadastro');
  @override
  late final GeneratedColumn<String> versaoCadastro = GeneratedColumn<String>(
      'versao_cadastro', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _aparelhoMeta =
      const VerificationMeta('aparelho');
  @override
  late final GeneratedColumn<String> aparelho = GeneratedColumn<String>(
      'aparelho', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        operadorNome,
        operadorMatricula,
        dataInicio,
        dataFimPrevista,
        dataFimReal,
        status,
        versaoCadastro,
        aparelho
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sessoes';
  @override
  VerificationContext validateIntegrity(Insertable<SessaoRow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('operador_nome')) {
      context.handle(
          _operadorNomeMeta,
          operadorNome.isAcceptableOrUnknown(
              data['operador_nome']!, _operadorNomeMeta));
    } else if (isInserting) {
      context.missing(_operadorNomeMeta);
    }
    if (data.containsKey('operador_matricula')) {
      context.handle(
          _operadorMatriculaMeta,
          operadorMatricula.isAcceptableOrUnknown(
              data['operador_matricula']!, _operadorMatriculaMeta));
    } else if (isInserting) {
      context.missing(_operadorMatriculaMeta);
    }
    if (data.containsKey('data_inicio')) {
      context.handle(
          _dataInicioMeta,
          dataInicio.isAcceptableOrUnknown(
              data['data_inicio']!, _dataInicioMeta));
    } else if (isInserting) {
      context.missing(_dataInicioMeta);
    }
    if (data.containsKey('data_fim_prevista')) {
      context.handle(
          _dataFimPrevistaMeta,
          dataFimPrevista.isAcceptableOrUnknown(
              data['data_fim_prevista']!, _dataFimPrevistaMeta));
    }
    if (data.containsKey('data_fim_real')) {
      context.handle(
          _dataFimRealMeta,
          dataFimReal.isAcceptableOrUnknown(
              data['data_fim_real']!, _dataFimRealMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('versao_cadastro')) {
      context.handle(
          _versaoCadastroMeta,
          versaoCadastro.isAcceptableOrUnknown(
              data['versao_cadastro']!, _versaoCadastroMeta));
    } else if (isInserting) {
      context.missing(_versaoCadastroMeta);
    }
    if (data.containsKey('aparelho')) {
      context.handle(_aparelhoMeta,
          aparelho.isAcceptableOrUnknown(data['aparelho']!, _aparelhoMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SessaoRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SessaoRow(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      operadorNome: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}operador_nome'])!,
      operadorMatricula: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}operador_matricula'])!,
      dataInicio: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}data_inicio'])!,
      dataFimPrevista: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}data_fim_prevista']),
      dataFimReal: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}data_fim_real']),
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      versaoCadastro: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}versao_cadastro'])!,
      aparelho: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}aparelho']),
    );
  }

  @override
  $SessoesTable createAlias(String alias) {
    return $SessoesTable(attachedDatabase, alias);
  }
}

class SessaoRow extends DataClass implements Insertable<SessaoRow> {
  final String id;
  final String operadorNome;
  final String operadorMatricula;
  final DateTime dataInicio;
  final DateTime? dataFimPrevista;
  final DateTime? dataFimReal;
  final String status;
  final String versaoCadastro;
  final String? aparelho;
  const SessaoRow(
      {required this.id,
      required this.operadorNome,
      required this.operadorMatricula,
      required this.dataInicio,
      this.dataFimPrevista,
      this.dataFimReal,
      required this.status,
      required this.versaoCadastro,
      this.aparelho});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['operador_nome'] = Variable<String>(operadorNome);
    map['operador_matricula'] = Variable<String>(operadorMatricula);
    map['data_inicio'] = Variable<DateTime>(dataInicio);
    if (!nullToAbsent || dataFimPrevista != null) {
      map['data_fim_prevista'] = Variable<DateTime>(dataFimPrevista);
    }
    if (!nullToAbsent || dataFimReal != null) {
      map['data_fim_real'] = Variable<DateTime>(dataFimReal);
    }
    map['status'] = Variable<String>(status);
    map['versao_cadastro'] = Variable<String>(versaoCadastro);
    if (!nullToAbsent || aparelho != null) {
      map['aparelho'] = Variable<String>(aparelho);
    }
    return map;
  }

  SessoesCompanion toCompanion(bool nullToAbsent) {
    return SessoesCompanion(
      id: Value(id),
      operadorNome: Value(operadorNome),
      operadorMatricula: Value(operadorMatricula),
      dataInicio: Value(dataInicio),
      dataFimPrevista: dataFimPrevista == null && nullToAbsent
          ? const Value.absent()
          : Value(dataFimPrevista),
      dataFimReal: dataFimReal == null && nullToAbsent
          ? const Value.absent()
          : Value(dataFimReal),
      status: Value(status),
      versaoCadastro: Value(versaoCadastro),
      aparelho: aparelho == null && nullToAbsent
          ? const Value.absent()
          : Value(aparelho),
    );
  }

  factory SessaoRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SessaoRow(
      id: serializer.fromJson<String>(json['id']),
      operadorNome: serializer.fromJson<String>(json['operadorNome']),
      operadorMatricula: serializer.fromJson<String>(json['operadorMatricula']),
      dataInicio: serializer.fromJson<DateTime>(json['dataInicio']),
      dataFimPrevista: serializer.fromJson<DateTime?>(json['dataFimPrevista']),
      dataFimReal: serializer.fromJson<DateTime?>(json['dataFimReal']),
      status: serializer.fromJson<String>(json['status']),
      versaoCadastro: serializer.fromJson<String>(json['versaoCadastro']),
      aparelho: serializer.fromJson<String?>(json['aparelho']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'operadorNome': serializer.toJson<String>(operadorNome),
      'operadorMatricula': serializer.toJson<String>(operadorMatricula),
      'dataInicio': serializer.toJson<DateTime>(dataInicio),
      'dataFimPrevista': serializer.toJson<DateTime?>(dataFimPrevista),
      'dataFimReal': serializer.toJson<DateTime?>(dataFimReal),
      'status': serializer.toJson<String>(status),
      'versaoCadastro': serializer.toJson<String>(versaoCadastro),
      'aparelho': serializer.toJson<String?>(aparelho),
    };
  }

  SessaoRow copyWith(
          {String? id,
          String? operadorNome,
          String? operadorMatricula,
          DateTime? dataInicio,
          Value<DateTime?> dataFimPrevista = const Value.absent(),
          Value<DateTime?> dataFimReal = const Value.absent(),
          String? status,
          String? versaoCadastro,
          Value<String?> aparelho = const Value.absent()}) =>
      SessaoRow(
        id: id ?? this.id,
        operadorNome: operadorNome ?? this.operadorNome,
        operadorMatricula: operadorMatricula ?? this.operadorMatricula,
        dataInicio: dataInicio ?? this.dataInicio,
        dataFimPrevista: dataFimPrevista.present
            ? dataFimPrevista.value
            : this.dataFimPrevista,
        dataFimReal: dataFimReal.present ? dataFimReal.value : this.dataFimReal,
        status: status ?? this.status,
        versaoCadastro: versaoCadastro ?? this.versaoCadastro,
        aparelho: aparelho.present ? aparelho.value : this.aparelho,
      );
  SessaoRow copyWithCompanion(SessoesCompanion data) {
    return SessaoRow(
      id: data.id.present ? data.id.value : this.id,
      operadorNome: data.operadorNome.present
          ? data.operadorNome.value
          : this.operadorNome,
      operadorMatricula: data.operadorMatricula.present
          ? data.operadorMatricula.value
          : this.operadorMatricula,
      dataInicio:
          data.dataInicio.present ? data.dataInicio.value : this.dataInicio,
      dataFimPrevista: data.dataFimPrevista.present
          ? data.dataFimPrevista.value
          : this.dataFimPrevista,
      dataFimReal:
          data.dataFimReal.present ? data.dataFimReal.value : this.dataFimReal,
      status: data.status.present ? data.status.value : this.status,
      versaoCadastro: data.versaoCadastro.present
          ? data.versaoCadastro.value
          : this.versaoCadastro,
      aparelho: data.aparelho.present ? data.aparelho.value : this.aparelho,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SessaoRow(')
          ..write('id: $id, ')
          ..write('operadorNome: $operadorNome, ')
          ..write('operadorMatricula: $operadorMatricula, ')
          ..write('dataInicio: $dataInicio, ')
          ..write('dataFimPrevista: $dataFimPrevista, ')
          ..write('dataFimReal: $dataFimReal, ')
          ..write('status: $status, ')
          ..write('versaoCadastro: $versaoCadastro, ')
          ..write('aparelho: $aparelho')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      operadorNome,
      operadorMatricula,
      dataInicio,
      dataFimPrevista,
      dataFimReal,
      status,
      versaoCadastro,
      aparelho);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SessaoRow &&
          other.id == this.id &&
          other.operadorNome == this.operadorNome &&
          other.operadorMatricula == this.operadorMatricula &&
          other.dataInicio == this.dataInicio &&
          other.dataFimPrevista == this.dataFimPrevista &&
          other.dataFimReal == this.dataFimReal &&
          other.status == this.status &&
          other.versaoCadastro == this.versaoCadastro &&
          other.aparelho == this.aparelho);
}

class SessoesCompanion extends UpdateCompanion<SessaoRow> {
  final Value<String> id;
  final Value<String> operadorNome;
  final Value<String> operadorMatricula;
  final Value<DateTime> dataInicio;
  final Value<DateTime?> dataFimPrevista;
  final Value<DateTime?> dataFimReal;
  final Value<String> status;
  final Value<String> versaoCadastro;
  final Value<String?> aparelho;
  final Value<int> rowid;
  const SessoesCompanion({
    this.id = const Value.absent(),
    this.operadorNome = const Value.absent(),
    this.operadorMatricula = const Value.absent(),
    this.dataInicio = const Value.absent(),
    this.dataFimPrevista = const Value.absent(),
    this.dataFimReal = const Value.absent(),
    this.status = const Value.absent(),
    this.versaoCadastro = const Value.absent(),
    this.aparelho = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SessoesCompanion.insert({
    required String id,
    required String operadorNome,
    required String operadorMatricula,
    required DateTime dataInicio,
    this.dataFimPrevista = const Value.absent(),
    this.dataFimReal = const Value.absent(),
    required String status,
    required String versaoCadastro,
    this.aparelho = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        operadorNome = Value(operadorNome),
        operadorMatricula = Value(operadorMatricula),
        dataInicio = Value(dataInicio),
        status = Value(status),
        versaoCadastro = Value(versaoCadastro);
  static Insertable<SessaoRow> custom({
    Expression<String>? id,
    Expression<String>? operadorNome,
    Expression<String>? operadorMatricula,
    Expression<DateTime>? dataInicio,
    Expression<DateTime>? dataFimPrevista,
    Expression<DateTime>? dataFimReal,
    Expression<String>? status,
    Expression<String>? versaoCadastro,
    Expression<String>? aparelho,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (operadorNome != null) 'operador_nome': operadorNome,
      if (operadorMatricula != null) 'operador_matricula': operadorMatricula,
      if (dataInicio != null) 'data_inicio': dataInicio,
      if (dataFimPrevista != null) 'data_fim_prevista': dataFimPrevista,
      if (dataFimReal != null) 'data_fim_real': dataFimReal,
      if (status != null) 'status': status,
      if (versaoCadastro != null) 'versao_cadastro': versaoCadastro,
      if (aparelho != null) 'aparelho': aparelho,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SessoesCompanion copyWith(
      {Value<String>? id,
      Value<String>? operadorNome,
      Value<String>? operadorMatricula,
      Value<DateTime>? dataInicio,
      Value<DateTime?>? dataFimPrevista,
      Value<DateTime?>? dataFimReal,
      Value<String>? status,
      Value<String>? versaoCadastro,
      Value<String?>? aparelho,
      Value<int>? rowid}) {
    return SessoesCompanion(
      id: id ?? this.id,
      operadorNome: operadorNome ?? this.operadorNome,
      operadorMatricula: operadorMatricula ?? this.operadorMatricula,
      dataInicio: dataInicio ?? this.dataInicio,
      dataFimPrevista: dataFimPrevista ?? this.dataFimPrevista,
      dataFimReal: dataFimReal ?? this.dataFimReal,
      status: status ?? this.status,
      versaoCadastro: versaoCadastro ?? this.versaoCadastro,
      aparelho: aparelho ?? this.aparelho,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (operadorNome.present) {
      map['operador_nome'] = Variable<String>(operadorNome.value);
    }
    if (operadorMatricula.present) {
      map['operador_matricula'] = Variable<String>(operadorMatricula.value);
    }
    if (dataInicio.present) {
      map['data_inicio'] = Variable<DateTime>(dataInicio.value);
    }
    if (dataFimPrevista.present) {
      map['data_fim_prevista'] = Variable<DateTime>(dataFimPrevista.value);
    }
    if (dataFimReal.present) {
      map['data_fim_real'] = Variable<DateTime>(dataFimReal.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (versaoCadastro.present) {
      map['versao_cadastro'] = Variable<String>(versaoCadastro.value);
    }
    if (aparelho.present) {
      map['aparelho'] = Variable<String>(aparelho.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SessoesCompanion(')
          ..write('id: $id, ')
          ..write('operadorNome: $operadorNome, ')
          ..write('operadorMatricula: $operadorMatricula, ')
          ..write('dataInicio: $dataInicio, ')
          ..write('dataFimPrevista: $dataFimPrevista, ')
          ..write('dataFimReal: $dataFimReal, ')
          ..write('status: $status, ')
          ..write('versaoCadastro: $versaoCadastro, ')
          ..write('aparelho: $aparelho, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ItensContagemTable extends ItensContagem
    with TableInfo<$ItensContagemTable, ItemContagemRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ItensContagemTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _sessaoIdMeta =
      const VerificationMeta('sessaoId');
  @override
  late final GeneratedColumn<String> sessaoId = GeneratedColumn<String>(
      'sessao_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _materialCodigoMeta =
      const VerificationMeta('materialCodigo');
  @override
  late final GeneratedColumn<String> materialCodigo = GeneratedColumn<String>(
      'material_codigo', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _estoqueAnteriorMeta =
      const VerificationMeta('estoqueAnterior');
  @override
  late final GeneratedColumn<double> estoqueAnterior = GeneratedColumn<double>(
      'estoque_anterior', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _estoqueContadoMeta =
      const VerificationMeta('estoqueContado');
  @override
  late final GeneratedColumn<double> estoqueContado = GeneratedColumn<double>(
      'estoque_contado', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _linhaEstoqueMeta =
      const VerificationMeta('linhaEstoque');
  @override
  late final GeneratedColumn<double> linhaEstoque = GeneratedColumn<double>(
      'linha_estoque', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _containersJsonMeta =
      const VerificationMeta('containersJson');
  @override
  late final GeneratedColumn<String> containersJson = GeneratedColumn<String>(
      'containers_json', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _cubaEstoqueMeta =
      const VerificationMeta('cubaEstoque');
  @override
  late final GeneratedColumn<double> cubaEstoque = GeneratedColumn<double>(
      'cuba_estoque', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _outrosEstoqueMeta =
      const VerificationMeta('outrosEstoque');
  @override
  late final GeneratedColumn<double> outrosEstoque = GeneratedColumn<double>(
      'outros_estoque', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _recebimentoTotalMeta =
      const VerificationMeta('recebimentoTotal');
  @override
  late final GeneratedColumn<double> recebimentoTotal = GeneratedColumn<double>(
      'recebimento_total', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _observacaoMeta =
      const VerificationMeta('observacao');
  @override
  late final GeneratedColumn<String> observacao = GeneratedColumn<String>(
      'observacao', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _justificativaMeta =
      const VerificationMeta('justificativa');
  @override
  late final GeneratedColumn<String> justificativa = GeneratedColumn<String>(
      'justificativa', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _justificativaFotoPathMeta =
      const VerificationMeta('justificativaFotoPath');
  @override
  late final GeneratedColumn<String> justificativaFotoPath =
      GeneratedColumn<String>('justificativa_foto_path', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _fotoPathMeta =
      const VerificationMeta('fotoPath');
  @override
  late final GeneratedColumn<String> fotoPath = GeneratedColumn<String>(
      'foto_path', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _timestampMeta =
      const VerificationMeta('timestamp');
  @override
  late final GeneratedColumn<DateTime> timestamp = GeneratedColumn<DateTime>(
      'timestamp', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        sessaoId,
        materialCodigo,
        estoqueAnterior,
        estoqueContado,
        linhaEstoque,
        containersJson,
        cubaEstoque,
        outrosEstoque,
        recebimentoTotal,
        observacao,
        justificativa,
        justificativaFotoPath,
        fotoPath,
        status,
        timestamp
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'itens_contagem';
  @override
  VerificationContext validateIntegrity(Insertable<ItemContagemRow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('sessao_id')) {
      context.handle(_sessaoIdMeta,
          sessaoId.isAcceptableOrUnknown(data['sessao_id']!, _sessaoIdMeta));
    } else if (isInserting) {
      context.missing(_sessaoIdMeta);
    }
    if (data.containsKey('material_codigo')) {
      context.handle(
          _materialCodigoMeta,
          materialCodigo.isAcceptableOrUnknown(
              data['material_codigo']!, _materialCodigoMeta));
    } else if (isInserting) {
      context.missing(_materialCodigoMeta);
    }
    if (data.containsKey('estoque_anterior')) {
      context.handle(
          _estoqueAnteriorMeta,
          estoqueAnterior.isAcceptableOrUnknown(
              data['estoque_anterior']!, _estoqueAnteriorMeta));
    } else if (isInserting) {
      context.missing(_estoqueAnteriorMeta);
    }
    if (data.containsKey('estoque_contado')) {
      context.handle(
          _estoqueContadoMeta,
          estoqueContado.isAcceptableOrUnknown(
              data['estoque_contado']!, _estoqueContadoMeta));
    }
    if (data.containsKey('linha_estoque')) {
      context.handle(
          _linhaEstoqueMeta,
          linhaEstoque.isAcceptableOrUnknown(
              data['linha_estoque']!, _linhaEstoqueMeta));
    }
    if (data.containsKey('containers_json')) {
      context.handle(
          _containersJsonMeta,
          containersJson.isAcceptableOrUnknown(
              data['containers_json']!, _containersJsonMeta));
    }
    if (data.containsKey('cuba_estoque')) {
      context.handle(
          _cubaEstoqueMeta,
          cubaEstoque.isAcceptableOrUnknown(
              data['cuba_estoque']!, _cubaEstoqueMeta));
    }
    if (data.containsKey('outros_estoque')) {
      context.handle(
          _outrosEstoqueMeta,
          outrosEstoque.isAcceptableOrUnknown(
              data['outros_estoque']!, _outrosEstoqueMeta));
    }
    if (data.containsKey('recebimento_total')) {
      context.handle(
          _recebimentoTotalMeta,
          recebimentoTotal.isAcceptableOrUnknown(
              data['recebimento_total']!, _recebimentoTotalMeta));
    }
    if (data.containsKey('observacao')) {
      context.handle(
          _observacaoMeta,
          observacao.isAcceptableOrUnknown(
              data['observacao']!, _observacaoMeta));
    }
    if (data.containsKey('justificativa')) {
      context.handle(
          _justificativaMeta,
          justificativa.isAcceptableOrUnknown(
              data['justificativa']!, _justificativaMeta));
    }
    if (data.containsKey('justificativa_foto_path')) {
      context.handle(
          _justificativaFotoPathMeta,
          justificativaFotoPath.isAcceptableOrUnknown(
              data['justificativa_foto_path']!, _justificativaFotoPathMeta));
    }
    if (data.containsKey('foto_path')) {
      context.handle(_fotoPathMeta,
          fotoPath.isAcceptableOrUnknown(data['foto_path']!, _fotoPathMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('timestamp')) {
      context.handle(_timestampMeta,
          timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta));
    } else if (isInserting) {
      context.missing(_timestampMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ItemContagemRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ItemContagemRow(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      sessaoId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sessao_id'])!,
      materialCodigo: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}material_codigo'])!,
      estoqueAnterior: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}estoque_anterior'])!,
      estoqueContado: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}estoque_contado']),
      linhaEstoque: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}linha_estoque']),
      containersJson: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}containers_json']),
      cubaEstoque: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}cuba_estoque']),
      outrosEstoque: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}outros_estoque']),
      recebimentoTotal: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}recebimento_total']),
      observacao: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}observacao']),
      justificativa: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}justificativa']),
      justificativaFotoPath: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}justificativa_foto_path']),
      fotoPath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}foto_path']),
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      timestamp: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}timestamp'])!,
    );
  }

  @override
  $ItensContagemTable createAlias(String alias) {
    return $ItensContagemTable(attachedDatabase, alias);
  }
}

class ItemContagemRow extends DataClass implements Insertable<ItemContagemRow> {
  final String id;
  final String sessaoId;
  final String materialCodigo;
  final double estoqueAnterior;
  final double? estoqueContado;
  final double? linhaEstoque;
  final String? containersJson;
  final double? cubaEstoque;
  final double? outrosEstoque;
  final double? recebimentoTotal;
  final String? observacao;
  final String? justificativa;
  final String? justificativaFotoPath;
  final String? fotoPath;
  final String status;
  final DateTime timestamp;
  const ItemContagemRow(
      {required this.id,
      required this.sessaoId,
      required this.materialCodigo,
      required this.estoqueAnterior,
      this.estoqueContado,
      this.linhaEstoque,
      this.containersJson,
      this.cubaEstoque,
      this.outrosEstoque,
      this.recebimentoTotal,
      this.observacao,
      this.justificativa,
      this.justificativaFotoPath,
      this.fotoPath,
      required this.status,
      required this.timestamp});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['sessao_id'] = Variable<String>(sessaoId);
    map['material_codigo'] = Variable<String>(materialCodigo);
    map['estoque_anterior'] = Variable<double>(estoqueAnterior);
    if (!nullToAbsent || estoqueContado != null) {
      map['estoque_contado'] = Variable<double>(estoqueContado);
    }
    if (!nullToAbsent || linhaEstoque != null) {
      map['linha_estoque'] = Variable<double>(linhaEstoque);
    }
    if (!nullToAbsent || containersJson != null) {
      map['containers_json'] = Variable<String>(containersJson);
    }
    if (!nullToAbsent || cubaEstoque != null) {
      map['cuba_estoque'] = Variable<double>(cubaEstoque);
    }
    if (!nullToAbsent || outrosEstoque != null) {
      map['outros_estoque'] = Variable<double>(outrosEstoque);
    }
    if (!nullToAbsent || recebimentoTotal != null) {
      map['recebimento_total'] = Variable<double>(recebimentoTotal);
    }
    if (!nullToAbsent || observacao != null) {
      map['observacao'] = Variable<String>(observacao);
    }
    if (!nullToAbsent || justificativa != null) {
      map['justificativa'] = Variable<String>(justificativa);
    }
    if (!nullToAbsent || justificativaFotoPath != null) {
      map['justificativa_foto_path'] = Variable<String>(justificativaFotoPath);
    }
    if (!nullToAbsent || fotoPath != null) {
      map['foto_path'] = Variable<String>(fotoPath);
    }
    map['status'] = Variable<String>(status);
    map['timestamp'] = Variable<DateTime>(timestamp);
    return map;
  }

  ItensContagemCompanion toCompanion(bool nullToAbsent) {
    return ItensContagemCompanion(
      id: Value(id),
      sessaoId: Value(sessaoId),
      materialCodigo: Value(materialCodigo),
      estoqueAnterior: Value(estoqueAnterior),
      estoqueContado: estoqueContado == null && nullToAbsent
          ? const Value.absent()
          : Value(estoqueContado),
      linhaEstoque: linhaEstoque == null && nullToAbsent
          ? const Value.absent()
          : Value(linhaEstoque),
      containersJson: containersJson == null && nullToAbsent
          ? const Value.absent()
          : Value(containersJson),
      cubaEstoque: cubaEstoque == null && nullToAbsent
          ? const Value.absent()
          : Value(cubaEstoque),
      outrosEstoque: outrosEstoque == null && nullToAbsent
          ? const Value.absent()
          : Value(outrosEstoque),
      recebimentoTotal: recebimentoTotal == null && nullToAbsent
          ? const Value.absent()
          : Value(recebimentoTotal),
      observacao: observacao == null && nullToAbsent
          ? const Value.absent()
          : Value(observacao),
      justificativa: justificativa == null && nullToAbsent
          ? const Value.absent()
          : Value(justificativa),
      justificativaFotoPath: justificativaFotoPath == null && nullToAbsent
          ? const Value.absent()
          : Value(justificativaFotoPath),
      fotoPath: fotoPath == null && nullToAbsent
          ? const Value.absent()
          : Value(fotoPath),
      status: Value(status),
      timestamp: Value(timestamp),
    );
  }

  factory ItemContagemRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ItemContagemRow(
      id: serializer.fromJson<String>(json['id']),
      sessaoId: serializer.fromJson<String>(json['sessaoId']),
      materialCodigo: serializer.fromJson<String>(json['materialCodigo']),
      estoqueAnterior: serializer.fromJson<double>(json['estoqueAnterior']),
      estoqueContado: serializer.fromJson<double?>(json['estoqueContado']),
      linhaEstoque: serializer.fromJson<double?>(json['linhaEstoque']),
      containersJson: serializer.fromJson<String?>(json['containersJson']),
      cubaEstoque: serializer.fromJson<double?>(json['cubaEstoque']),
      outrosEstoque: serializer.fromJson<double?>(json['outrosEstoque']),
      recebimentoTotal: serializer.fromJson<double?>(json['recebimentoTotal']),
      observacao: serializer.fromJson<String?>(json['observacao']),
      justificativa: serializer.fromJson<String?>(json['justificativa']),
      justificativaFotoPath:
          serializer.fromJson<String?>(json['justificativaFotoPath']),
      fotoPath: serializer.fromJson<String?>(json['fotoPath']),
      status: serializer.fromJson<String>(json['status']),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'sessaoId': serializer.toJson<String>(sessaoId),
      'materialCodigo': serializer.toJson<String>(materialCodigo),
      'estoqueAnterior': serializer.toJson<double>(estoqueAnterior),
      'estoqueContado': serializer.toJson<double?>(estoqueContado),
      'linhaEstoque': serializer.toJson<double?>(linhaEstoque),
      'containersJson': serializer.toJson<String?>(containersJson),
      'cubaEstoque': serializer.toJson<double?>(cubaEstoque),
      'outrosEstoque': serializer.toJson<double?>(outrosEstoque),
      'recebimentoTotal': serializer.toJson<double?>(recebimentoTotal),
      'observacao': serializer.toJson<String?>(observacao),
      'justificativa': serializer.toJson<String?>(justificativa),
      'justificativaFotoPath':
          serializer.toJson<String?>(justificativaFotoPath),
      'fotoPath': serializer.toJson<String?>(fotoPath),
      'status': serializer.toJson<String>(status),
      'timestamp': serializer.toJson<DateTime>(timestamp),
    };
  }

  ItemContagemRow copyWith(
          {String? id,
          String? sessaoId,
          String? materialCodigo,
          double? estoqueAnterior,
          Value<double?> estoqueContado = const Value.absent(),
          Value<double?> linhaEstoque = const Value.absent(),
          Value<String?> containersJson = const Value.absent(),
          Value<double?> cubaEstoque = const Value.absent(),
          Value<double?> outrosEstoque = const Value.absent(),
          Value<double?> recebimentoTotal = const Value.absent(),
          Value<String?> observacao = const Value.absent(),
          Value<String?> justificativa = const Value.absent(),
          Value<String?> justificativaFotoPath = const Value.absent(),
          Value<String?> fotoPath = const Value.absent(),
          String? status,
          DateTime? timestamp}) =>
      ItemContagemRow(
        id: id ?? this.id,
        sessaoId: sessaoId ?? this.sessaoId,
        materialCodigo: materialCodigo ?? this.materialCodigo,
        estoqueAnterior: estoqueAnterior ?? this.estoqueAnterior,
        estoqueContado:
            estoqueContado.present ? estoqueContado.value : this.estoqueContado,
        linhaEstoque:
            linhaEstoque.present ? linhaEstoque.value : this.linhaEstoque,
        containersJson:
            containersJson.present ? containersJson.value : this.containersJson,
        cubaEstoque: cubaEstoque.present ? cubaEstoque.value : this.cubaEstoque,
        outrosEstoque:
            outrosEstoque.present ? outrosEstoque.value : this.outrosEstoque,
        recebimentoTotal: recebimentoTotal.present
            ? recebimentoTotal.value
            : this.recebimentoTotal,
        observacao: observacao.present ? observacao.value : this.observacao,
        justificativa:
            justificativa.present ? justificativa.value : this.justificativa,
        justificativaFotoPath: justificativaFotoPath.present
            ? justificativaFotoPath.value
            : this.justificativaFotoPath,
        fotoPath: fotoPath.present ? fotoPath.value : this.fotoPath,
        status: status ?? this.status,
        timestamp: timestamp ?? this.timestamp,
      );
  ItemContagemRow copyWithCompanion(ItensContagemCompanion data) {
    return ItemContagemRow(
      id: data.id.present ? data.id.value : this.id,
      sessaoId: data.sessaoId.present ? data.sessaoId.value : this.sessaoId,
      materialCodigo: data.materialCodigo.present
          ? data.materialCodigo.value
          : this.materialCodigo,
      estoqueAnterior: data.estoqueAnterior.present
          ? data.estoqueAnterior.value
          : this.estoqueAnterior,
      estoqueContado: data.estoqueContado.present
          ? data.estoqueContado.value
          : this.estoqueContado,
      linhaEstoque: data.linhaEstoque.present
          ? data.linhaEstoque.value
          : this.linhaEstoque,
      containersJson: data.containersJson.present
          ? data.containersJson.value
          : this.containersJson,
      cubaEstoque:
          data.cubaEstoque.present ? data.cubaEstoque.value : this.cubaEstoque,
      outrosEstoque: data.outrosEstoque.present
          ? data.outrosEstoque.value
          : this.outrosEstoque,
      recebimentoTotal: data.recebimentoTotal.present
          ? data.recebimentoTotal.value
          : this.recebimentoTotal,
      observacao:
          data.observacao.present ? data.observacao.value : this.observacao,
      justificativa: data.justificativa.present
          ? data.justificativa.value
          : this.justificativa,
      justificativaFotoPath: data.justificativaFotoPath.present
          ? data.justificativaFotoPath.value
          : this.justificativaFotoPath,
      fotoPath: data.fotoPath.present ? data.fotoPath.value : this.fotoPath,
      status: data.status.present ? data.status.value : this.status,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ItemContagemRow(')
          ..write('id: $id, ')
          ..write('sessaoId: $sessaoId, ')
          ..write('materialCodigo: $materialCodigo, ')
          ..write('estoqueAnterior: $estoqueAnterior, ')
          ..write('estoqueContado: $estoqueContado, ')
          ..write('linhaEstoque: $linhaEstoque, ')
          ..write('containersJson: $containersJson, ')
          ..write('cubaEstoque: $cubaEstoque, ')
          ..write('outrosEstoque: $outrosEstoque, ')
          ..write('recebimentoTotal: $recebimentoTotal, ')
          ..write('observacao: $observacao, ')
          ..write('justificativa: $justificativa, ')
          ..write('justificativaFotoPath: $justificativaFotoPath, ')
          ..write('fotoPath: $fotoPath, ')
          ..write('status: $status, ')
          ..write('timestamp: $timestamp')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      sessaoId,
      materialCodigo,
      estoqueAnterior,
      estoqueContado,
      linhaEstoque,
      containersJson,
      cubaEstoque,
      outrosEstoque,
      recebimentoTotal,
      observacao,
      justificativa,
      justificativaFotoPath,
      fotoPath,
      status,
      timestamp);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ItemContagemRow &&
          other.id == this.id &&
          other.sessaoId == this.sessaoId &&
          other.materialCodigo == this.materialCodigo &&
          other.estoqueAnterior == this.estoqueAnterior &&
          other.estoqueContado == this.estoqueContado &&
          other.linhaEstoque == this.linhaEstoque &&
          other.containersJson == this.containersJson &&
          other.cubaEstoque == this.cubaEstoque &&
          other.outrosEstoque == this.outrosEstoque &&
          other.recebimentoTotal == this.recebimentoTotal &&
          other.observacao == this.observacao &&
          other.justificativa == this.justificativa &&
          other.justificativaFotoPath == this.justificativaFotoPath &&
          other.fotoPath == this.fotoPath &&
          other.status == this.status &&
          other.timestamp == this.timestamp);
}

class ItensContagemCompanion extends UpdateCompanion<ItemContagemRow> {
  final Value<String> id;
  final Value<String> sessaoId;
  final Value<String> materialCodigo;
  final Value<double> estoqueAnterior;
  final Value<double?> estoqueContado;
  final Value<double?> linhaEstoque;
  final Value<String?> containersJson;
  final Value<double?> cubaEstoque;
  final Value<double?> outrosEstoque;
  final Value<double?> recebimentoTotal;
  final Value<String?> observacao;
  final Value<String?> justificativa;
  final Value<String?> justificativaFotoPath;
  final Value<String?> fotoPath;
  final Value<String> status;
  final Value<DateTime> timestamp;
  final Value<int> rowid;
  const ItensContagemCompanion({
    this.id = const Value.absent(),
    this.sessaoId = const Value.absent(),
    this.materialCodigo = const Value.absent(),
    this.estoqueAnterior = const Value.absent(),
    this.estoqueContado = const Value.absent(),
    this.linhaEstoque = const Value.absent(),
    this.containersJson = const Value.absent(),
    this.cubaEstoque = const Value.absent(),
    this.outrosEstoque = const Value.absent(),
    this.recebimentoTotal = const Value.absent(),
    this.observacao = const Value.absent(),
    this.justificativa = const Value.absent(),
    this.justificativaFotoPath = const Value.absent(),
    this.fotoPath = const Value.absent(),
    this.status = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ItensContagemCompanion.insert({
    required String id,
    required String sessaoId,
    required String materialCodigo,
    required double estoqueAnterior,
    this.estoqueContado = const Value.absent(),
    this.linhaEstoque = const Value.absent(),
    this.containersJson = const Value.absent(),
    this.cubaEstoque = const Value.absent(),
    this.outrosEstoque = const Value.absent(),
    this.recebimentoTotal = const Value.absent(),
    this.observacao = const Value.absent(),
    this.justificativa = const Value.absent(),
    this.justificativaFotoPath = const Value.absent(),
    this.fotoPath = const Value.absent(),
    required String status,
    required DateTime timestamp,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        sessaoId = Value(sessaoId),
        materialCodigo = Value(materialCodigo),
        estoqueAnterior = Value(estoqueAnterior),
        status = Value(status),
        timestamp = Value(timestamp);
  static Insertable<ItemContagemRow> custom({
    Expression<String>? id,
    Expression<String>? sessaoId,
    Expression<String>? materialCodigo,
    Expression<double>? estoqueAnterior,
    Expression<double>? estoqueContado,
    Expression<double>? linhaEstoque,
    Expression<String>? containersJson,
    Expression<double>? cubaEstoque,
    Expression<double>? outrosEstoque,
    Expression<double>? recebimentoTotal,
    Expression<String>? observacao,
    Expression<String>? justificativa,
    Expression<String>? justificativaFotoPath,
    Expression<String>? fotoPath,
    Expression<String>? status,
    Expression<DateTime>? timestamp,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sessaoId != null) 'sessao_id': sessaoId,
      if (materialCodigo != null) 'material_codigo': materialCodigo,
      if (estoqueAnterior != null) 'estoque_anterior': estoqueAnterior,
      if (estoqueContado != null) 'estoque_contado': estoqueContado,
      if (linhaEstoque != null) 'linha_estoque': linhaEstoque,
      if (containersJson != null) 'containers_json': containersJson,
      if (cubaEstoque != null) 'cuba_estoque': cubaEstoque,
      if (outrosEstoque != null) 'outros_estoque': outrosEstoque,
      if (recebimentoTotal != null) 'recebimento_total': recebimentoTotal,
      if (observacao != null) 'observacao': observacao,
      if (justificativa != null) 'justificativa': justificativa,
      if (justificativaFotoPath != null)
        'justificativa_foto_path': justificativaFotoPath,
      if (fotoPath != null) 'foto_path': fotoPath,
      if (status != null) 'status': status,
      if (timestamp != null) 'timestamp': timestamp,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ItensContagemCompanion copyWith(
      {Value<String>? id,
      Value<String>? sessaoId,
      Value<String>? materialCodigo,
      Value<double>? estoqueAnterior,
      Value<double?>? estoqueContado,
      Value<double?>? linhaEstoque,
      Value<String?>? containersJson,
      Value<double?>? cubaEstoque,
      Value<double?>? outrosEstoque,
      Value<double?>? recebimentoTotal,
      Value<String?>? observacao,
      Value<String?>? justificativa,
      Value<String?>? justificativaFotoPath,
      Value<String?>? fotoPath,
      Value<String>? status,
      Value<DateTime>? timestamp,
      Value<int>? rowid}) {
    return ItensContagemCompanion(
      id: id ?? this.id,
      sessaoId: sessaoId ?? this.sessaoId,
      materialCodigo: materialCodigo ?? this.materialCodigo,
      estoqueAnterior: estoqueAnterior ?? this.estoqueAnterior,
      estoqueContado: estoqueContado ?? this.estoqueContado,
      linhaEstoque: linhaEstoque ?? this.linhaEstoque,
      containersJson: containersJson ?? this.containersJson,
      cubaEstoque: cubaEstoque ?? this.cubaEstoque,
      outrosEstoque: outrosEstoque ?? this.outrosEstoque,
      recebimentoTotal: recebimentoTotal ?? this.recebimentoTotal,
      observacao: observacao ?? this.observacao,
      justificativa: justificativa ?? this.justificativa,
      justificativaFotoPath:
          justificativaFotoPath ?? this.justificativaFotoPath,
      fotoPath: fotoPath ?? this.fotoPath,
      status: status ?? this.status,
      timestamp: timestamp ?? this.timestamp,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (sessaoId.present) {
      map['sessao_id'] = Variable<String>(sessaoId.value);
    }
    if (materialCodigo.present) {
      map['material_codigo'] = Variable<String>(materialCodigo.value);
    }
    if (estoqueAnterior.present) {
      map['estoque_anterior'] = Variable<double>(estoqueAnterior.value);
    }
    if (estoqueContado.present) {
      map['estoque_contado'] = Variable<double>(estoqueContado.value);
    }
    if (linhaEstoque.present) {
      map['linha_estoque'] = Variable<double>(linhaEstoque.value);
    }
    if (containersJson.present) {
      map['containers_json'] = Variable<String>(containersJson.value);
    }
    if (cubaEstoque.present) {
      map['cuba_estoque'] = Variable<double>(cubaEstoque.value);
    }
    if (outrosEstoque.present) {
      map['outros_estoque'] = Variable<double>(outrosEstoque.value);
    }
    if (recebimentoTotal.present) {
      map['recebimento_total'] = Variable<double>(recebimentoTotal.value);
    }
    if (observacao.present) {
      map['observacao'] = Variable<String>(observacao.value);
    }
    if (justificativa.present) {
      map['justificativa'] = Variable<String>(justificativa.value);
    }
    if (justificativaFotoPath.present) {
      map['justificativa_foto_path'] =
          Variable<String>(justificativaFotoPath.value);
    }
    if (fotoPath.present) {
      map['foto_path'] = Variable<String>(fotoPath.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ItensContagemCompanion(')
          ..write('id: $id, ')
          ..write('sessaoId: $sessaoId, ')
          ..write('materialCodigo: $materialCodigo, ')
          ..write('estoqueAnterior: $estoqueAnterior, ')
          ..write('estoqueContado: $estoqueContado, ')
          ..write('linhaEstoque: $linhaEstoque, ')
          ..write('containersJson: $containersJson, ')
          ..write('cubaEstoque: $cubaEstoque, ')
          ..write('outrosEstoque: $outrosEstoque, ')
          ..write('recebimentoTotal: $recebimentoTotal, ')
          ..write('observacao: $observacao, ')
          ..write('justificativa: $justificativa, ')
          ..write('justificativaFotoPath: $justificativaFotoPath, ')
          ..write('fotoPath: $fotoPath, ')
          ..write('status: $status, ')
          ..write('timestamp: $timestamp, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $NotasRecebimentoTable extends NotasRecebimento
    with TableInfo<$NotasRecebimentoTable, NotaRecebimentoRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NotasRecebimentoTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _itemIdMeta = const VerificationMeta('itemId');
  @override
  late final GeneratedColumn<String> itemId = GeneratedColumn<String>(
      'item_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _numeroMeta = const VerificationMeta('numero');
  @override
  late final GeneratedColumn<String> numero = GeneratedColumn<String>(
      'numero', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _quantidadeMeta =
      const VerificationMeta('quantidade');
  @override
  late final GeneratedColumn<double> quantidade = GeneratedColumn<double>(
      'quantidade', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _dataRecebimentoMeta =
      const VerificationMeta('dataRecebimento');
  @override
  late final GeneratedColumn<DateTime> dataRecebimento =
      GeneratedColumn<DateTime>('data_recebimento', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _fotoPathMeta =
      const VerificationMeta('fotoPath');
  @override
  late final GeneratedColumn<String> fotoPath = GeneratedColumn<String>(
      'foto_path', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, itemId, numero, quantidade, dataRecebimento, fotoPath];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'notas_recebimento';
  @override
  VerificationContext validateIntegrity(Insertable<NotaRecebimentoRow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('item_id')) {
      context.handle(_itemIdMeta,
          itemId.isAcceptableOrUnknown(data['item_id']!, _itemIdMeta));
    } else if (isInserting) {
      context.missing(_itemIdMeta);
    }
    if (data.containsKey('numero')) {
      context.handle(_numeroMeta,
          numero.isAcceptableOrUnknown(data['numero']!, _numeroMeta));
    } else if (isInserting) {
      context.missing(_numeroMeta);
    }
    if (data.containsKey('quantidade')) {
      context.handle(
          _quantidadeMeta,
          quantidade.isAcceptableOrUnknown(
              data['quantidade']!, _quantidadeMeta));
    } else if (isInserting) {
      context.missing(_quantidadeMeta);
    }
    if (data.containsKey('data_recebimento')) {
      context.handle(
          _dataRecebimentoMeta,
          dataRecebimento.isAcceptableOrUnknown(
              data['data_recebimento']!, _dataRecebimentoMeta));
    }
    if (data.containsKey('foto_path')) {
      context.handle(_fotoPathMeta,
          fotoPath.isAcceptableOrUnknown(data['foto_path']!, _fotoPathMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  NotaRecebimentoRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NotaRecebimentoRow(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      itemId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}item_id'])!,
      numero: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}numero'])!,
      quantidade: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}quantidade'])!,
      dataRecebimento: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}data_recebimento']),
      fotoPath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}foto_path']),
    );
  }

  @override
  $NotasRecebimentoTable createAlias(String alias) {
    return $NotasRecebimentoTable(attachedDatabase, alias);
  }
}

class NotaRecebimentoRow extends DataClass
    implements Insertable<NotaRecebimentoRow> {
  final String id;
  final String itemId;
  final String numero;
  final double quantidade;
  final DateTime? dataRecebimento;
  final String? fotoPath;
  const NotaRecebimentoRow(
      {required this.id,
      required this.itemId,
      required this.numero,
      required this.quantidade,
      this.dataRecebimento,
      this.fotoPath});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['item_id'] = Variable<String>(itemId);
    map['numero'] = Variable<String>(numero);
    map['quantidade'] = Variable<double>(quantidade);
    if (!nullToAbsent || dataRecebimento != null) {
      map['data_recebimento'] = Variable<DateTime>(dataRecebimento);
    }
    if (!nullToAbsent || fotoPath != null) {
      map['foto_path'] = Variable<String>(fotoPath);
    }
    return map;
  }

  NotasRecebimentoCompanion toCompanion(bool nullToAbsent) {
    return NotasRecebimentoCompanion(
      id: Value(id),
      itemId: Value(itemId),
      numero: Value(numero),
      quantidade: Value(quantidade),
      dataRecebimento: dataRecebimento == null && nullToAbsent
          ? const Value.absent()
          : Value(dataRecebimento),
      fotoPath: fotoPath == null && nullToAbsent
          ? const Value.absent()
          : Value(fotoPath),
    );
  }

  factory NotaRecebimentoRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NotaRecebimentoRow(
      id: serializer.fromJson<String>(json['id']),
      itemId: serializer.fromJson<String>(json['itemId']),
      numero: serializer.fromJson<String>(json['numero']),
      quantidade: serializer.fromJson<double>(json['quantidade']),
      dataRecebimento: serializer.fromJson<DateTime?>(json['dataRecebimento']),
      fotoPath: serializer.fromJson<String?>(json['fotoPath']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'itemId': serializer.toJson<String>(itemId),
      'numero': serializer.toJson<String>(numero),
      'quantidade': serializer.toJson<double>(quantidade),
      'dataRecebimento': serializer.toJson<DateTime?>(dataRecebimento),
      'fotoPath': serializer.toJson<String?>(fotoPath),
    };
  }

  NotaRecebimentoRow copyWith(
          {String? id,
          String? itemId,
          String? numero,
          double? quantidade,
          Value<DateTime?> dataRecebimento = const Value.absent(),
          Value<String?> fotoPath = const Value.absent()}) =>
      NotaRecebimentoRow(
        id: id ?? this.id,
        itemId: itemId ?? this.itemId,
        numero: numero ?? this.numero,
        quantidade: quantidade ?? this.quantidade,
        dataRecebimento: dataRecebimento.present
            ? dataRecebimento.value
            : this.dataRecebimento,
        fotoPath: fotoPath.present ? fotoPath.value : this.fotoPath,
      );
  NotaRecebimentoRow copyWithCompanion(NotasRecebimentoCompanion data) {
    return NotaRecebimentoRow(
      id: data.id.present ? data.id.value : this.id,
      itemId: data.itemId.present ? data.itemId.value : this.itemId,
      numero: data.numero.present ? data.numero.value : this.numero,
      quantidade:
          data.quantidade.present ? data.quantidade.value : this.quantidade,
      dataRecebimento: data.dataRecebimento.present
          ? data.dataRecebimento.value
          : this.dataRecebimento,
      fotoPath: data.fotoPath.present ? data.fotoPath.value : this.fotoPath,
    );
  }

  @override
  String toString() {
    return (StringBuffer('NotaRecebimentoRow(')
          ..write('id: $id, ')
          ..write('itemId: $itemId, ')
          ..write('numero: $numero, ')
          ..write('quantidade: $quantidade, ')
          ..write('dataRecebimento: $dataRecebimento, ')
          ..write('fotoPath: $fotoPath')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, itemId, numero, quantidade, dataRecebimento, fotoPath);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NotaRecebimentoRow &&
          other.id == this.id &&
          other.itemId == this.itemId &&
          other.numero == this.numero &&
          other.quantidade == this.quantidade &&
          other.dataRecebimento == this.dataRecebimento &&
          other.fotoPath == this.fotoPath);
}

class NotasRecebimentoCompanion extends UpdateCompanion<NotaRecebimentoRow> {
  final Value<String> id;
  final Value<String> itemId;
  final Value<String> numero;
  final Value<double> quantidade;
  final Value<DateTime?> dataRecebimento;
  final Value<String?> fotoPath;
  final Value<int> rowid;
  const NotasRecebimentoCompanion({
    this.id = const Value.absent(),
    this.itemId = const Value.absent(),
    this.numero = const Value.absent(),
    this.quantidade = const Value.absent(),
    this.dataRecebimento = const Value.absent(),
    this.fotoPath = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  NotasRecebimentoCompanion.insert({
    required String id,
    required String itemId,
    required String numero,
    required double quantidade,
    this.dataRecebimento = const Value.absent(),
    this.fotoPath = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        itemId = Value(itemId),
        numero = Value(numero),
        quantidade = Value(quantidade);
  static Insertable<NotaRecebimentoRow> custom({
    Expression<String>? id,
    Expression<String>? itemId,
    Expression<String>? numero,
    Expression<double>? quantidade,
    Expression<DateTime>? dataRecebimento,
    Expression<String>? fotoPath,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (itemId != null) 'item_id': itemId,
      if (numero != null) 'numero': numero,
      if (quantidade != null) 'quantidade': quantidade,
      if (dataRecebimento != null) 'data_recebimento': dataRecebimento,
      if (fotoPath != null) 'foto_path': fotoPath,
      if (rowid != null) 'rowid': rowid,
    });
  }

  NotasRecebimentoCompanion copyWith(
      {Value<String>? id,
      Value<String>? itemId,
      Value<String>? numero,
      Value<double>? quantidade,
      Value<DateTime?>? dataRecebimento,
      Value<String?>? fotoPath,
      Value<int>? rowid}) {
    return NotasRecebimentoCompanion(
      id: id ?? this.id,
      itemId: itemId ?? this.itemId,
      numero: numero ?? this.numero,
      quantidade: quantidade ?? this.quantidade,
      dataRecebimento: dataRecebimento ?? this.dataRecebimento,
      fotoPath: fotoPath ?? this.fotoPath,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (itemId.present) {
      map['item_id'] = Variable<String>(itemId.value);
    }
    if (numero.present) {
      map['numero'] = Variable<String>(numero.value);
    }
    if (quantidade.present) {
      map['quantidade'] = Variable<double>(quantidade.value);
    }
    if (dataRecebimento.present) {
      map['data_recebimento'] = Variable<DateTime>(dataRecebimento.value);
    }
    if (fotoPath.present) {
      map['foto_path'] = Variable<String>(fotoPath.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NotasRecebimentoCompanion(')
          ..write('id: $id, ')
          ..write('itemId: $itemId, ')
          ..write('numero: $numero, ')
          ..write('quantidade: $quantidade, ')
          ..write('dataRecebimento: $dataRecebimento, ')
          ..write('fotoPath: $fotoPath, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ExportsTable extends Exports with TableInfo<$ExportsTable, ExportRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExportsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _sessaoIdMeta =
      const VerificationMeta('sessaoId');
  @override
  late final GeneratedColumn<String> sessaoId = GeneratedColumn<String>(
      'sessao_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _caminhoExcelMeta =
      const VerificationMeta('caminhoExcel');
  @override
  late final GeneratedColumn<String> caminhoExcel = GeneratedColumn<String>(
      'caminho_excel', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _caminhoPdfMeta =
      const VerificationMeta('caminhoPdf');
  @override
  late final GeneratedColumn<String> caminhoPdf = GeneratedColumn<String>(
      'caminho_pdf', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _timestampMeta =
      const VerificationMeta('timestamp');
  @override
  late final GeneratedColumn<DateTime> timestamp = GeneratedColumn<DateTime>(
      'timestamp', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, sessaoId, caminhoExcel, caminhoPdf, timestamp];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'exports';
  @override
  VerificationContext validateIntegrity(Insertable<ExportRow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('sessao_id')) {
      context.handle(_sessaoIdMeta,
          sessaoId.isAcceptableOrUnknown(data['sessao_id']!, _sessaoIdMeta));
    } else if (isInserting) {
      context.missing(_sessaoIdMeta);
    }
    if (data.containsKey('caminho_excel')) {
      context.handle(
          _caminhoExcelMeta,
          caminhoExcel.isAcceptableOrUnknown(
              data['caminho_excel']!, _caminhoExcelMeta));
    }
    if (data.containsKey('caminho_pdf')) {
      context.handle(
          _caminhoPdfMeta,
          caminhoPdf.isAcceptableOrUnknown(
              data['caminho_pdf']!, _caminhoPdfMeta));
    }
    if (data.containsKey('timestamp')) {
      context.handle(_timestampMeta,
          timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta));
    } else if (isInserting) {
      context.missing(_timestampMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ExportRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExportRow(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      sessaoId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sessao_id'])!,
      caminhoExcel: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}caminho_excel']),
      caminhoPdf: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}caminho_pdf']),
      timestamp: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}timestamp'])!,
    );
  }

  @override
  $ExportsTable createAlias(String alias) {
    return $ExportsTable(attachedDatabase, alias);
  }
}

class ExportRow extends DataClass implements Insertable<ExportRow> {
  final String id;
  final String sessaoId;
  final String? caminhoExcel;
  final String? caminhoPdf;
  final DateTime timestamp;
  const ExportRow(
      {required this.id,
      required this.sessaoId,
      this.caminhoExcel,
      this.caminhoPdf,
      required this.timestamp});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['sessao_id'] = Variable<String>(sessaoId);
    if (!nullToAbsent || caminhoExcel != null) {
      map['caminho_excel'] = Variable<String>(caminhoExcel);
    }
    if (!nullToAbsent || caminhoPdf != null) {
      map['caminho_pdf'] = Variable<String>(caminhoPdf);
    }
    map['timestamp'] = Variable<DateTime>(timestamp);
    return map;
  }

  ExportsCompanion toCompanion(bool nullToAbsent) {
    return ExportsCompanion(
      id: Value(id),
      sessaoId: Value(sessaoId),
      caminhoExcel: caminhoExcel == null && nullToAbsent
          ? const Value.absent()
          : Value(caminhoExcel),
      caminhoPdf: caminhoPdf == null && nullToAbsent
          ? const Value.absent()
          : Value(caminhoPdf),
      timestamp: Value(timestamp),
    );
  }

  factory ExportRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExportRow(
      id: serializer.fromJson<String>(json['id']),
      sessaoId: serializer.fromJson<String>(json['sessaoId']),
      caminhoExcel: serializer.fromJson<String?>(json['caminhoExcel']),
      caminhoPdf: serializer.fromJson<String?>(json['caminhoPdf']),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'sessaoId': serializer.toJson<String>(sessaoId),
      'caminhoExcel': serializer.toJson<String?>(caminhoExcel),
      'caminhoPdf': serializer.toJson<String?>(caminhoPdf),
      'timestamp': serializer.toJson<DateTime>(timestamp),
    };
  }

  ExportRow copyWith(
          {String? id,
          String? sessaoId,
          Value<String?> caminhoExcel = const Value.absent(),
          Value<String?> caminhoPdf = const Value.absent(),
          DateTime? timestamp}) =>
      ExportRow(
        id: id ?? this.id,
        sessaoId: sessaoId ?? this.sessaoId,
        caminhoExcel:
            caminhoExcel.present ? caminhoExcel.value : this.caminhoExcel,
        caminhoPdf: caminhoPdf.present ? caminhoPdf.value : this.caminhoPdf,
        timestamp: timestamp ?? this.timestamp,
      );
  ExportRow copyWithCompanion(ExportsCompanion data) {
    return ExportRow(
      id: data.id.present ? data.id.value : this.id,
      sessaoId: data.sessaoId.present ? data.sessaoId.value : this.sessaoId,
      caminhoExcel: data.caminhoExcel.present
          ? data.caminhoExcel.value
          : this.caminhoExcel,
      caminhoPdf:
          data.caminhoPdf.present ? data.caminhoPdf.value : this.caminhoPdf,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ExportRow(')
          ..write('id: $id, ')
          ..write('sessaoId: $sessaoId, ')
          ..write('caminhoExcel: $caminhoExcel, ')
          ..write('caminhoPdf: $caminhoPdf, ')
          ..write('timestamp: $timestamp')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, sessaoId, caminhoExcel, caminhoPdf, timestamp);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExportRow &&
          other.id == this.id &&
          other.sessaoId == this.sessaoId &&
          other.caminhoExcel == this.caminhoExcel &&
          other.caminhoPdf == this.caminhoPdf &&
          other.timestamp == this.timestamp);
}

class ExportsCompanion extends UpdateCompanion<ExportRow> {
  final Value<String> id;
  final Value<String> sessaoId;
  final Value<String?> caminhoExcel;
  final Value<String?> caminhoPdf;
  final Value<DateTime> timestamp;
  final Value<int> rowid;
  const ExportsCompanion({
    this.id = const Value.absent(),
    this.sessaoId = const Value.absent(),
    this.caminhoExcel = const Value.absent(),
    this.caminhoPdf = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ExportsCompanion.insert({
    required String id,
    required String sessaoId,
    this.caminhoExcel = const Value.absent(),
    this.caminhoPdf = const Value.absent(),
    required DateTime timestamp,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        sessaoId = Value(sessaoId),
        timestamp = Value(timestamp);
  static Insertable<ExportRow> custom({
    Expression<String>? id,
    Expression<String>? sessaoId,
    Expression<String>? caminhoExcel,
    Expression<String>? caminhoPdf,
    Expression<DateTime>? timestamp,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sessaoId != null) 'sessao_id': sessaoId,
      if (caminhoExcel != null) 'caminho_excel': caminhoExcel,
      if (caminhoPdf != null) 'caminho_pdf': caminhoPdf,
      if (timestamp != null) 'timestamp': timestamp,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ExportsCompanion copyWith(
      {Value<String>? id,
      Value<String>? sessaoId,
      Value<String?>? caminhoExcel,
      Value<String?>? caminhoPdf,
      Value<DateTime>? timestamp,
      Value<int>? rowid}) {
    return ExportsCompanion(
      id: id ?? this.id,
      sessaoId: sessaoId ?? this.sessaoId,
      caminhoExcel: caminhoExcel ?? this.caminhoExcel,
      caminhoPdf: caminhoPdf ?? this.caminhoPdf,
      timestamp: timestamp ?? this.timestamp,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (sessaoId.present) {
      map['sessao_id'] = Variable<String>(sessaoId.value);
    }
    if (caminhoExcel.present) {
      map['caminho_excel'] = Variable<String>(caminhoExcel.value);
    }
    if (caminhoPdf.present) {
      map['caminho_pdf'] = Variable<String>(caminhoPdf.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExportsCompanion(')
          ..write('id: $id, ')
          ..write('sessaoId: $sessaoId, ')
          ..write('caminhoExcel: $caminhoExcel, ')
          ..write('caminhoPdf: $caminhoPdf, ')
          ..write('timestamp: $timestamp, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ItensHistoricoTable extends ItensHistorico
    with TableInfo<$ItensHistoricoTable, ItemHistoricoRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ItensHistoricoTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _itemIdMeta = const VerificationMeta('itemId');
  @override
  late final GeneratedColumn<String> itemId = GeneratedColumn<String>(
      'item_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _sessaoIdMeta =
      const VerificationMeta('sessaoId');
  @override
  late final GeneratedColumn<String> sessaoId = GeneratedColumn<String>(
      'sessao_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _materialCodigoMeta =
      const VerificationMeta('materialCodigo');
  @override
  late final GeneratedColumn<String> materialCodigo = GeneratedColumn<String>(
      'material_codigo', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _acaoMeta = const VerificationMeta('acao');
  @override
  late final GeneratedColumn<String> acao = GeneratedColumn<String>(
      'acao', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _operadorNomeMeta =
      const VerificationMeta('operadorNome');
  @override
  late final GeneratedColumn<String> operadorNome = GeneratedColumn<String>(
      'operador_nome', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _estoqueAnteriorMeta =
      const VerificationMeta('estoqueAnterior');
  @override
  late final GeneratedColumn<double> estoqueAnterior = GeneratedColumn<double>(
      'estoque_anterior', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _estoqueContadoMeta =
      const VerificationMeta('estoqueContado');
  @override
  late final GeneratedColumn<double> estoqueContado = GeneratedColumn<double>(
      'estoque_contado', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _recebimentoTotalMeta =
      const VerificationMeta('recebimentoTotal');
  @override
  late final GeneratedColumn<double> recebimentoTotal = GeneratedColumn<double>(
      'recebimento_total', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _observacaoMeta =
      const VerificationMeta('observacao');
  @override
  late final GeneratedColumn<String> observacao = GeneratedColumn<String>(
      'observacao', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _justificativaMeta =
      const VerificationMeta('justificativa');
  @override
  late final GeneratedColumn<String> justificativa = GeneratedColumn<String>(
      'justificativa', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _timestampMeta =
      const VerificationMeta('timestamp');
  @override
  late final GeneratedColumn<DateTime> timestamp = GeneratedColumn<DateTime>(
      'timestamp', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        itemId,
        sessaoId,
        materialCodigo,
        acao,
        operadorNome,
        estoqueAnterior,
        estoqueContado,
        recebimentoTotal,
        status,
        observacao,
        justificativa,
        timestamp
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'itens_historico';
  @override
  VerificationContext validateIntegrity(Insertable<ItemHistoricoRow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('item_id')) {
      context.handle(_itemIdMeta,
          itemId.isAcceptableOrUnknown(data['item_id']!, _itemIdMeta));
    } else if (isInserting) {
      context.missing(_itemIdMeta);
    }
    if (data.containsKey('sessao_id')) {
      context.handle(_sessaoIdMeta,
          sessaoId.isAcceptableOrUnknown(data['sessao_id']!, _sessaoIdMeta));
    } else if (isInserting) {
      context.missing(_sessaoIdMeta);
    }
    if (data.containsKey('material_codigo')) {
      context.handle(
          _materialCodigoMeta,
          materialCodigo.isAcceptableOrUnknown(
              data['material_codigo']!, _materialCodigoMeta));
    } else if (isInserting) {
      context.missing(_materialCodigoMeta);
    }
    if (data.containsKey('acao')) {
      context.handle(
          _acaoMeta, acao.isAcceptableOrUnknown(data['acao']!, _acaoMeta));
    } else if (isInserting) {
      context.missing(_acaoMeta);
    }
    if (data.containsKey('operador_nome')) {
      context.handle(
          _operadorNomeMeta,
          operadorNome.isAcceptableOrUnknown(
              data['operador_nome']!, _operadorNomeMeta));
    } else if (isInserting) {
      context.missing(_operadorNomeMeta);
    }
    if (data.containsKey('estoque_anterior')) {
      context.handle(
          _estoqueAnteriorMeta,
          estoqueAnterior.isAcceptableOrUnknown(
              data['estoque_anterior']!, _estoqueAnteriorMeta));
    }
    if (data.containsKey('estoque_contado')) {
      context.handle(
          _estoqueContadoMeta,
          estoqueContado.isAcceptableOrUnknown(
              data['estoque_contado']!, _estoqueContadoMeta));
    }
    if (data.containsKey('recebimento_total')) {
      context.handle(
          _recebimentoTotalMeta,
          recebimentoTotal.isAcceptableOrUnknown(
              data['recebimento_total']!, _recebimentoTotalMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('observacao')) {
      context.handle(
          _observacaoMeta,
          observacao.isAcceptableOrUnknown(
              data['observacao']!, _observacaoMeta));
    }
    if (data.containsKey('justificativa')) {
      context.handle(
          _justificativaMeta,
          justificativa.isAcceptableOrUnknown(
              data['justificativa']!, _justificativaMeta));
    }
    if (data.containsKey('timestamp')) {
      context.handle(_timestampMeta,
          timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta));
    } else if (isInserting) {
      context.missing(_timestampMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ItemHistoricoRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ItemHistoricoRow(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      itemId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}item_id'])!,
      sessaoId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sessao_id'])!,
      materialCodigo: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}material_codigo'])!,
      acao: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}acao'])!,
      operadorNome: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}operador_nome'])!,
      estoqueAnterior: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}estoque_anterior']),
      estoqueContado: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}estoque_contado']),
      recebimentoTotal: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}recebimento_total']),
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status']),
      observacao: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}observacao']),
      justificativa: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}justificativa']),
      timestamp: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}timestamp'])!,
    );
  }

  @override
  $ItensHistoricoTable createAlias(String alias) {
    return $ItensHistoricoTable(attachedDatabase, alias);
  }
}

class ItemHistoricoRow extends DataClass
    implements Insertable<ItemHistoricoRow> {
  final String id;
  final String itemId;
  final String sessaoId;
  final String materialCodigo;
  final String acao;
  final String operadorNome;
  final double? estoqueAnterior;
  final double? estoqueContado;
  final double? recebimentoTotal;
  final String? status;
  final String? observacao;
  final String? justificativa;
  final DateTime timestamp;
  const ItemHistoricoRow(
      {required this.id,
      required this.itemId,
      required this.sessaoId,
      required this.materialCodigo,
      required this.acao,
      required this.operadorNome,
      this.estoqueAnterior,
      this.estoqueContado,
      this.recebimentoTotal,
      this.status,
      this.observacao,
      this.justificativa,
      required this.timestamp});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['item_id'] = Variable<String>(itemId);
    map['sessao_id'] = Variable<String>(sessaoId);
    map['material_codigo'] = Variable<String>(materialCodigo);
    map['acao'] = Variable<String>(acao);
    map['operador_nome'] = Variable<String>(operadorNome);
    if (!nullToAbsent || estoqueAnterior != null) {
      map['estoque_anterior'] = Variable<double>(estoqueAnterior);
    }
    if (!nullToAbsent || estoqueContado != null) {
      map['estoque_contado'] = Variable<double>(estoqueContado);
    }
    if (!nullToAbsent || recebimentoTotal != null) {
      map['recebimento_total'] = Variable<double>(recebimentoTotal);
    }
    if (!nullToAbsent || status != null) {
      map['status'] = Variable<String>(status);
    }
    if (!nullToAbsent || observacao != null) {
      map['observacao'] = Variable<String>(observacao);
    }
    if (!nullToAbsent || justificativa != null) {
      map['justificativa'] = Variable<String>(justificativa);
    }
    map['timestamp'] = Variable<DateTime>(timestamp);
    return map;
  }

  ItensHistoricoCompanion toCompanion(bool nullToAbsent) {
    return ItensHistoricoCompanion(
      id: Value(id),
      itemId: Value(itemId),
      sessaoId: Value(sessaoId),
      materialCodigo: Value(materialCodigo),
      acao: Value(acao),
      operadorNome: Value(operadorNome),
      estoqueAnterior: estoqueAnterior == null && nullToAbsent
          ? const Value.absent()
          : Value(estoqueAnterior),
      estoqueContado: estoqueContado == null && nullToAbsent
          ? const Value.absent()
          : Value(estoqueContado),
      recebimentoTotal: recebimentoTotal == null && nullToAbsent
          ? const Value.absent()
          : Value(recebimentoTotal),
      status:
          status == null && nullToAbsent ? const Value.absent() : Value(status),
      observacao: observacao == null && nullToAbsent
          ? const Value.absent()
          : Value(observacao),
      justificativa: justificativa == null && nullToAbsent
          ? const Value.absent()
          : Value(justificativa),
      timestamp: Value(timestamp),
    );
  }

  factory ItemHistoricoRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ItemHistoricoRow(
      id: serializer.fromJson<String>(json['id']),
      itemId: serializer.fromJson<String>(json['itemId']),
      sessaoId: serializer.fromJson<String>(json['sessaoId']),
      materialCodigo: serializer.fromJson<String>(json['materialCodigo']),
      acao: serializer.fromJson<String>(json['acao']),
      operadorNome: serializer.fromJson<String>(json['operadorNome']),
      estoqueAnterior: serializer.fromJson<double?>(json['estoqueAnterior']),
      estoqueContado: serializer.fromJson<double?>(json['estoqueContado']),
      recebimentoTotal: serializer.fromJson<double?>(json['recebimentoTotal']),
      status: serializer.fromJson<String?>(json['status']),
      observacao: serializer.fromJson<String?>(json['observacao']),
      justificativa: serializer.fromJson<String?>(json['justificativa']),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'itemId': serializer.toJson<String>(itemId),
      'sessaoId': serializer.toJson<String>(sessaoId),
      'materialCodigo': serializer.toJson<String>(materialCodigo),
      'acao': serializer.toJson<String>(acao),
      'operadorNome': serializer.toJson<String>(operadorNome),
      'estoqueAnterior': serializer.toJson<double?>(estoqueAnterior),
      'estoqueContado': serializer.toJson<double?>(estoqueContado),
      'recebimentoTotal': serializer.toJson<double?>(recebimentoTotal),
      'status': serializer.toJson<String?>(status),
      'observacao': serializer.toJson<String?>(observacao),
      'justificativa': serializer.toJson<String?>(justificativa),
      'timestamp': serializer.toJson<DateTime>(timestamp),
    };
  }

  ItemHistoricoRow copyWith(
          {String? id,
          String? itemId,
          String? sessaoId,
          String? materialCodigo,
          String? acao,
          String? operadorNome,
          Value<double?> estoqueAnterior = const Value.absent(),
          Value<double?> estoqueContado = const Value.absent(),
          Value<double?> recebimentoTotal = const Value.absent(),
          Value<String?> status = const Value.absent(),
          Value<String?> observacao = const Value.absent(),
          Value<String?> justificativa = const Value.absent(),
          DateTime? timestamp}) =>
      ItemHistoricoRow(
        id: id ?? this.id,
        itemId: itemId ?? this.itemId,
        sessaoId: sessaoId ?? this.sessaoId,
        materialCodigo: materialCodigo ?? this.materialCodigo,
        acao: acao ?? this.acao,
        operadorNome: operadorNome ?? this.operadorNome,
        estoqueAnterior: estoqueAnterior.present
            ? estoqueAnterior.value
            : this.estoqueAnterior,
        estoqueContado:
            estoqueContado.present ? estoqueContado.value : this.estoqueContado,
        recebimentoTotal: recebimentoTotal.present
            ? recebimentoTotal.value
            : this.recebimentoTotal,
        status: status.present ? status.value : this.status,
        observacao: observacao.present ? observacao.value : this.observacao,
        justificativa:
            justificativa.present ? justificativa.value : this.justificativa,
        timestamp: timestamp ?? this.timestamp,
      );
  ItemHistoricoRow copyWithCompanion(ItensHistoricoCompanion data) {
    return ItemHistoricoRow(
      id: data.id.present ? data.id.value : this.id,
      itemId: data.itemId.present ? data.itemId.value : this.itemId,
      sessaoId: data.sessaoId.present ? data.sessaoId.value : this.sessaoId,
      materialCodigo: data.materialCodigo.present
          ? data.materialCodigo.value
          : this.materialCodigo,
      acao: data.acao.present ? data.acao.value : this.acao,
      operadorNome: data.operadorNome.present
          ? data.operadorNome.value
          : this.operadorNome,
      estoqueAnterior: data.estoqueAnterior.present
          ? data.estoqueAnterior.value
          : this.estoqueAnterior,
      estoqueContado: data.estoqueContado.present
          ? data.estoqueContado.value
          : this.estoqueContado,
      recebimentoTotal: data.recebimentoTotal.present
          ? data.recebimentoTotal.value
          : this.recebimentoTotal,
      status: data.status.present ? data.status.value : this.status,
      observacao:
          data.observacao.present ? data.observacao.value : this.observacao,
      justificativa: data.justificativa.present
          ? data.justificativa.value
          : this.justificativa,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ItemHistoricoRow(')
          ..write('id: $id, ')
          ..write('itemId: $itemId, ')
          ..write('sessaoId: $sessaoId, ')
          ..write('materialCodigo: $materialCodigo, ')
          ..write('acao: $acao, ')
          ..write('operadorNome: $operadorNome, ')
          ..write('estoqueAnterior: $estoqueAnterior, ')
          ..write('estoqueContado: $estoqueContado, ')
          ..write('recebimentoTotal: $recebimentoTotal, ')
          ..write('status: $status, ')
          ..write('observacao: $observacao, ')
          ..write('justificativa: $justificativa, ')
          ..write('timestamp: $timestamp')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      itemId,
      sessaoId,
      materialCodigo,
      acao,
      operadorNome,
      estoqueAnterior,
      estoqueContado,
      recebimentoTotal,
      status,
      observacao,
      justificativa,
      timestamp);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ItemHistoricoRow &&
          other.id == this.id &&
          other.itemId == this.itemId &&
          other.sessaoId == this.sessaoId &&
          other.materialCodigo == this.materialCodigo &&
          other.acao == this.acao &&
          other.operadorNome == this.operadorNome &&
          other.estoqueAnterior == this.estoqueAnterior &&
          other.estoqueContado == this.estoqueContado &&
          other.recebimentoTotal == this.recebimentoTotal &&
          other.status == this.status &&
          other.observacao == this.observacao &&
          other.justificativa == this.justificativa &&
          other.timestamp == this.timestamp);
}

class ItensHistoricoCompanion extends UpdateCompanion<ItemHistoricoRow> {
  final Value<String> id;
  final Value<String> itemId;
  final Value<String> sessaoId;
  final Value<String> materialCodigo;
  final Value<String> acao;
  final Value<String> operadorNome;
  final Value<double?> estoqueAnterior;
  final Value<double?> estoqueContado;
  final Value<double?> recebimentoTotal;
  final Value<String?> status;
  final Value<String?> observacao;
  final Value<String?> justificativa;
  final Value<DateTime> timestamp;
  final Value<int> rowid;
  const ItensHistoricoCompanion({
    this.id = const Value.absent(),
    this.itemId = const Value.absent(),
    this.sessaoId = const Value.absent(),
    this.materialCodigo = const Value.absent(),
    this.acao = const Value.absent(),
    this.operadorNome = const Value.absent(),
    this.estoqueAnterior = const Value.absent(),
    this.estoqueContado = const Value.absent(),
    this.recebimentoTotal = const Value.absent(),
    this.status = const Value.absent(),
    this.observacao = const Value.absent(),
    this.justificativa = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ItensHistoricoCompanion.insert({
    required String id,
    required String itemId,
    required String sessaoId,
    required String materialCodigo,
    required String acao,
    required String operadorNome,
    this.estoqueAnterior = const Value.absent(),
    this.estoqueContado = const Value.absent(),
    this.recebimentoTotal = const Value.absent(),
    this.status = const Value.absent(),
    this.observacao = const Value.absent(),
    this.justificativa = const Value.absent(),
    required DateTime timestamp,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        itemId = Value(itemId),
        sessaoId = Value(sessaoId),
        materialCodigo = Value(materialCodigo),
        acao = Value(acao),
        operadorNome = Value(operadorNome),
        timestamp = Value(timestamp);
  static Insertable<ItemHistoricoRow> custom({
    Expression<String>? id,
    Expression<String>? itemId,
    Expression<String>? sessaoId,
    Expression<String>? materialCodigo,
    Expression<String>? acao,
    Expression<String>? operadorNome,
    Expression<double>? estoqueAnterior,
    Expression<double>? estoqueContado,
    Expression<double>? recebimentoTotal,
    Expression<String>? status,
    Expression<String>? observacao,
    Expression<String>? justificativa,
    Expression<DateTime>? timestamp,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (itemId != null) 'item_id': itemId,
      if (sessaoId != null) 'sessao_id': sessaoId,
      if (materialCodigo != null) 'material_codigo': materialCodigo,
      if (acao != null) 'acao': acao,
      if (operadorNome != null) 'operador_nome': operadorNome,
      if (estoqueAnterior != null) 'estoque_anterior': estoqueAnterior,
      if (estoqueContado != null) 'estoque_contado': estoqueContado,
      if (recebimentoTotal != null) 'recebimento_total': recebimentoTotal,
      if (status != null) 'status': status,
      if (observacao != null) 'observacao': observacao,
      if (justificativa != null) 'justificativa': justificativa,
      if (timestamp != null) 'timestamp': timestamp,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ItensHistoricoCompanion copyWith(
      {Value<String>? id,
      Value<String>? itemId,
      Value<String>? sessaoId,
      Value<String>? materialCodigo,
      Value<String>? acao,
      Value<String>? operadorNome,
      Value<double?>? estoqueAnterior,
      Value<double?>? estoqueContado,
      Value<double?>? recebimentoTotal,
      Value<String?>? status,
      Value<String?>? observacao,
      Value<String?>? justificativa,
      Value<DateTime>? timestamp,
      Value<int>? rowid}) {
    return ItensHistoricoCompanion(
      id: id ?? this.id,
      itemId: itemId ?? this.itemId,
      sessaoId: sessaoId ?? this.sessaoId,
      materialCodigo: materialCodigo ?? this.materialCodigo,
      acao: acao ?? this.acao,
      operadorNome: operadorNome ?? this.operadorNome,
      estoqueAnterior: estoqueAnterior ?? this.estoqueAnterior,
      estoqueContado: estoqueContado ?? this.estoqueContado,
      recebimentoTotal: recebimentoTotal ?? this.recebimentoTotal,
      status: status ?? this.status,
      observacao: observacao ?? this.observacao,
      justificativa: justificativa ?? this.justificativa,
      timestamp: timestamp ?? this.timestamp,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (itemId.present) {
      map['item_id'] = Variable<String>(itemId.value);
    }
    if (sessaoId.present) {
      map['sessao_id'] = Variable<String>(sessaoId.value);
    }
    if (materialCodigo.present) {
      map['material_codigo'] = Variable<String>(materialCodigo.value);
    }
    if (acao.present) {
      map['acao'] = Variable<String>(acao.value);
    }
    if (operadorNome.present) {
      map['operador_nome'] = Variable<String>(operadorNome.value);
    }
    if (estoqueAnterior.present) {
      map['estoque_anterior'] = Variable<double>(estoqueAnterior.value);
    }
    if (estoqueContado.present) {
      map['estoque_contado'] = Variable<double>(estoqueContado.value);
    }
    if (recebimentoTotal.present) {
      map['recebimento_total'] = Variable<double>(recebimentoTotal.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (observacao.present) {
      map['observacao'] = Variable<String>(observacao.value);
    }
    if (justificativa.present) {
      map['justificativa'] = Variable<String>(justificativa.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ItensHistoricoCompanion(')
          ..write('id: $id, ')
          ..write('itemId: $itemId, ')
          ..write('sessaoId: $sessaoId, ')
          ..write('materialCodigo: $materialCodigo, ')
          ..write('acao: $acao, ')
          ..write('operadorNome: $operadorNome, ')
          ..write('estoqueAnterior: $estoqueAnterior, ')
          ..write('estoqueContado: $estoqueContado, ')
          ..write('recebimentoTotal: $recebimentoTotal, ')
          ..write('status: $status, ')
          ..write('observacao: $observacao, ')
          ..write('justificativa: $justificativa, ')
          ..write('timestamp: $timestamp, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ParametrosTable extends Parametros
    with TableInfo<$ParametrosTable, ParametrosRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ParametrosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _toleranciaPctMeta =
      const VerificationMeta('toleranciaPct');
  @override
  late final GeneratedColumn<double> toleranciaPct = GeneratedColumn<double>(
      'tolerancia_pct', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.02));
  static const VerificationMeta _toleranciaMinKgMeta =
      const VerificationMeta('toleranciaMinKg');
  @override
  late final GeneratedColumn<double> toleranciaMinKg = GeneratedColumn<double>(
      'tolerancia_min_kg', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(1.0));
  static const VerificationMeta _alertaJanelaMeta =
      const VerificationMeta('alertaJanela');
  @override
  late final GeneratedColumn<String> alertaJanela = GeneratedColumn<String>(
      'alerta_janela', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('diaria'));
  static const VerificationMeta _pinAdminHashMeta =
      const VerificationMeta('pinAdminHash');
  @override
  late final GeneratedColumn<String> pinAdminHash = GeneratedColumn<String>(
      'pin_admin_hash', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, toleranciaPct, toleranciaMinKg, alertaJanela, pinAdminHash];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'parametros';
  @override
  VerificationContext validateIntegrity(Insertable<ParametrosRow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('tolerancia_pct')) {
      context.handle(
          _toleranciaPctMeta,
          toleranciaPct.isAcceptableOrUnknown(
              data['tolerancia_pct']!, _toleranciaPctMeta));
    }
    if (data.containsKey('tolerancia_min_kg')) {
      context.handle(
          _toleranciaMinKgMeta,
          toleranciaMinKg.isAcceptableOrUnknown(
              data['tolerancia_min_kg']!, _toleranciaMinKgMeta));
    }
    if (data.containsKey('alerta_janela')) {
      context.handle(
          _alertaJanelaMeta,
          alertaJanela.isAcceptableOrUnknown(
              data['alerta_janela']!, _alertaJanelaMeta));
    }
    if (data.containsKey('pin_admin_hash')) {
      context.handle(
          _pinAdminHashMeta,
          pinAdminHash.isAcceptableOrUnknown(
              data['pin_admin_hash']!, _pinAdminHashMeta));
    } else if (isInserting) {
      context.missing(_pinAdminHashMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ParametrosRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ParametrosRow(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      toleranciaPct: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}tolerancia_pct'])!,
      toleranciaMinKg: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}tolerancia_min_kg'])!,
      alertaJanela: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}alerta_janela'])!,
      pinAdminHash: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}pin_admin_hash'])!,
    );
  }

  @override
  $ParametrosTable createAlias(String alias) {
    return $ParametrosTable(attachedDatabase, alias);
  }
}

class ParametrosRow extends DataClass implements Insertable<ParametrosRow> {
  final int id;
  final double toleranciaPct;
  final double toleranciaMinKg;
  final String alertaJanela;
  final String pinAdminHash;
  const ParametrosRow(
      {required this.id,
      required this.toleranciaPct,
      required this.toleranciaMinKg,
      required this.alertaJanela,
      required this.pinAdminHash});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['tolerancia_pct'] = Variable<double>(toleranciaPct);
    map['tolerancia_min_kg'] = Variable<double>(toleranciaMinKg);
    map['alerta_janela'] = Variable<String>(alertaJanela);
    map['pin_admin_hash'] = Variable<String>(pinAdminHash);
    return map;
  }

  ParametrosCompanion toCompanion(bool nullToAbsent) {
    return ParametrosCompanion(
      id: Value(id),
      toleranciaPct: Value(toleranciaPct),
      toleranciaMinKg: Value(toleranciaMinKg),
      alertaJanela: Value(alertaJanela),
      pinAdminHash: Value(pinAdminHash),
    );
  }

  factory ParametrosRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ParametrosRow(
      id: serializer.fromJson<int>(json['id']),
      toleranciaPct: serializer.fromJson<double>(json['toleranciaPct']),
      toleranciaMinKg: serializer.fromJson<double>(json['toleranciaMinKg']),
      alertaJanela: serializer.fromJson<String>(json['alertaJanela']),
      pinAdminHash: serializer.fromJson<String>(json['pinAdminHash']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'toleranciaPct': serializer.toJson<double>(toleranciaPct),
      'toleranciaMinKg': serializer.toJson<double>(toleranciaMinKg),
      'alertaJanela': serializer.toJson<String>(alertaJanela),
      'pinAdminHash': serializer.toJson<String>(pinAdminHash),
    };
  }

  ParametrosRow copyWith(
          {int? id,
          double? toleranciaPct,
          double? toleranciaMinKg,
          String? alertaJanela,
          String? pinAdminHash}) =>
      ParametrosRow(
        id: id ?? this.id,
        toleranciaPct: toleranciaPct ?? this.toleranciaPct,
        toleranciaMinKg: toleranciaMinKg ?? this.toleranciaMinKg,
        alertaJanela: alertaJanela ?? this.alertaJanela,
        pinAdminHash: pinAdminHash ?? this.pinAdminHash,
      );
  ParametrosRow copyWithCompanion(ParametrosCompanion data) {
    return ParametrosRow(
      id: data.id.present ? data.id.value : this.id,
      toleranciaPct: data.toleranciaPct.present
          ? data.toleranciaPct.value
          : this.toleranciaPct,
      toleranciaMinKg: data.toleranciaMinKg.present
          ? data.toleranciaMinKg.value
          : this.toleranciaMinKg,
      alertaJanela: data.alertaJanela.present
          ? data.alertaJanela.value
          : this.alertaJanela,
      pinAdminHash: data.pinAdminHash.present
          ? data.pinAdminHash.value
          : this.pinAdminHash,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ParametrosRow(')
          ..write('id: $id, ')
          ..write('toleranciaPct: $toleranciaPct, ')
          ..write('toleranciaMinKg: $toleranciaMinKg, ')
          ..write('alertaJanela: $alertaJanela, ')
          ..write('pinAdminHash: $pinAdminHash')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, toleranciaPct, toleranciaMinKg, alertaJanela, pinAdminHash);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ParametrosRow &&
          other.id == this.id &&
          other.toleranciaPct == this.toleranciaPct &&
          other.toleranciaMinKg == this.toleranciaMinKg &&
          other.alertaJanela == this.alertaJanela &&
          other.pinAdminHash == this.pinAdminHash);
}

class ParametrosCompanion extends UpdateCompanion<ParametrosRow> {
  final Value<int> id;
  final Value<double> toleranciaPct;
  final Value<double> toleranciaMinKg;
  final Value<String> alertaJanela;
  final Value<String> pinAdminHash;
  const ParametrosCompanion({
    this.id = const Value.absent(),
    this.toleranciaPct = const Value.absent(),
    this.toleranciaMinKg = const Value.absent(),
    this.alertaJanela = const Value.absent(),
    this.pinAdminHash = const Value.absent(),
  });
  ParametrosCompanion.insert({
    this.id = const Value.absent(),
    this.toleranciaPct = const Value.absent(),
    this.toleranciaMinKg = const Value.absent(),
    this.alertaJanela = const Value.absent(),
    required String pinAdminHash,
  }) : pinAdminHash = Value(pinAdminHash);
  static Insertable<ParametrosRow> custom({
    Expression<int>? id,
    Expression<double>? toleranciaPct,
    Expression<double>? toleranciaMinKg,
    Expression<String>? alertaJanela,
    Expression<String>? pinAdminHash,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (toleranciaPct != null) 'tolerancia_pct': toleranciaPct,
      if (toleranciaMinKg != null) 'tolerancia_min_kg': toleranciaMinKg,
      if (alertaJanela != null) 'alerta_janela': alertaJanela,
      if (pinAdminHash != null) 'pin_admin_hash': pinAdminHash,
    });
  }

  ParametrosCompanion copyWith(
      {Value<int>? id,
      Value<double>? toleranciaPct,
      Value<double>? toleranciaMinKg,
      Value<String>? alertaJanela,
      Value<String>? pinAdminHash}) {
    return ParametrosCompanion(
      id: id ?? this.id,
      toleranciaPct: toleranciaPct ?? this.toleranciaPct,
      toleranciaMinKg: toleranciaMinKg ?? this.toleranciaMinKg,
      alertaJanela: alertaJanela ?? this.alertaJanela,
      pinAdminHash: pinAdminHash ?? this.pinAdminHash,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (toleranciaPct.present) {
      map['tolerancia_pct'] = Variable<double>(toleranciaPct.value);
    }
    if (toleranciaMinKg.present) {
      map['tolerancia_min_kg'] = Variable<double>(toleranciaMinKg.value);
    }
    if (alertaJanela.present) {
      map['alerta_janela'] = Variable<String>(alertaJanela.value);
    }
    if (pinAdminHash.present) {
      map['pin_admin_hash'] = Variable<String>(pinAdminHash.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ParametrosCompanion(')
          ..write('id: $id, ')
          ..write('toleranciaPct: $toleranciaPct, ')
          ..write('toleranciaMinKg: $toleranciaMinKg, ')
          ..write('alertaJanela: $alertaJanela, ')
          ..write('pinAdminHash: $pinAdminHash')
          ..write(')'))
        .toString();
  }
}

class $ConsumoEsperadoTable extends ConsumoEsperado
    with TableInfo<$ConsumoEsperadoTable, ConsumoEsperadoRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ConsumoEsperadoTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _materialCodigoMeta =
      const VerificationMeta('materialCodigo');
  @override
  late final GeneratedColumn<String> materialCodigo = GeneratedColumn<String>(
      'material_codigo', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _consumoDiarioKgMeta =
      const VerificationMeta('consumoDiarioKg');
  @override
  late final GeneratedColumn<double> consumoDiarioKg = GeneratedColumn<double>(
      'consumo_diario_kg', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [materialCodigo, consumoDiarioKg];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'consumo_esperado';
  @override
  VerificationContext validateIntegrity(Insertable<ConsumoEsperadoRow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('material_codigo')) {
      context.handle(
          _materialCodigoMeta,
          materialCodigo.isAcceptableOrUnknown(
              data['material_codigo']!, _materialCodigoMeta));
    } else if (isInserting) {
      context.missing(_materialCodigoMeta);
    }
    if (data.containsKey('consumo_diario_kg')) {
      context.handle(
          _consumoDiarioKgMeta,
          consumoDiarioKg.isAcceptableOrUnknown(
              data['consumo_diario_kg']!, _consumoDiarioKgMeta));
    } else if (isInserting) {
      context.missing(_consumoDiarioKgMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {materialCodigo};
  @override
  ConsumoEsperadoRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ConsumoEsperadoRow(
      materialCodigo: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}material_codigo'])!,
      consumoDiarioKg: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}consumo_diario_kg'])!,
    );
  }

  @override
  $ConsumoEsperadoTable createAlias(String alias) {
    return $ConsumoEsperadoTable(attachedDatabase, alias);
  }
}

class ConsumoEsperadoRow extends DataClass
    implements Insertable<ConsumoEsperadoRow> {
  final String materialCodigo;
  final double consumoDiarioKg;
  const ConsumoEsperadoRow(
      {required this.materialCodigo, required this.consumoDiarioKg});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['material_codigo'] = Variable<String>(materialCodigo);
    map['consumo_diario_kg'] = Variable<double>(consumoDiarioKg);
    return map;
  }

  ConsumoEsperadoCompanion toCompanion(bool nullToAbsent) {
    return ConsumoEsperadoCompanion(
      materialCodigo: Value(materialCodigo),
      consumoDiarioKg: Value(consumoDiarioKg),
    );
  }

  factory ConsumoEsperadoRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ConsumoEsperadoRow(
      materialCodigo: serializer.fromJson<String>(json['materialCodigo']),
      consumoDiarioKg: serializer.fromJson<double>(json['consumoDiarioKg']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'materialCodigo': serializer.toJson<String>(materialCodigo),
      'consumoDiarioKg': serializer.toJson<double>(consumoDiarioKg),
    };
  }

  ConsumoEsperadoRow copyWith(
          {String? materialCodigo, double? consumoDiarioKg}) =>
      ConsumoEsperadoRow(
        materialCodigo: materialCodigo ?? this.materialCodigo,
        consumoDiarioKg: consumoDiarioKg ?? this.consumoDiarioKg,
      );
  ConsumoEsperadoRow copyWithCompanion(ConsumoEsperadoCompanion data) {
    return ConsumoEsperadoRow(
      materialCodigo: data.materialCodigo.present
          ? data.materialCodigo.value
          : this.materialCodigo,
      consumoDiarioKg: data.consumoDiarioKg.present
          ? data.consumoDiarioKg.value
          : this.consumoDiarioKg,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ConsumoEsperadoRow(')
          ..write('materialCodigo: $materialCodigo, ')
          ..write('consumoDiarioKg: $consumoDiarioKg')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(materialCodigo, consumoDiarioKg);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ConsumoEsperadoRow &&
          other.materialCodigo == this.materialCodigo &&
          other.consumoDiarioKg == this.consumoDiarioKg);
}

class ConsumoEsperadoCompanion extends UpdateCompanion<ConsumoEsperadoRow> {
  final Value<String> materialCodigo;
  final Value<double> consumoDiarioKg;
  final Value<int> rowid;
  const ConsumoEsperadoCompanion({
    this.materialCodigo = const Value.absent(),
    this.consumoDiarioKg = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ConsumoEsperadoCompanion.insert({
    required String materialCodigo,
    required double consumoDiarioKg,
    this.rowid = const Value.absent(),
  })  : materialCodigo = Value(materialCodigo),
        consumoDiarioKg = Value(consumoDiarioKg);
  static Insertable<ConsumoEsperadoRow> custom({
    Expression<String>? materialCodigo,
    Expression<double>? consumoDiarioKg,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (materialCodigo != null) 'material_codigo': materialCodigo,
      if (consumoDiarioKg != null) 'consumo_diario_kg': consumoDiarioKg,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ConsumoEsperadoCompanion copyWith(
      {Value<String>? materialCodigo,
      Value<double>? consumoDiarioKg,
      Value<int>? rowid}) {
    return ConsumoEsperadoCompanion(
      materialCodigo: materialCodigo ?? this.materialCodigo,
      consumoDiarioKg: consumoDiarioKg ?? this.consumoDiarioKg,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (materialCodigo.present) {
      map['material_codigo'] = Variable<String>(materialCodigo.value);
    }
    if (consumoDiarioKg.present) {
      map['consumo_diario_kg'] = Variable<double>(consumoDiarioKg.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ConsumoEsperadoCompanion(')
          ..write('materialCodigo: $materialCodigo, ')
          ..write('consumoDiarioKg: $consumoDiarioKg, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $MateriaisTable materiais = $MateriaisTable(this);
  late final $FornecedoresTable fornecedores = $FornecedoresTable(this);
  late final $EstoqueReferenciaTable estoqueReferencia =
      $EstoqueReferenciaTable(this);
  late final $SessoesTable sessoes = $SessoesTable(this);
  late final $ItensContagemTable itensContagem = $ItensContagemTable(this);
  late final $NotasRecebimentoTable notasRecebimento =
      $NotasRecebimentoTable(this);
  late final $ExportsTable exports = $ExportsTable(this);
  late final $ItensHistoricoTable itensHistorico = $ItensHistoricoTable(this);
  late final $ParametrosTable parametros = $ParametrosTable(this);
  late final $ConsumoEsperadoTable consumoEsperado =
      $ConsumoEsperadoTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        materiais,
        fornecedores,
        estoqueReferencia,
        sessoes,
        itensContagem,
        notasRecebimento,
        exports,
        itensHistorico,
        parametros,
        consumoEsperado
      ];
}

typedef $$MateriaisTableCreateCompanionBuilder = MateriaisCompanion Function({
  required String codigo,
  required String descricao,
  required String fornecedor,
  required String familia,
  required String unidade,
  Value<int> sobeSap,
  Value<bool> ativo,
  required String nomeStock,
  Value<int> rowid,
});
typedef $$MateriaisTableUpdateCompanionBuilder = MateriaisCompanion Function({
  Value<String> codigo,
  Value<String> descricao,
  Value<String> fornecedor,
  Value<String> familia,
  Value<String> unidade,
  Value<int> sobeSap,
  Value<bool> ativo,
  Value<String> nomeStock,
  Value<int> rowid,
});

class $$MateriaisTableFilterComposer
    extends Composer<_$AppDatabase, $MateriaisTable> {
  $$MateriaisTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get codigo => $composableBuilder(
      column: $table.codigo, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get descricao => $composableBuilder(
      column: $table.descricao, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get fornecedor => $composableBuilder(
      column: $table.fornecedor, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get familia => $composableBuilder(
      column: $table.familia, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get unidade => $composableBuilder(
      column: $table.unidade, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sobeSap => $composableBuilder(
      column: $table.sobeSap, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get ativo => $composableBuilder(
      column: $table.ativo, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nomeStock => $composableBuilder(
      column: $table.nomeStock, builder: (column) => ColumnFilters(column));
}

class $$MateriaisTableOrderingComposer
    extends Composer<_$AppDatabase, $MateriaisTable> {
  $$MateriaisTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get codigo => $composableBuilder(
      column: $table.codigo, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get descricao => $composableBuilder(
      column: $table.descricao, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get fornecedor => $composableBuilder(
      column: $table.fornecedor, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get familia => $composableBuilder(
      column: $table.familia, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get unidade => $composableBuilder(
      column: $table.unidade, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sobeSap => $composableBuilder(
      column: $table.sobeSap, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get ativo => $composableBuilder(
      column: $table.ativo, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nomeStock => $composableBuilder(
      column: $table.nomeStock, builder: (column) => ColumnOrderings(column));
}

class $$MateriaisTableAnnotationComposer
    extends Composer<_$AppDatabase, $MateriaisTable> {
  $$MateriaisTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get codigo =>
      $composableBuilder(column: $table.codigo, builder: (column) => column);

  GeneratedColumn<String> get descricao =>
      $composableBuilder(column: $table.descricao, builder: (column) => column);

  GeneratedColumn<String> get fornecedor => $composableBuilder(
      column: $table.fornecedor, builder: (column) => column);

  GeneratedColumn<String> get familia =>
      $composableBuilder(column: $table.familia, builder: (column) => column);

  GeneratedColumn<String> get unidade =>
      $composableBuilder(column: $table.unidade, builder: (column) => column);

  GeneratedColumn<int> get sobeSap =>
      $composableBuilder(column: $table.sobeSap, builder: (column) => column);

  GeneratedColumn<bool> get ativo =>
      $composableBuilder(column: $table.ativo, builder: (column) => column);

  GeneratedColumn<String> get nomeStock =>
      $composableBuilder(column: $table.nomeStock, builder: (column) => column);
}

class $$MateriaisTableTableManager extends RootTableManager<
    _$AppDatabase,
    $MateriaisTable,
    MaterialCadastro,
    $$MateriaisTableFilterComposer,
    $$MateriaisTableOrderingComposer,
    $$MateriaisTableAnnotationComposer,
    $$MateriaisTableCreateCompanionBuilder,
    $$MateriaisTableUpdateCompanionBuilder,
    (
      MaterialCadastro,
      BaseReferences<_$AppDatabase, $MateriaisTable, MaterialCadastro>
    ),
    MaterialCadastro,
    PrefetchHooks Function()> {
  $$MateriaisTableTableManager(_$AppDatabase db, $MateriaisTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MateriaisTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MateriaisTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MateriaisTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> codigo = const Value.absent(),
            Value<String> descricao = const Value.absent(),
            Value<String> fornecedor = const Value.absent(),
            Value<String> familia = const Value.absent(),
            Value<String> unidade = const Value.absent(),
            Value<int> sobeSap = const Value.absent(),
            Value<bool> ativo = const Value.absent(),
            Value<String> nomeStock = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              MateriaisCompanion(
            codigo: codigo,
            descricao: descricao,
            fornecedor: fornecedor,
            familia: familia,
            unidade: unidade,
            sobeSap: sobeSap,
            ativo: ativo,
            nomeStock: nomeStock,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String codigo,
            required String descricao,
            required String fornecedor,
            required String familia,
            required String unidade,
            Value<int> sobeSap = const Value.absent(),
            Value<bool> ativo = const Value.absent(),
            required String nomeStock,
            Value<int> rowid = const Value.absent(),
          }) =>
              MateriaisCompanion.insert(
            codigo: codigo,
            descricao: descricao,
            fornecedor: fornecedor,
            familia: familia,
            unidade: unidade,
            sobeSap: sobeSap,
            ativo: ativo,
            nomeStock: nomeStock,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$MateriaisTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $MateriaisTable,
    MaterialCadastro,
    $$MateriaisTableFilterComposer,
    $$MateriaisTableOrderingComposer,
    $$MateriaisTableAnnotationComposer,
    $$MateriaisTableCreateCompanionBuilder,
    $$MateriaisTableUpdateCompanionBuilder,
    (
      MaterialCadastro,
      BaseReferences<_$AppDatabase, $MateriaisTable, MaterialCadastro>
    ),
    MaterialCadastro,
    PrefetchHooks Function()>;
typedef $$FornecedoresTableCreateCompanionBuilder = FornecedoresCompanion
    Function({
  required String nome,
  required int ordem,
  Value<int> rowid,
});
typedef $$FornecedoresTableUpdateCompanionBuilder = FornecedoresCompanion
    Function({
  Value<String> nome,
  Value<int> ordem,
  Value<int> rowid,
});

class $$FornecedoresTableFilterComposer
    extends Composer<_$AppDatabase, $FornecedoresTable> {
  $$FornecedoresTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get nome => $composableBuilder(
      column: $table.nome, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get ordem => $composableBuilder(
      column: $table.ordem, builder: (column) => ColumnFilters(column));
}

class $$FornecedoresTableOrderingComposer
    extends Composer<_$AppDatabase, $FornecedoresTable> {
  $$FornecedoresTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get nome => $composableBuilder(
      column: $table.nome, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get ordem => $composableBuilder(
      column: $table.ordem, builder: (column) => ColumnOrderings(column));
}

class $$FornecedoresTableAnnotationComposer
    extends Composer<_$AppDatabase, $FornecedoresTable> {
  $$FornecedoresTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get nome =>
      $composableBuilder(column: $table.nome, builder: (column) => column);

  GeneratedColumn<int> get ordem =>
      $composableBuilder(column: $table.ordem, builder: (column) => column);
}

class $$FornecedoresTableTableManager extends RootTableManager<
    _$AppDatabase,
    $FornecedoresTable,
    FornecedorRow,
    $$FornecedoresTableFilterComposer,
    $$FornecedoresTableOrderingComposer,
    $$FornecedoresTableAnnotationComposer,
    $$FornecedoresTableCreateCompanionBuilder,
    $$FornecedoresTableUpdateCompanionBuilder,
    (
      FornecedorRow,
      BaseReferences<_$AppDatabase, $FornecedoresTable, FornecedorRow>
    ),
    FornecedorRow,
    PrefetchHooks Function()> {
  $$FornecedoresTableTableManager(_$AppDatabase db, $FornecedoresTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FornecedoresTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FornecedoresTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FornecedoresTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> nome = const Value.absent(),
            Value<int> ordem = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              FornecedoresCompanion(
            nome: nome,
            ordem: ordem,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String nome,
            required int ordem,
            Value<int> rowid = const Value.absent(),
          }) =>
              FornecedoresCompanion.insert(
            nome: nome,
            ordem: ordem,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$FornecedoresTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $FornecedoresTable,
    FornecedorRow,
    $$FornecedoresTableFilterComposer,
    $$FornecedoresTableOrderingComposer,
    $$FornecedoresTableAnnotationComposer,
    $$FornecedoresTableCreateCompanionBuilder,
    $$FornecedoresTableUpdateCompanionBuilder,
    (
      FornecedorRow,
      BaseReferences<_$AppDatabase, $FornecedoresTable, FornecedorRow>
    ),
    FornecedorRow,
    PrefetchHooks Function()>;
typedef $$EstoqueReferenciaTableCreateCompanionBuilder
    = EstoqueReferenciaCompanion Function({
  required String materialCodigo,
  required double estoqueFinalKg,
  Value<String?> sessaoOrigemId,
  required DateTime dataReferencia,
  Value<int> rowid,
});
typedef $$EstoqueReferenciaTableUpdateCompanionBuilder
    = EstoqueReferenciaCompanion Function({
  Value<String> materialCodigo,
  Value<double> estoqueFinalKg,
  Value<String?> sessaoOrigemId,
  Value<DateTime> dataReferencia,
  Value<int> rowid,
});

class $$EstoqueReferenciaTableFilterComposer
    extends Composer<_$AppDatabase, $EstoqueReferenciaTable> {
  $$EstoqueReferenciaTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get materialCodigo => $composableBuilder(
      column: $table.materialCodigo,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get estoqueFinalKg => $composableBuilder(
      column: $table.estoqueFinalKg,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get sessaoOrigemId => $composableBuilder(
      column: $table.sessaoOrigemId,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get dataReferencia => $composableBuilder(
      column: $table.dataReferencia,
      builder: (column) => ColumnFilters(column));
}

class $$EstoqueReferenciaTableOrderingComposer
    extends Composer<_$AppDatabase, $EstoqueReferenciaTable> {
  $$EstoqueReferenciaTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get materialCodigo => $composableBuilder(
      column: $table.materialCodigo,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get estoqueFinalKg => $composableBuilder(
      column: $table.estoqueFinalKg,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get sessaoOrigemId => $composableBuilder(
      column: $table.sessaoOrigemId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get dataReferencia => $composableBuilder(
      column: $table.dataReferencia,
      builder: (column) => ColumnOrderings(column));
}

class $$EstoqueReferenciaTableAnnotationComposer
    extends Composer<_$AppDatabase, $EstoqueReferenciaTable> {
  $$EstoqueReferenciaTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get materialCodigo => $composableBuilder(
      column: $table.materialCodigo, builder: (column) => column);

  GeneratedColumn<double> get estoqueFinalKg => $composableBuilder(
      column: $table.estoqueFinalKg, builder: (column) => column);

  GeneratedColumn<String> get sessaoOrigemId => $composableBuilder(
      column: $table.sessaoOrigemId, builder: (column) => column);

  GeneratedColumn<DateTime> get dataReferencia => $composableBuilder(
      column: $table.dataReferencia, builder: (column) => column);
}

class $$EstoqueReferenciaTableTableManager extends RootTableManager<
    _$AppDatabase,
    $EstoqueReferenciaTable,
    EstoqueReferenciaRow,
    $$EstoqueReferenciaTableFilterComposer,
    $$EstoqueReferenciaTableOrderingComposer,
    $$EstoqueReferenciaTableAnnotationComposer,
    $$EstoqueReferenciaTableCreateCompanionBuilder,
    $$EstoqueReferenciaTableUpdateCompanionBuilder,
    (
      EstoqueReferenciaRow,
      BaseReferences<_$AppDatabase, $EstoqueReferenciaTable,
          EstoqueReferenciaRow>
    ),
    EstoqueReferenciaRow,
    PrefetchHooks Function()> {
  $$EstoqueReferenciaTableTableManager(
      _$AppDatabase db, $EstoqueReferenciaTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EstoqueReferenciaTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EstoqueReferenciaTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EstoqueReferenciaTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> materialCodigo = const Value.absent(),
            Value<double> estoqueFinalKg = const Value.absent(),
            Value<String?> sessaoOrigemId = const Value.absent(),
            Value<DateTime> dataReferencia = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              EstoqueReferenciaCompanion(
            materialCodigo: materialCodigo,
            estoqueFinalKg: estoqueFinalKg,
            sessaoOrigemId: sessaoOrigemId,
            dataReferencia: dataReferencia,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String materialCodigo,
            required double estoqueFinalKg,
            Value<String?> sessaoOrigemId = const Value.absent(),
            required DateTime dataReferencia,
            Value<int> rowid = const Value.absent(),
          }) =>
              EstoqueReferenciaCompanion.insert(
            materialCodigo: materialCodigo,
            estoqueFinalKg: estoqueFinalKg,
            sessaoOrigemId: sessaoOrigemId,
            dataReferencia: dataReferencia,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$EstoqueReferenciaTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $EstoqueReferenciaTable,
    EstoqueReferenciaRow,
    $$EstoqueReferenciaTableFilterComposer,
    $$EstoqueReferenciaTableOrderingComposer,
    $$EstoqueReferenciaTableAnnotationComposer,
    $$EstoqueReferenciaTableCreateCompanionBuilder,
    $$EstoqueReferenciaTableUpdateCompanionBuilder,
    (
      EstoqueReferenciaRow,
      BaseReferences<_$AppDatabase, $EstoqueReferenciaTable,
          EstoqueReferenciaRow>
    ),
    EstoqueReferenciaRow,
    PrefetchHooks Function()>;
typedef $$SessoesTableCreateCompanionBuilder = SessoesCompanion Function({
  required String id,
  required String operadorNome,
  required String operadorMatricula,
  required DateTime dataInicio,
  Value<DateTime?> dataFimPrevista,
  Value<DateTime?> dataFimReal,
  required String status,
  required String versaoCadastro,
  Value<String?> aparelho,
  Value<int> rowid,
});
typedef $$SessoesTableUpdateCompanionBuilder = SessoesCompanion Function({
  Value<String> id,
  Value<String> operadorNome,
  Value<String> operadorMatricula,
  Value<DateTime> dataInicio,
  Value<DateTime?> dataFimPrevista,
  Value<DateTime?> dataFimReal,
  Value<String> status,
  Value<String> versaoCadastro,
  Value<String?> aparelho,
  Value<int> rowid,
});

class $$SessoesTableFilterComposer
    extends Composer<_$AppDatabase, $SessoesTable> {
  $$SessoesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get operadorNome => $composableBuilder(
      column: $table.operadorNome, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get operadorMatricula => $composableBuilder(
      column: $table.operadorMatricula,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get dataInicio => $composableBuilder(
      column: $table.dataInicio, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get dataFimPrevista => $composableBuilder(
      column: $table.dataFimPrevista,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get dataFimReal => $composableBuilder(
      column: $table.dataFimReal, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get versaoCadastro => $composableBuilder(
      column: $table.versaoCadastro,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get aparelho => $composableBuilder(
      column: $table.aparelho, builder: (column) => ColumnFilters(column));
}

class $$SessoesTableOrderingComposer
    extends Composer<_$AppDatabase, $SessoesTable> {
  $$SessoesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get operadorNome => $composableBuilder(
      column: $table.operadorNome,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get operadorMatricula => $composableBuilder(
      column: $table.operadorMatricula,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get dataInicio => $composableBuilder(
      column: $table.dataInicio, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get dataFimPrevista => $composableBuilder(
      column: $table.dataFimPrevista,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get dataFimReal => $composableBuilder(
      column: $table.dataFimReal, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get versaoCadastro => $composableBuilder(
      column: $table.versaoCadastro,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get aparelho => $composableBuilder(
      column: $table.aparelho, builder: (column) => ColumnOrderings(column));
}

class $$SessoesTableAnnotationComposer
    extends Composer<_$AppDatabase, $SessoesTable> {
  $$SessoesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get operadorNome => $composableBuilder(
      column: $table.operadorNome, builder: (column) => column);

  GeneratedColumn<String> get operadorMatricula => $composableBuilder(
      column: $table.operadorMatricula, builder: (column) => column);

  GeneratedColumn<DateTime> get dataInicio => $composableBuilder(
      column: $table.dataInicio, builder: (column) => column);

  GeneratedColumn<DateTime> get dataFimPrevista => $composableBuilder(
      column: $table.dataFimPrevista, builder: (column) => column);

  GeneratedColumn<DateTime> get dataFimReal => $composableBuilder(
      column: $table.dataFimReal, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get versaoCadastro => $composableBuilder(
      column: $table.versaoCadastro, builder: (column) => column);

  GeneratedColumn<String> get aparelho =>
      $composableBuilder(column: $table.aparelho, builder: (column) => column);
}

class $$SessoesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SessoesTable,
    SessaoRow,
    $$SessoesTableFilterComposer,
    $$SessoesTableOrderingComposer,
    $$SessoesTableAnnotationComposer,
    $$SessoesTableCreateCompanionBuilder,
    $$SessoesTableUpdateCompanionBuilder,
    (SessaoRow, BaseReferences<_$AppDatabase, $SessoesTable, SessaoRow>),
    SessaoRow,
    PrefetchHooks Function()> {
  $$SessoesTableTableManager(_$AppDatabase db, $SessoesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SessoesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SessoesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SessoesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> operadorNome = const Value.absent(),
            Value<String> operadorMatricula = const Value.absent(),
            Value<DateTime> dataInicio = const Value.absent(),
            Value<DateTime?> dataFimPrevista = const Value.absent(),
            Value<DateTime?> dataFimReal = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<String> versaoCadastro = const Value.absent(),
            Value<String?> aparelho = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SessoesCompanion(
            id: id,
            operadorNome: operadorNome,
            operadorMatricula: operadorMatricula,
            dataInicio: dataInicio,
            dataFimPrevista: dataFimPrevista,
            dataFimReal: dataFimReal,
            status: status,
            versaoCadastro: versaoCadastro,
            aparelho: aparelho,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String operadorNome,
            required String operadorMatricula,
            required DateTime dataInicio,
            Value<DateTime?> dataFimPrevista = const Value.absent(),
            Value<DateTime?> dataFimReal = const Value.absent(),
            required String status,
            required String versaoCadastro,
            Value<String?> aparelho = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SessoesCompanion.insert(
            id: id,
            operadorNome: operadorNome,
            operadorMatricula: operadorMatricula,
            dataInicio: dataInicio,
            dataFimPrevista: dataFimPrevista,
            dataFimReal: dataFimReal,
            status: status,
            versaoCadastro: versaoCadastro,
            aparelho: aparelho,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$SessoesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SessoesTable,
    SessaoRow,
    $$SessoesTableFilterComposer,
    $$SessoesTableOrderingComposer,
    $$SessoesTableAnnotationComposer,
    $$SessoesTableCreateCompanionBuilder,
    $$SessoesTableUpdateCompanionBuilder,
    (SessaoRow, BaseReferences<_$AppDatabase, $SessoesTable, SessaoRow>),
    SessaoRow,
    PrefetchHooks Function()>;
typedef $$ItensContagemTableCreateCompanionBuilder = ItensContagemCompanion
    Function({
  required String id,
  required String sessaoId,
  required String materialCodigo,
  required double estoqueAnterior,
  Value<double?> estoqueContado,
  Value<double?> linhaEstoque,
  Value<String?> containersJson,
  Value<double?> cubaEstoque,
  Value<double?> outrosEstoque,
  Value<double?> recebimentoTotal,
  Value<String?> observacao,
  Value<String?> justificativa,
  Value<String?> justificativaFotoPath,
  Value<String?> fotoPath,
  required String status,
  required DateTime timestamp,
  Value<int> rowid,
});
typedef $$ItensContagemTableUpdateCompanionBuilder = ItensContagemCompanion
    Function({
  Value<String> id,
  Value<String> sessaoId,
  Value<String> materialCodigo,
  Value<double> estoqueAnterior,
  Value<double?> estoqueContado,
  Value<double?> linhaEstoque,
  Value<String?> containersJson,
  Value<double?> cubaEstoque,
  Value<double?> outrosEstoque,
  Value<double?> recebimentoTotal,
  Value<String?> observacao,
  Value<String?> justificativa,
  Value<String?> justificativaFotoPath,
  Value<String?> fotoPath,
  Value<String> status,
  Value<DateTime> timestamp,
  Value<int> rowid,
});

class $$ItensContagemTableFilterComposer
    extends Composer<_$AppDatabase, $ItensContagemTable> {
  $$ItensContagemTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get sessaoId => $composableBuilder(
      column: $table.sessaoId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get materialCodigo => $composableBuilder(
      column: $table.materialCodigo,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get estoqueAnterior => $composableBuilder(
      column: $table.estoqueAnterior,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get estoqueContado => $composableBuilder(
      column: $table.estoqueContado,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get linhaEstoque => $composableBuilder(
      column: $table.linhaEstoque, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get containersJson => $composableBuilder(
      column: $table.containersJson,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get cubaEstoque => $composableBuilder(
      column: $table.cubaEstoque, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get outrosEstoque => $composableBuilder(
      column: $table.outrosEstoque, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get recebimentoTotal => $composableBuilder(
      column: $table.recebimentoTotal,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get observacao => $composableBuilder(
      column: $table.observacao, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get justificativa => $composableBuilder(
      column: $table.justificativa, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get justificativaFotoPath => $composableBuilder(
      column: $table.justificativaFotoPath,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get fotoPath => $composableBuilder(
      column: $table.fotoPath, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get timestamp => $composableBuilder(
      column: $table.timestamp, builder: (column) => ColumnFilters(column));
}

class $$ItensContagemTableOrderingComposer
    extends Composer<_$AppDatabase, $ItensContagemTable> {
  $$ItensContagemTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get sessaoId => $composableBuilder(
      column: $table.sessaoId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get materialCodigo => $composableBuilder(
      column: $table.materialCodigo,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get estoqueAnterior => $composableBuilder(
      column: $table.estoqueAnterior,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get estoqueContado => $composableBuilder(
      column: $table.estoqueContado,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get linhaEstoque => $composableBuilder(
      column: $table.linhaEstoque,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get containersJson => $composableBuilder(
      column: $table.containersJson,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get cubaEstoque => $composableBuilder(
      column: $table.cubaEstoque, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get outrosEstoque => $composableBuilder(
      column: $table.outrosEstoque,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get recebimentoTotal => $composableBuilder(
      column: $table.recebimentoTotal,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get observacao => $composableBuilder(
      column: $table.observacao, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get justificativa => $composableBuilder(
      column: $table.justificativa,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get justificativaFotoPath => $composableBuilder(
      column: $table.justificativaFotoPath,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get fotoPath => $composableBuilder(
      column: $table.fotoPath, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get timestamp => $composableBuilder(
      column: $table.timestamp, builder: (column) => ColumnOrderings(column));
}

class $$ItensContagemTableAnnotationComposer
    extends Composer<_$AppDatabase, $ItensContagemTable> {
  $$ItensContagemTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get sessaoId =>
      $composableBuilder(column: $table.sessaoId, builder: (column) => column);

  GeneratedColumn<String> get materialCodigo => $composableBuilder(
      column: $table.materialCodigo, builder: (column) => column);

  GeneratedColumn<double> get estoqueAnterior => $composableBuilder(
      column: $table.estoqueAnterior, builder: (column) => column);

  GeneratedColumn<double> get estoqueContado => $composableBuilder(
      column: $table.estoqueContado, builder: (column) => column);

  GeneratedColumn<double> get linhaEstoque => $composableBuilder(
      column: $table.linhaEstoque, builder: (column) => column);

  GeneratedColumn<String> get containersJson => $composableBuilder(
      column: $table.containersJson, builder: (column) => column);

  GeneratedColumn<double> get cubaEstoque => $composableBuilder(
      column: $table.cubaEstoque, builder: (column) => column);

  GeneratedColumn<double> get outrosEstoque => $composableBuilder(
      column: $table.outrosEstoque, builder: (column) => column);

  GeneratedColumn<double> get recebimentoTotal => $composableBuilder(
      column: $table.recebimentoTotal, builder: (column) => column);

  GeneratedColumn<String> get observacao => $composableBuilder(
      column: $table.observacao, builder: (column) => column);

  GeneratedColumn<String> get justificativa => $composableBuilder(
      column: $table.justificativa, builder: (column) => column);

  GeneratedColumn<String> get justificativaFotoPath => $composableBuilder(
      column: $table.justificativaFotoPath, builder: (column) => column);

  GeneratedColumn<String> get fotoPath =>
      $composableBuilder(column: $table.fotoPath, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);
}

class $$ItensContagemTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ItensContagemTable,
    ItemContagemRow,
    $$ItensContagemTableFilterComposer,
    $$ItensContagemTableOrderingComposer,
    $$ItensContagemTableAnnotationComposer,
    $$ItensContagemTableCreateCompanionBuilder,
    $$ItensContagemTableUpdateCompanionBuilder,
    (
      ItemContagemRow,
      BaseReferences<_$AppDatabase, $ItensContagemTable, ItemContagemRow>
    ),
    ItemContagemRow,
    PrefetchHooks Function()> {
  $$ItensContagemTableTableManager(_$AppDatabase db, $ItensContagemTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ItensContagemTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ItensContagemTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ItensContagemTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> sessaoId = const Value.absent(),
            Value<String> materialCodigo = const Value.absent(),
            Value<double> estoqueAnterior = const Value.absent(),
            Value<double?> estoqueContado = const Value.absent(),
            Value<double?> linhaEstoque = const Value.absent(),
            Value<String?> containersJson = const Value.absent(),
            Value<double?> cubaEstoque = const Value.absent(),
            Value<double?> outrosEstoque = const Value.absent(),
            Value<double?> recebimentoTotal = const Value.absent(),
            Value<String?> observacao = const Value.absent(),
            Value<String?> justificativa = const Value.absent(),
            Value<String?> justificativaFotoPath = const Value.absent(),
            Value<String?> fotoPath = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<DateTime> timestamp = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ItensContagemCompanion(
            id: id,
            sessaoId: sessaoId,
            materialCodigo: materialCodigo,
            estoqueAnterior: estoqueAnterior,
            estoqueContado: estoqueContado,
            linhaEstoque: linhaEstoque,
            containersJson: containersJson,
            cubaEstoque: cubaEstoque,
            outrosEstoque: outrosEstoque,
            recebimentoTotal: recebimentoTotal,
            observacao: observacao,
            justificativa: justificativa,
            justificativaFotoPath: justificativaFotoPath,
            fotoPath: fotoPath,
            status: status,
            timestamp: timestamp,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String sessaoId,
            required String materialCodigo,
            required double estoqueAnterior,
            Value<double?> estoqueContado = const Value.absent(),
            Value<double?> linhaEstoque = const Value.absent(),
            Value<String?> containersJson = const Value.absent(),
            Value<double?> cubaEstoque = const Value.absent(),
            Value<double?> outrosEstoque = const Value.absent(),
            Value<double?> recebimentoTotal = const Value.absent(),
            Value<String?> observacao = const Value.absent(),
            Value<String?> justificativa = const Value.absent(),
            Value<String?> justificativaFotoPath = const Value.absent(),
            Value<String?> fotoPath = const Value.absent(),
            required String status,
            required DateTime timestamp,
            Value<int> rowid = const Value.absent(),
          }) =>
              ItensContagemCompanion.insert(
            id: id,
            sessaoId: sessaoId,
            materialCodigo: materialCodigo,
            estoqueAnterior: estoqueAnterior,
            estoqueContado: estoqueContado,
            linhaEstoque: linhaEstoque,
            containersJson: containersJson,
            cubaEstoque: cubaEstoque,
            outrosEstoque: outrosEstoque,
            recebimentoTotal: recebimentoTotal,
            observacao: observacao,
            justificativa: justificativa,
            justificativaFotoPath: justificativaFotoPath,
            fotoPath: fotoPath,
            status: status,
            timestamp: timestamp,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ItensContagemTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ItensContagemTable,
    ItemContagemRow,
    $$ItensContagemTableFilterComposer,
    $$ItensContagemTableOrderingComposer,
    $$ItensContagemTableAnnotationComposer,
    $$ItensContagemTableCreateCompanionBuilder,
    $$ItensContagemTableUpdateCompanionBuilder,
    (
      ItemContagemRow,
      BaseReferences<_$AppDatabase, $ItensContagemTable, ItemContagemRow>
    ),
    ItemContagemRow,
    PrefetchHooks Function()>;
typedef $$NotasRecebimentoTableCreateCompanionBuilder
    = NotasRecebimentoCompanion Function({
  required String id,
  required String itemId,
  required String numero,
  required double quantidade,
  Value<DateTime?> dataRecebimento,
  Value<String?> fotoPath,
  Value<int> rowid,
});
typedef $$NotasRecebimentoTableUpdateCompanionBuilder
    = NotasRecebimentoCompanion Function({
  Value<String> id,
  Value<String> itemId,
  Value<String> numero,
  Value<double> quantidade,
  Value<DateTime?> dataRecebimento,
  Value<String?> fotoPath,
  Value<int> rowid,
});

class $$NotasRecebimentoTableFilterComposer
    extends Composer<_$AppDatabase, $NotasRecebimentoTable> {
  $$NotasRecebimentoTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get itemId => $composableBuilder(
      column: $table.itemId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get numero => $composableBuilder(
      column: $table.numero, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get quantidade => $composableBuilder(
      column: $table.quantidade, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get dataRecebimento => $composableBuilder(
      column: $table.dataRecebimento,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get fotoPath => $composableBuilder(
      column: $table.fotoPath, builder: (column) => ColumnFilters(column));
}

class $$NotasRecebimentoTableOrderingComposer
    extends Composer<_$AppDatabase, $NotasRecebimentoTable> {
  $$NotasRecebimentoTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get itemId => $composableBuilder(
      column: $table.itemId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get numero => $composableBuilder(
      column: $table.numero, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get quantidade => $composableBuilder(
      column: $table.quantidade, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get dataRecebimento => $composableBuilder(
      column: $table.dataRecebimento,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get fotoPath => $composableBuilder(
      column: $table.fotoPath, builder: (column) => ColumnOrderings(column));
}

class $$NotasRecebimentoTableAnnotationComposer
    extends Composer<_$AppDatabase, $NotasRecebimentoTable> {
  $$NotasRecebimentoTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get itemId =>
      $composableBuilder(column: $table.itemId, builder: (column) => column);

  GeneratedColumn<String> get numero =>
      $composableBuilder(column: $table.numero, builder: (column) => column);

  GeneratedColumn<double> get quantidade => $composableBuilder(
      column: $table.quantidade, builder: (column) => column);

  GeneratedColumn<DateTime> get dataRecebimento => $composableBuilder(
      column: $table.dataRecebimento, builder: (column) => column);

  GeneratedColumn<String> get fotoPath =>
      $composableBuilder(column: $table.fotoPath, builder: (column) => column);
}

class $$NotasRecebimentoTableTableManager extends RootTableManager<
    _$AppDatabase,
    $NotasRecebimentoTable,
    NotaRecebimentoRow,
    $$NotasRecebimentoTableFilterComposer,
    $$NotasRecebimentoTableOrderingComposer,
    $$NotasRecebimentoTableAnnotationComposer,
    $$NotasRecebimentoTableCreateCompanionBuilder,
    $$NotasRecebimentoTableUpdateCompanionBuilder,
    (
      NotaRecebimentoRow,
      BaseReferences<_$AppDatabase, $NotasRecebimentoTable, NotaRecebimentoRow>
    ),
    NotaRecebimentoRow,
    PrefetchHooks Function()> {
  $$NotasRecebimentoTableTableManager(
      _$AppDatabase db, $NotasRecebimentoTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NotasRecebimentoTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$NotasRecebimentoTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$NotasRecebimentoTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> itemId = const Value.absent(),
            Value<String> numero = const Value.absent(),
            Value<double> quantidade = const Value.absent(),
            Value<DateTime?> dataRecebimento = const Value.absent(),
            Value<String?> fotoPath = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              NotasRecebimentoCompanion(
            id: id,
            itemId: itemId,
            numero: numero,
            quantidade: quantidade,
            dataRecebimento: dataRecebimento,
            fotoPath: fotoPath,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String itemId,
            required String numero,
            required double quantidade,
            Value<DateTime?> dataRecebimento = const Value.absent(),
            Value<String?> fotoPath = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              NotasRecebimentoCompanion.insert(
            id: id,
            itemId: itemId,
            numero: numero,
            quantidade: quantidade,
            dataRecebimento: dataRecebimento,
            fotoPath: fotoPath,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$NotasRecebimentoTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $NotasRecebimentoTable,
    NotaRecebimentoRow,
    $$NotasRecebimentoTableFilterComposer,
    $$NotasRecebimentoTableOrderingComposer,
    $$NotasRecebimentoTableAnnotationComposer,
    $$NotasRecebimentoTableCreateCompanionBuilder,
    $$NotasRecebimentoTableUpdateCompanionBuilder,
    (
      NotaRecebimentoRow,
      BaseReferences<_$AppDatabase, $NotasRecebimentoTable, NotaRecebimentoRow>
    ),
    NotaRecebimentoRow,
    PrefetchHooks Function()>;
typedef $$ExportsTableCreateCompanionBuilder = ExportsCompanion Function({
  required String id,
  required String sessaoId,
  Value<String?> caminhoExcel,
  Value<String?> caminhoPdf,
  required DateTime timestamp,
  Value<int> rowid,
});
typedef $$ExportsTableUpdateCompanionBuilder = ExportsCompanion Function({
  Value<String> id,
  Value<String> sessaoId,
  Value<String?> caminhoExcel,
  Value<String?> caminhoPdf,
  Value<DateTime> timestamp,
  Value<int> rowid,
});

class $$ExportsTableFilterComposer
    extends Composer<_$AppDatabase, $ExportsTable> {
  $$ExportsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get sessaoId => $composableBuilder(
      column: $table.sessaoId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get caminhoExcel => $composableBuilder(
      column: $table.caminhoExcel, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get caminhoPdf => $composableBuilder(
      column: $table.caminhoPdf, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get timestamp => $composableBuilder(
      column: $table.timestamp, builder: (column) => ColumnFilters(column));
}

class $$ExportsTableOrderingComposer
    extends Composer<_$AppDatabase, $ExportsTable> {
  $$ExportsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get sessaoId => $composableBuilder(
      column: $table.sessaoId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get caminhoExcel => $composableBuilder(
      column: $table.caminhoExcel,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get caminhoPdf => $composableBuilder(
      column: $table.caminhoPdf, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get timestamp => $composableBuilder(
      column: $table.timestamp, builder: (column) => ColumnOrderings(column));
}

class $$ExportsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExportsTable> {
  $$ExportsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get sessaoId =>
      $composableBuilder(column: $table.sessaoId, builder: (column) => column);

  GeneratedColumn<String> get caminhoExcel => $composableBuilder(
      column: $table.caminhoExcel, builder: (column) => column);

  GeneratedColumn<String> get caminhoPdf => $composableBuilder(
      column: $table.caminhoPdf, builder: (column) => column);

  GeneratedColumn<DateTime> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);
}

class $$ExportsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ExportsTable,
    ExportRow,
    $$ExportsTableFilterComposer,
    $$ExportsTableOrderingComposer,
    $$ExportsTableAnnotationComposer,
    $$ExportsTableCreateCompanionBuilder,
    $$ExportsTableUpdateCompanionBuilder,
    (ExportRow, BaseReferences<_$AppDatabase, $ExportsTable, ExportRow>),
    ExportRow,
    PrefetchHooks Function()> {
  $$ExportsTableTableManager(_$AppDatabase db, $ExportsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExportsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExportsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExportsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> sessaoId = const Value.absent(),
            Value<String?> caminhoExcel = const Value.absent(),
            Value<String?> caminhoPdf = const Value.absent(),
            Value<DateTime> timestamp = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ExportsCompanion(
            id: id,
            sessaoId: sessaoId,
            caminhoExcel: caminhoExcel,
            caminhoPdf: caminhoPdf,
            timestamp: timestamp,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String sessaoId,
            Value<String?> caminhoExcel = const Value.absent(),
            Value<String?> caminhoPdf = const Value.absent(),
            required DateTime timestamp,
            Value<int> rowid = const Value.absent(),
          }) =>
              ExportsCompanion.insert(
            id: id,
            sessaoId: sessaoId,
            caminhoExcel: caminhoExcel,
            caminhoPdf: caminhoPdf,
            timestamp: timestamp,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ExportsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ExportsTable,
    ExportRow,
    $$ExportsTableFilterComposer,
    $$ExportsTableOrderingComposer,
    $$ExportsTableAnnotationComposer,
    $$ExportsTableCreateCompanionBuilder,
    $$ExportsTableUpdateCompanionBuilder,
    (ExportRow, BaseReferences<_$AppDatabase, $ExportsTable, ExportRow>),
    ExportRow,
    PrefetchHooks Function()>;
typedef $$ItensHistoricoTableCreateCompanionBuilder = ItensHistoricoCompanion
    Function({
  required String id,
  required String itemId,
  required String sessaoId,
  required String materialCodigo,
  required String acao,
  required String operadorNome,
  Value<double?> estoqueAnterior,
  Value<double?> estoqueContado,
  Value<double?> recebimentoTotal,
  Value<String?> status,
  Value<String?> observacao,
  Value<String?> justificativa,
  required DateTime timestamp,
  Value<int> rowid,
});
typedef $$ItensHistoricoTableUpdateCompanionBuilder = ItensHistoricoCompanion
    Function({
  Value<String> id,
  Value<String> itemId,
  Value<String> sessaoId,
  Value<String> materialCodigo,
  Value<String> acao,
  Value<String> operadorNome,
  Value<double?> estoqueAnterior,
  Value<double?> estoqueContado,
  Value<double?> recebimentoTotal,
  Value<String?> status,
  Value<String?> observacao,
  Value<String?> justificativa,
  Value<DateTime> timestamp,
  Value<int> rowid,
});

class $$ItensHistoricoTableFilterComposer
    extends Composer<_$AppDatabase, $ItensHistoricoTable> {
  $$ItensHistoricoTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get itemId => $composableBuilder(
      column: $table.itemId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get sessaoId => $composableBuilder(
      column: $table.sessaoId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get materialCodigo => $composableBuilder(
      column: $table.materialCodigo,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get acao => $composableBuilder(
      column: $table.acao, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get operadorNome => $composableBuilder(
      column: $table.operadorNome, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get estoqueAnterior => $composableBuilder(
      column: $table.estoqueAnterior,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get estoqueContado => $composableBuilder(
      column: $table.estoqueContado,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get recebimentoTotal => $composableBuilder(
      column: $table.recebimentoTotal,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get observacao => $composableBuilder(
      column: $table.observacao, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get justificativa => $composableBuilder(
      column: $table.justificativa, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get timestamp => $composableBuilder(
      column: $table.timestamp, builder: (column) => ColumnFilters(column));
}

class $$ItensHistoricoTableOrderingComposer
    extends Composer<_$AppDatabase, $ItensHistoricoTable> {
  $$ItensHistoricoTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get itemId => $composableBuilder(
      column: $table.itemId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get sessaoId => $composableBuilder(
      column: $table.sessaoId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get materialCodigo => $composableBuilder(
      column: $table.materialCodigo,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get acao => $composableBuilder(
      column: $table.acao, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get operadorNome => $composableBuilder(
      column: $table.operadorNome,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get estoqueAnterior => $composableBuilder(
      column: $table.estoqueAnterior,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get estoqueContado => $composableBuilder(
      column: $table.estoqueContado,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get recebimentoTotal => $composableBuilder(
      column: $table.recebimentoTotal,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get observacao => $composableBuilder(
      column: $table.observacao, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get justificativa => $composableBuilder(
      column: $table.justificativa,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get timestamp => $composableBuilder(
      column: $table.timestamp, builder: (column) => ColumnOrderings(column));
}

class $$ItensHistoricoTableAnnotationComposer
    extends Composer<_$AppDatabase, $ItensHistoricoTable> {
  $$ItensHistoricoTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get itemId =>
      $composableBuilder(column: $table.itemId, builder: (column) => column);

  GeneratedColumn<String> get sessaoId =>
      $composableBuilder(column: $table.sessaoId, builder: (column) => column);

  GeneratedColumn<String> get materialCodigo => $composableBuilder(
      column: $table.materialCodigo, builder: (column) => column);

  GeneratedColumn<String> get acao =>
      $composableBuilder(column: $table.acao, builder: (column) => column);

  GeneratedColumn<String> get operadorNome => $composableBuilder(
      column: $table.operadorNome, builder: (column) => column);

  GeneratedColumn<double> get estoqueAnterior => $composableBuilder(
      column: $table.estoqueAnterior, builder: (column) => column);

  GeneratedColumn<double> get estoqueContado => $composableBuilder(
      column: $table.estoqueContado, builder: (column) => column);

  GeneratedColumn<double> get recebimentoTotal => $composableBuilder(
      column: $table.recebimentoTotal, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get observacao => $composableBuilder(
      column: $table.observacao, builder: (column) => column);

  GeneratedColumn<String> get justificativa => $composableBuilder(
      column: $table.justificativa, builder: (column) => column);

  GeneratedColumn<DateTime> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);
}

class $$ItensHistoricoTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ItensHistoricoTable,
    ItemHistoricoRow,
    $$ItensHistoricoTableFilterComposer,
    $$ItensHistoricoTableOrderingComposer,
    $$ItensHistoricoTableAnnotationComposer,
    $$ItensHistoricoTableCreateCompanionBuilder,
    $$ItensHistoricoTableUpdateCompanionBuilder,
    (
      ItemHistoricoRow,
      BaseReferences<_$AppDatabase, $ItensHistoricoTable, ItemHistoricoRow>
    ),
    ItemHistoricoRow,
    PrefetchHooks Function()> {
  $$ItensHistoricoTableTableManager(
      _$AppDatabase db, $ItensHistoricoTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ItensHistoricoTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ItensHistoricoTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ItensHistoricoTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> itemId = const Value.absent(),
            Value<String> sessaoId = const Value.absent(),
            Value<String> materialCodigo = const Value.absent(),
            Value<String> acao = const Value.absent(),
            Value<String> operadorNome = const Value.absent(),
            Value<double?> estoqueAnterior = const Value.absent(),
            Value<double?> estoqueContado = const Value.absent(),
            Value<double?> recebimentoTotal = const Value.absent(),
            Value<String?> status = const Value.absent(),
            Value<String?> observacao = const Value.absent(),
            Value<String?> justificativa = const Value.absent(),
            Value<DateTime> timestamp = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ItensHistoricoCompanion(
            id: id,
            itemId: itemId,
            sessaoId: sessaoId,
            materialCodigo: materialCodigo,
            acao: acao,
            operadorNome: operadorNome,
            estoqueAnterior: estoqueAnterior,
            estoqueContado: estoqueContado,
            recebimentoTotal: recebimentoTotal,
            status: status,
            observacao: observacao,
            justificativa: justificativa,
            timestamp: timestamp,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String itemId,
            required String sessaoId,
            required String materialCodigo,
            required String acao,
            required String operadorNome,
            Value<double?> estoqueAnterior = const Value.absent(),
            Value<double?> estoqueContado = const Value.absent(),
            Value<double?> recebimentoTotal = const Value.absent(),
            Value<String?> status = const Value.absent(),
            Value<String?> observacao = const Value.absent(),
            Value<String?> justificativa = const Value.absent(),
            required DateTime timestamp,
            Value<int> rowid = const Value.absent(),
          }) =>
              ItensHistoricoCompanion.insert(
            id: id,
            itemId: itemId,
            sessaoId: sessaoId,
            materialCodigo: materialCodigo,
            acao: acao,
            operadorNome: operadorNome,
            estoqueAnterior: estoqueAnterior,
            estoqueContado: estoqueContado,
            recebimentoTotal: recebimentoTotal,
            status: status,
            observacao: observacao,
            justificativa: justificativa,
            timestamp: timestamp,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ItensHistoricoTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ItensHistoricoTable,
    ItemHistoricoRow,
    $$ItensHistoricoTableFilterComposer,
    $$ItensHistoricoTableOrderingComposer,
    $$ItensHistoricoTableAnnotationComposer,
    $$ItensHistoricoTableCreateCompanionBuilder,
    $$ItensHistoricoTableUpdateCompanionBuilder,
    (
      ItemHistoricoRow,
      BaseReferences<_$AppDatabase, $ItensHistoricoTable, ItemHistoricoRow>
    ),
    ItemHistoricoRow,
    PrefetchHooks Function()>;
typedef $$ParametrosTableCreateCompanionBuilder = ParametrosCompanion Function({
  Value<int> id,
  Value<double> toleranciaPct,
  Value<double> toleranciaMinKg,
  Value<String> alertaJanela,
  required String pinAdminHash,
});
typedef $$ParametrosTableUpdateCompanionBuilder = ParametrosCompanion Function({
  Value<int> id,
  Value<double> toleranciaPct,
  Value<double> toleranciaMinKg,
  Value<String> alertaJanela,
  Value<String> pinAdminHash,
});

class $$ParametrosTableFilterComposer
    extends Composer<_$AppDatabase, $ParametrosTable> {
  $$ParametrosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get toleranciaPct => $composableBuilder(
      column: $table.toleranciaPct, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get toleranciaMinKg => $composableBuilder(
      column: $table.toleranciaMinKg,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get alertaJanela => $composableBuilder(
      column: $table.alertaJanela, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get pinAdminHash => $composableBuilder(
      column: $table.pinAdminHash, builder: (column) => ColumnFilters(column));
}

class $$ParametrosTableOrderingComposer
    extends Composer<_$AppDatabase, $ParametrosTable> {
  $$ParametrosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get toleranciaPct => $composableBuilder(
      column: $table.toleranciaPct,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get toleranciaMinKg => $composableBuilder(
      column: $table.toleranciaMinKg,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get alertaJanela => $composableBuilder(
      column: $table.alertaJanela,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get pinAdminHash => $composableBuilder(
      column: $table.pinAdminHash,
      builder: (column) => ColumnOrderings(column));
}

class $$ParametrosTableAnnotationComposer
    extends Composer<_$AppDatabase, $ParametrosTable> {
  $$ParametrosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get toleranciaPct => $composableBuilder(
      column: $table.toleranciaPct, builder: (column) => column);

  GeneratedColumn<double> get toleranciaMinKg => $composableBuilder(
      column: $table.toleranciaMinKg, builder: (column) => column);

  GeneratedColumn<String> get alertaJanela => $composableBuilder(
      column: $table.alertaJanela, builder: (column) => column);

  GeneratedColumn<String> get pinAdminHash => $composableBuilder(
      column: $table.pinAdminHash, builder: (column) => column);
}

class $$ParametrosTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ParametrosTable,
    ParametrosRow,
    $$ParametrosTableFilterComposer,
    $$ParametrosTableOrderingComposer,
    $$ParametrosTableAnnotationComposer,
    $$ParametrosTableCreateCompanionBuilder,
    $$ParametrosTableUpdateCompanionBuilder,
    (
      ParametrosRow,
      BaseReferences<_$AppDatabase, $ParametrosTable, ParametrosRow>
    ),
    ParametrosRow,
    PrefetchHooks Function()> {
  $$ParametrosTableTableManager(_$AppDatabase db, $ParametrosTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ParametrosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ParametrosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ParametrosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<double> toleranciaPct = const Value.absent(),
            Value<double> toleranciaMinKg = const Value.absent(),
            Value<String> alertaJanela = const Value.absent(),
            Value<String> pinAdminHash = const Value.absent(),
          }) =>
              ParametrosCompanion(
            id: id,
            toleranciaPct: toleranciaPct,
            toleranciaMinKg: toleranciaMinKg,
            alertaJanela: alertaJanela,
            pinAdminHash: pinAdminHash,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<double> toleranciaPct = const Value.absent(),
            Value<double> toleranciaMinKg = const Value.absent(),
            Value<String> alertaJanela = const Value.absent(),
            required String pinAdminHash,
          }) =>
              ParametrosCompanion.insert(
            id: id,
            toleranciaPct: toleranciaPct,
            toleranciaMinKg: toleranciaMinKg,
            alertaJanela: alertaJanela,
            pinAdminHash: pinAdminHash,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ParametrosTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ParametrosTable,
    ParametrosRow,
    $$ParametrosTableFilterComposer,
    $$ParametrosTableOrderingComposer,
    $$ParametrosTableAnnotationComposer,
    $$ParametrosTableCreateCompanionBuilder,
    $$ParametrosTableUpdateCompanionBuilder,
    (
      ParametrosRow,
      BaseReferences<_$AppDatabase, $ParametrosTable, ParametrosRow>
    ),
    ParametrosRow,
    PrefetchHooks Function()>;
typedef $$ConsumoEsperadoTableCreateCompanionBuilder = ConsumoEsperadoCompanion
    Function({
  required String materialCodigo,
  required double consumoDiarioKg,
  Value<int> rowid,
});
typedef $$ConsumoEsperadoTableUpdateCompanionBuilder = ConsumoEsperadoCompanion
    Function({
  Value<String> materialCodigo,
  Value<double> consumoDiarioKg,
  Value<int> rowid,
});

class $$ConsumoEsperadoTableFilterComposer
    extends Composer<_$AppDatabase, $ConsumoEsperadoTable> {
  $$ConsumoEsperadoTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get materialCodigo => $composableBuilder(
      column: $table.materialCodigo,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get consumoDiarioKg => $composableBuilder(
      column: $table.consumoDiarioKg,
      builder: (column) => ColumnFilters(column));
}

class $$ConsumoEsperadoTableOrderingComposer
    extends Composer<_$AppDatabase, $ConsumoEsperadoTable> {
  $$ConsumoEsperadoTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get materialCodigo => $composableBuilder(
      column: $table.materialCodigo,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get consumoDiarioKg => $composableBuilder(
      column: $table.consumoDiarioKg,
      builder: (column) => ColumnOrderings(column));
}

class $$ConsumoEsperadoTableAnnotationComposer
    extends Composer<_$AppDatabase, $ConsumoEsperadoTable> {
  $$ConsumoEsperadoTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get materialCodigo => $composableBuilder(
      column: $table.materialCodigo, builder: (column) => column);

  GeneratedColumn<double> get consumoDiarioKg => $composableBuilder(
      column: $table.consumoDiarioKg, builder: (column) => column);
}

class $$ConsumoEsperadoTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ConsumoEsperadoTable,
    ConsumoEsperadoRow,
    $$ConsumoEsperadoTableFilterComposer,
    $$ConsumoEsperadoTableOrderingComposer,
    $$ConsumoEsperadoTableAnnotationComposer,
    $$ConsumoEsperadoTableCreateCompanionBuilder,
    $$ConsumoEsperadoTableUpdateCompanionBuilder,
    (
      ConsumoEsperadoRow,
      BaseReferences<_$AppDatabase, $ConsumoEsperadoTable, ConsumoEsperadoRow>
    ),
    ConsumoEsperadoRow,
    PrefetchHooks Function()> {
  $$ConsumoEsperadoTableTableManager(
      _$AppDatabase db, $ConsumoEsperadoTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ConsumoEsperadoTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ConsumoEsperadoTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ConsumoEsperadoTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> materialCodigo = const Value.absent(),
            Value<double> consumoDiarioKg = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ConsumoEsperadoCompanion(
            materialCodigo: materialCodigo,
            consumoDiarioKg: consumoDiarioKg,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String materialCodigo,
            required double consumoDiarioKg,
            Value<int> rowid = const Value.absent(),
          }) =>
              ConsumoEsperadoCompanion.insert(
            materialCodigo: materialCodigo,
            consumoDiarioKg: consumoDiarioKg,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ConsumoEsperadoTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ConsumoEsperadoTable,
    ConsumoEsperadoRow,
    $$ConsumoEsperadoTableFilterComposer,
    $$ConsumoEsperadoTableOrderingComposer,
    $$ConsumoEsperadoTableAnnotationComposer,
    $$ConsumoEsperadoTableCreateCompanionBuilder,
    $$ConsumoEsperadoTableUpdateCompanionBuilder,
    (
      ConsumoEsperadoRow,
      BaseReferences<_$AppDatabase, $ConsumoEsperadoTable, ConsumoEsperadoRow>
    ),
    ConsumoEsperadoRow,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$MateriaisTableTableManager get materiais =>
      $$MateriaisTableTableManager(_db, _db.materiais);
  $$FornecedoresTableTableManager get fornecedores =>
      $$FornecedoresTableTableManager(_db, _db.fornecedores);
  $$EstoqueReferenciaTableTableManager get estoqueReferencia =>
      $$EstoqueReferenciaTableTableManager(_db, _db.estoqueReferencia);
  $$SessoesTableTableManager get sessoes =>
      $$SessoesTableTableManager(_db, _db.sessoes);
  $$ItensContagemTableTableManager get itensContagem =>
      $$ItensContagemTableTableManager(_db, _db.itensContagem);
  $$NotasRecebimentoTableTableManager get notasRecebimento =>
      $$NotasRecebimentoTableTableManager(_db, _db.notasRecebimento);
  $$ExportsTableTableManager get exports =>
      $$ExportsTableTableManager(_db, _db.exports);
  $$ItensHistoricoTableTableManager get itensHistorico =>
      $$ItensHistoricoTableTableManager(_db, _db.itensHistorico);
  $$ParametrosTableTableManager get parametros =>
      $$ParametrosTableTableManager(_db, _db.parametros);
  $$ConsumoEsperadoTableTableManager get consumoEsperado =>
      $$ConsumoEsperadoTableTableManager(_db, _db.consumoEsperado);
}
