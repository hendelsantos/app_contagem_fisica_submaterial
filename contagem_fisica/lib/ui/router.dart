import 'package:contagem_fisica/providers/sessao_provider.dart';
import 'package:contagem_fisica/ui/export_page.dart';
import 'package:contagem_fisica/ui/fornecedor_page.dart';
import 'package:contagem_fisica/ui/home_page.dart';
import 'package:contagem_fisica/ui/material_page.dart';
import 'package:contagem_fisica/ui/resumo_page.dart';
import 'package:contagem_fisica/ui/setup_operador_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final sessao = ref.watch(sessaoAtualProvider);
  final temSessao = sessao.valueOrNull != null;

  return GoRouter(
    initialLocation: '/',
    redirect: (context, state) {
      final emSetup = state.matchedLocation == '/';
      final emHome = state.matchedLocation == '/home';
      if (!temSessao && (emHome || state.matchedLocation.startsWith('/fornecedor') ||
          state.matchedLocation.startsWith('/material') ||
          state.matchedLocation == '/resumo' || state.matchedLocation == '/export')) {
        return '/';
      }
      if (temSessao && emSetup && !emHome) {
        return '/home';
      }
      return null;
    },
    routes: [
      GoRoute(path: '/', builder: (c, s) => const SetupOperadorPage()),
      GoRoute(path: '/home', builder: (c, s) => const HomePage()),
      GoRoute(
        path: '/fornecedor/:nome',
        builder: (c, s) => FornecedorPage(s.pathParameters['nome']!),
      ),
      GoRoute(
        path: '/material/:codigo',
        builder: (c, s) => MaterialPage(s.pathParameters['codigo']!),
      ),
      GoRoute(path: '/resumo', builder: (c, s) => const ResumoPage()),
      GoRoute(path: '/export', builder: (c, s) => const ExportPage()),
    ],
  );
});