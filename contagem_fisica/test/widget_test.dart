import 'package:contagem_fisica/domain/models.dart';
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
  });
}