import 'package:contagem_fisica/domain/models.dart';
import 'package:contagem_fisica/domain/parametros.dart';
import 'package:contagem_fisica/domain/validacao.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('validação anti-erro', () {
    test('bloqueia estoque negativo', () {
      final item = ItemContagemDTO(
        id: '1',
        sessaoId: 's',
        materialCodigo: 'c',
        estoqueAnterior: 10,
        estoqueContado: -1,
        recebimentoTotal: 0,
        status: StatusItem.pendente,
        timestamp: DateTime(2026, 8, 11),
      );
      final r = validarItem(item);
      expect(r.ok, isFalse);
      expect(r.bloqueios, contains(TipoBloqueio.estoqueNegativo));
    });

    test('bloqueia aumento sem recebimento sem justificativa', () {
      final item = ItemContagemDTO(
        id: '2',
        sessaoId: 's',
        materialCodigo: 'c',
        estoqueAnterior: 100,
        estoqueContado: 130,
        recebimentoTotal: 0,
        status: StatusItem.pendente,
        timestamp: DateTime(2026, 8, 11),
      );
      final r = validarItem(item);
      expect(r.ok, isFalse);
      expect(r.bloqueios, contains(TipoBloqueio.aumentoSemRecebimento));
      expect(r.aumentoSemRecebimento, closeTo(30, 0.01));
    });

    test('permite aumento com justificativa + foto', () {
      final item = ItemContagemDTO(
        id: '3',
        sessaoId: 's',
        materialCodigo: 'c',
        estoqueAnterior: 100,
        estoqueContado: 130,
        recebimentoTotal: 0,
        justificativa: 'Sobra de limpeza anterior',
        justificativaFotoPath: '/tmp/foto.jpg',
        status: StatusItem.justificado,
        timestamp: DateTime(2026, 8, 11),
      );
      final r = validarItem(item);
      expect(r.ok, isTrue);
      expect(r.avisos, isNotEmpty);
      expect(item.status, StatusItem.justificado);
    });

    test('bloqueia recebimento > 0 sem NF', () {
      final item = ItemContagemDTO(
        id: '4',
        sessaoId: 's',
        materialCodigo: 'c',
        estoqueAnterior: 100,
        estoqueContado: 150,
        recebimentoTotal: 50,
        status: StatusItem.pendente,
        timestamp: DateTime(2026, 8, 11),
      );
      final r = validarItem(item);
      expect(r.bloqueios, contains(TipoBloqueio.semNota));
    });

    test('bloqueia soma de NFs diferente do recebimento', () {
      final item = ItemContagemDTO(
        id: '5',
        sessaoId: 's',
        materialCodigo: 'c',
        estoqueAnterior: 100,
        estoqueContado: 150,
        recebimentoTotal: 50,
        notas: const [NotaRecebimentoDTO(id: 'n1', numero: '100', quantidade: 30)],
        status: StatusItem.pendente,
        timestamp: DateTime(2026, 8, 11),
      );
      final r = validarItem(item);
      expect(r.bloqueios, contains(TipoBloqueio.somaNotasDiferente));
    });

    test('requer justificativa quando aumento sem recebimento', () {
      final item = ItemContagemDTO(
        id: '6',
        sessaoId: 's',
        materialCodigo: 'c',
        estoqueAnterior: 100,
        estoqueContado: 130,
        recebimentoTotal: 0,
        status: StatusItem.pendente,
        timestamp: DateTime(2026, 8, 11),
      );
      expect(requerJustificativa(item), isTrue);
    });

    test('tolerância: aumenta até 2% ou 1 Kg/L (mínimo 1) é permitido', () {
      final item = ItemContagemDTO(
        id: '7',
        sessaoId: 's',
        materialCodigo: 'c',
        estoqueAnterior: 10,
        estoqueContado: 11,
        recebimentoTotal: 0,
        status: StatusItem.pendente,
        timestamp: DateTime(2026, 8, 11),
      );
      final r = validarItem(item);
      expect(r.ok, isTrue);
    });

    test('admin: parâmetros customizados alteram tolerância aplicada', () {
      final params = const ParametrosGlobais(
        toleranciaPct: 0.10,
        toleranciaMinKg: 5.0,
        alertaJanela: 'diaria',
        pinAdminHash: '',
      );
      final item = ItemContagemDTO(
        id: '8',
        sessaoId: 's',
        materialCodigo: 'c',
        estoqueAnterior: 100,
        estoqueContado: 108,
        recebimentoTotal: 0,
        status: StatusItem.pendente,
        timestamp: DateTime(2026, 8, 11),
      );
      expect(validarItem(item, params: params).ok, isTrue,
          reason: '8 de aumento < 10 (10% de 100)');
      final item2 = ItemContagemDTO(
        id: '9',
        sessaoId: 's',
        materialCodigo: 'c',
        estoqueAnterior: 100,
        estoqueContado: 115,
        recebimentoTotal: 0,
        status: StatusItem.pendente,
        timestamp: DateTime(2026, 8, 11),
      );
      expect(validarItem(item2, params: params).ok, isFalse,
          reason: '15 de aumento > 10 (10% de 100)');
    });

    test('hashPin é determinístico e SHA-256', () {
      expect(hashPin('0000'), hashPin('0000'));
      expect(hashPin('0000'), isNot(hashPin('1234')));
      expect(hashPin('0000').length, 64);
    });
  });
}