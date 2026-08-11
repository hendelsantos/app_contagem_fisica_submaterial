import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'ui/router.dart';

class ContagemFisicaApp extends ConsumerWidget {
  const ContagemFisicaApp({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final router = ref.watch(routerProvider);
    return MaterialApp.router(
      title: 'Contagem Física HMB',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1565C0)),
      ),
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}