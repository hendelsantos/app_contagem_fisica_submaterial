import 'package:contagem_fisica/domain/parametros.dart';
import 'package:contagem_fisica/providers/database_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final parametrosProvider = FutureProvider<ParametrosGlobais>((ref) async {
  final db = ref.watch(databaseProvider);
  try {
    final r = await db.obterParametros();
    return ParametrosGlobais(
      toleranciaPct: r.toleranciaPct,
      toleranciaMinKg: r.toleranciaMinKg,
      alertaJanela: r.alertaJanela,
      pinAdminHash: r.pinAdminHash,
    );
  } catch (_) {
    return ParametrosGlobais.padrao();
  }
});
