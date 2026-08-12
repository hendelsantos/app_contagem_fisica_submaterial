import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class ChangelogEntry {
  final String versao;
  final List<String> mudancas;
  const ChangelogEntry(this.versao, this.mudancas);
}

List<ChangelogEntry> _changelogVazio = [];

class SobrePage extends StatefulWidget {
  const SobrePage({super.key});

  @override
  State<SobrePage> createState() => _SobrePageState();
}

class _SobrePageState extends State<SobrePage> {
  List<ChangelogEntry> _changelog = _changelogVazio;
  String _versaoAtual = 'ver Releases';
  bool _carregando = true;

  @override
  void initState() {
    super.initState();
    _carregarChangelog();
  }

  Future<void> _carregarChangelog() async {
    try {
      final txt = await rootBundle.loadString('CHANGELOG.md');
      final entries = _parseChangelog(txt);
      if (!mounted) return;
      setState(() {
        _changelog = entries;
        _versaoAtual = entries.isEmpty ? 'ver Releases' : entries.first.versao;
        _carregando = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() => _carregando = false);
    }
  }

  List<ChangelogEntry> _parseChangelog(String txt) {
    final lines = txt.split('\n');
    final out = <ChangelogEntry>[];
    String? versao;
    final mudancas = <String>[];
    for (final raw in lines) {
      final line = raw.trimRight();
      if (line.startsWith('## ')) {
        if (versao != null) out.add(ChangelogEntry(versao, List.of(mudancas)));
        versao = line.substring(3).trim();
        mudancas.clear();
      } else if (line.startsWith('- ')) {
        mudancas.add(line.substring(2).trim());
      }
    }
    if (versao != null) out.add(ChangelogEntry(versao, List.of(mudancas)));
    return out;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sobre o app')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _topo(),
          _secao('O que é este app', _sobreOApp()),
          _secao('Fluxo diário de uso', _fluxoDiario()),
          _secao('Ponderamento automático do estoque', _ponderamento()),
          _secao('Materiais e unidades', _materiais()),
          _secao('Regras anti-erro (validações automáticas)', _regras()),
          _secao('Status de cada material', _statusList()),
          _secao('Exportação para Excel e Streamlit', _export()),
          _secao('Privacidade e dados', _privacidade()),
          _secao('Histórico de versões', _changelogWidget()),
          _rodape(),
        ],
      ),
    );
  }

  Widget _topo() {
    return Card(
      color: const Color(0xFF1565C0),
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Contagem Física HMB',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'App de contagem física de submateriais (offline)\n'
              'Versão: $_versaoAtual · Desenvolvido por Hendel Santos',
              style: const TextStyle(color: Colors.white70, fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }

  Widget _changelogWidget() {
    if (_carregando) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Center(
            child: SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(strokeWidth: 2))),
      );
    }
    if (_changelog.isEmpty) {
      return _paragrafo(
          'Histórico de versões não disponível nesta compilação.');
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final e in _changelog) ...[
          Container(
            margin: const EdgeInsets.only(bottom: 4, top: 6),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFF1565C0),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              e.versao,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 13),
            ),
          ),
          _lista(e.mudancas),
          const SizedBox(height: 6),
        ],
      ],
    );
  }

  Widget _secao(String titulo, Widget conteudo) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              titulo,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0D47A1)),
            ),
            const SizedBox(height: 8),
            conteudo,
          ],
        ),
      ),
    );
  }

  Widget _paragrafo(String texto) => Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(texto, style: const TextStyle(fontSize: 14)));

  Widget _lista(List<String> itens) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final it in itens)
          Padding(
            padding: const EdgeInsets.only(bottom: 4, left: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('• ', style: TextStyle(fontSize: 14)),
                Expanded(child: Text(it, style: const TextStyle(fontSize: 14))),
              ],
            ),
          ),
      ],
    );
  }

  Widget _sobreOApp() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _paragrafo(
          'Este app substitui a planilha de papel usada pelos operadores na '
          'contagem física mensal/diária dos submateriais da pintura (Henkel, '
          'PPG, Shinsung, Wax e Axalta). Ele funciona 100% offline no celular '
          'Android, gera um arquivo Excel compatível com o Streamlit HMB e '
          'ainda produz um PDF de auditoria com fotos e justificativas.',
        ),
        _paragrafo(
          'O objetivo principal é eliminar erros de copia/cola e divergências '
          'sem rastreabilidade — todo item bloqueado só pode ser destravado '
          'com justificativa escrita e foto anexada.',
        ),
      ],
    );
  }

  Widget _fluxoDiario() {
    return _lista(const [
      '1. Ao abrir o app, o operador informa nome, matrícula e período da contagem.',
      '2. Vai para a Home. Cada fornecedor é um card mostrando o progresso do dia.',
      '3. Toca num fornecedor → lista de materiais daquele fornecedor.',
      '4. Em cada material, digita: estoque contado no dia e recebimento total do período.',
      '5. Se houve recebimento, anexa as NFs/GRs (número + quantidade). A soma precisa bater.',
      '6. Se aparecer divergência, anexa justificativa + foto da etiqueta/tambor.',
      '7. Ao concluir todos os materiais, abre Resumo → Exportar → gera Excel + PDF.',
      '8. Compartilha o Excel com a coordination/Streamlit e está pronto o dia.',
    ]);
  }

  Widget _ponderamento() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _paragrafo(
          'O app "lembra" do saldo final de cada material. Na contagem do dia '
          'seguinte, o campo "Estoque anterior" é preenchido automaticamente '
          'com o último saldo válido — o operador não precisa digitar de novo.',
        ),
        const SizedBox(height: 4),
        _lista(const [
          '1ª contagem (linha de base): o campo "Estoque anterior" fica editável. '
              'Digite o saldo inicial (em Kg ou L, conforme o material).',
          '2ª contagem em diante: o campo fica somente leitura, mostrando "Última '
              'contagem em dd/MM/aaaa HH:mm" — é o saldo de ontem.',
          'O consumo do dia é calculado automaticamente: '
              'consumo = (estoque anterior + recebimento) − estoque contado.',
          'Se o contado for MAIOR que o anterior + recebimento, o app bloqueia '
              'pedindo justificativa + foto (aumento sem recebimento).',
          'Isto garante o encadeamento dia a dia sem perder o fio da meada.',
        ]),
      ],
    );
  }

  Widget _materiais() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _paragrafo(
          'O app vem com 29 materiais cadastrados em 5 fornecedores. As unidades '
          'são fixas por material (o operador não pode alterar, evitando troca '
          'indevida de Kg por L):',
        ),
        _lista(const [
          'Henkel (Pré-tratamento) — unidade Kg',
          'PPG (E-coat + Aditivos) — unidade Kg',
          'Shinsung (PVC) — unidade Kg',
          'Wax (Cavity Wax) — unidade Kg',
          'Axalta (Primer, Basecoat, Clearcoat, Solvente) — unidade L (litros)',
        ]),
      ],
    );
  }

  Widget _regras() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _paragrafo(
            'O app aplica automaticamente as seguintes validações anti-erro:'),
        _lista(const [
          'Estoque contado não pode ser negativo.',
          'Recebimento não pode ser negativo.',
          'Quantidade de NF/GR não pode ser negativa.',
          'Recebimento > 0 exige ao menos uma NF/GR cadastrada.',
          'Soma das NFs/GRs precisa bater com o recebimento total (tolerância 0,01).',
          'Aumento de estoque sem recebimento: tolera até 2% do estoque anterior '
              'ou no mínimo 1 Kg/L. Acima disso, bloqueia e exige justificativa por escrito (foto opcional).',
          'Consumo fisicamente impossível (negativo) também exige justificativa (foto opcional).',
        ]),
      ],
    );
  }

  Widget _statusList() {
    const status = [
      (
        'Pendente',
        'Material ainda não foi contado nesta sessão.',
        Color(0xFFFFA000)
      ),
      (
        'Válido',
        'Contagem dentro do esperado. Sem divergências.',
        Color(0xFF2E7D32)
      ),
      (
        'Alerta',
        'Há divergência justificada com observação (foto opcional). Para auditoria.',
        Color(0xFFFFA000)
      ),
      (
        'Justificado',
        'Divergência com justificativa válida aceita pelo app.',
        Color(0xFF1565C0)
      ),
      (
        'Bloqueado',
        'Há erro não justificado. Exportação proibida.',
        Color(0xFFC62828)
      ),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final (nome, desc, cor) in status)
          Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 14,
                  height: 14,
                  margin: const EdgeInsets.only(top: 3, right: 8),
                  decoration: BoxDecoration(color: cor, shape: BoxShape.circle),
                ),
                Expanded(
                    child: Text('$nome — $desc',
                        style: const TextStyle(fontSize: 14))),
              ],
            ),
          ),
      ],
    );
  }

  Widget _export() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _paragrafo(
          'Na tela de Exportar, o operador gera um arquivo .xlsx e um PDF de '
          'auditoria. O Excel tem uma aba por fornecedor ("Estoque Henkel", '
          '"Estoque PPG", "Estoque Shinsung", "Estoque Wax", "Estoque Axalta") '
          'e uma aba extra "Auditoria App" com fotos, justificativas e NFs.',
        ),
        _paragrafo(
          'No Streamlit HMB, o operador (ou coordenador) entra na página "Stock '
          'Operador", escolhe o período da contagem e faz upload do .xlsx. O '
          'Streamlit cruza com BOM, Paint Out e SAP e mostra o fechamento com '
          'divergências. Importante: o período no Streamlit precisa cobrir as '
          'datas preenchidas no setup do app.',
        ),
      ],
    );
  }

  Widget _privacidade() {
    return _lista(const [
      'O app funciona 100% offline. Nenhum dado sai do aparelho a não ser que '
          'o operador compartilhe manualmente o Excel/PDF.',
      'O banco SQLite fica em /data/data/br.com.hmb.contagem_fisica/files.',
      'As fotos ficam na pasta do app — não são enviadas para nenhum servidor.',
      'Nomes, matrícula e notas fiscais são guardados apenas para auditoria.',
      'O histórico de sessões e o saldo de referência ficam no aparelho. Limpar '
          'dados do app (configurações Android) apaga tudo.',
    ]);
  }

  Widget _rodape() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 24),
      child: Center(
        child: Text(
          'Feito por Hendel Santos · Contagem Física HMB',
          style: TextStyle(fontSize: 12, color: Color(0xFF9E9E9E)),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
