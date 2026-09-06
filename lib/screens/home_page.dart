import 'package:flutter/material.dart';

import '../models/item.dart';
import '../services/ab_test_service.dart';
import '../services/storage_service.dart';
import 'add_item_page.dart';
import 'categories_page.dart';
import 'list_page.dart';
import 'settings_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  final List<Item> items = [];

  String? versaoAb;

  @override
  void initState() {
    super.initState();
    _inicializar();
  }

  Future<void> _inicializar() async {
    await _carregarItens();

    final versao = await AbTestService.obterVersao();

    if (!mounted) return;

    setState(() {
      versaoAb = versao;
    });
  }

  Future<void> _carregarItens() async {
    final itensSalvos = await StorageService.carregarItens();

    if (!mounted) return;

    setState(() {
      items.clear();
      items.addAll(itensSalvos);
    });
  }

  Future<void> _adicionarItem(Item item) async {
    setState(() {
      items.add(item);
    });

    await StorageService.salvarItens(items);
  }

  Future<void> _alternarComprado(int index, bool comprado) async {
    setState(() {
      items[index].comprado = comprado;
    });

    await StorageService.salvarItens(items);
  }

  Future<void> _excluirItem(int index) async {
    setState(() {
      items.removeAt(index);
    });

    await StorageService.salvarItens(items);
  }

  Future<void> _limparLista() async {
    setState(() {
      items.clear();
    });

    await StorageService.salvarItens(items);
  }

  Future<void> _abrirCategoriasPelaHome() async {
    await AbTestService.registrarAcessoHome();

    if (!mounted) return;

    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CategoriesPage(items: items)),
    );

    if (mounted) {
      setState(() {});
    }
  }

  void _selecionarAbaVersaoA(int index) {
    if (index == 2) {
      AbTestService.registrarAcessoNavegacao();
    }

    setState(() {
      selectedIndex = index;
    });
  }

  void _selecionarAbaVersaoB(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (versaoAb == null) {
      return const Scaffold(
        backgroundColor: Color(0xFFFAF9F6),
        body: Center(
          child: CircularProgressIndicator(color: Color(0xFFFFCC3E)),
        ),
      );
    }

    final bool versaoA = versaoAb == 'A';

    if (versaoA) {
      return _buildVersaoA();
    }

    return _buildVersaoB();
  }

  Widget _buildVersaoA() {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF9F6),
      body: IndexedStack(
        index: selectedIndex,
        children: [
          SafeArea(
            bottom: false,
            child: HomeContent(
              items: items,
              onItemAdicionado: _adicionarItem,
              onAbrirCategorias: _abrirCategoriasPelaHome,
            ),
          ),
          ListPage(
            items: items,
            onToggleComprado: _alternarComprado,
            onExcluirItem: _excluirItem,
          ),
          CategoriesPage(items: items),
          SettingsPage(onLimparLista: _limparLista),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        height: 76,
        backgroundColor: Colors.white,
        indicatorColor: const Color(0xFFFFF1C7),
        selectedIndex: selectedIndex,
        onDestinationSelected: _selecionarAbaVersaoA,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Início',
          ),
          NavigationDestination(
            icon: Icon(Icons.checklist_outlined),
            selectedIcon: Icon(Icons.checklist),
            label: 'Lista',
          ),
          NavigationDestination(
            icon: Icon(Icons.grid_view_outlined),
            selectedIcon: Icon(Icons.grid_view),
            label: 'Categorias',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label: 'Configurações',
          ),
        ],
      ),
    );
  }

  Widget _buildVersaoB() {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF9F6),
      body: IndexedStack(
        index: selectedIndex,
        children: [
          SafeArea(
            bottom: false,
            child: HomeContent(
              items: items,
              onItemAdicionado: _adicionarItem,
              onAbrirCategorias: _abrirCategoriasPelaHome,
            ),
          ),
          ListPage(
            items: items,
            onToggleComprado: _alternarComprado,
            onExcluirItem: _excluirItem,
          ),
          SettingsPage(onLimparLista: _limparLista),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        height: 76,
        backgroundColor: Colors.white,
        indicatorColor: const Color(0xFFFFF1C7),
        selectedIndex: selectedIndex,
        onDestinationSelected: _selecionarAbaVersaoB,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Início',
          ),
          NavigationDestination(
            icon: Icon(Icons.checklist_outlined),
            selectedIcon: Icon(Icons.checklist),
            label: 'Lista',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label: 'Configurações',
          ),
        ],
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  final List<Item> items;

  final Future<void> Function(Item item) onItemAdicionado;

  final Future<void> Function() onAbrirCategorias;

  const HomeContent({
    super.key,
    required this.items,
    required this.onItemAdicionado,
    required this.onAbrirCategorias,
  });

  double get totalEstimado {
    return items.fold(0.0, (total, item) => total + item.total);
  }

  int get itensComprados {
    return items.where((item) => item.comprado).length;
  }

  int _quantidadeCategoria(String categoria) {
    return items.where((item) => item.categoria == categoria).length;
  }

  String _formatarPreco(double valor) {
    return valor.toStringAsFixed(2).replaceAll('.', ',');
  }

  Future<void> _abrirAdicionarItem(BuildContext context) async {
    final item = await Navigator.push<Item>(
      context,
      MaterialPageRoute(builder: (context) => const AddItemPage()),
    );

    if (item != null) {
      await onItemAdicionado(item);
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool compact = constraints.maxWidth < 600;

        return SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(
            compact ? 22 : 40,
            24,
            compact ? 22 : 40,
            30,
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1000),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Olá, Mô! 👋',
                              style: TextStyle(
                                fontSize: compact ? 16 : 18,
                                color: const Color(0xFF6F7480),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              'Minha Listinha',
                              style: TextStyle(
                                fontSize: compact ? 30 : 38,
                                height: 1.05,
                                fontWeight: FontWeight.w900,
                                letterSpacing: -1.2,
                                color: const Color(0xFF17191D),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Organize suas compras de forma simples\ne prática.',
                              style: TextStyle(
                                fontSize: compact ? 14 : 16,
                                height: 1.4,
                                color: const Color(0xFF777D89),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        width: compact ? 58 : 70,
                        height: compact ? 58 : 70,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFCC3E),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.08),
                              blurRadius: 15,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            'M',
                            style: TextStyle(
                              fontSize: compact ? 23 : 28,
                              fontWeight: FontWeight.w900,
                              color: const Color(0xFF17191D),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 28),
                  _buildTotalCard(compact),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Categorias',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF17191D),
                        ),
                      ),
                      TextButton.icon(
                        onPressed: onAbrirCategorias,
                        icon: const Icon(Icons.arrow_forward, size: 17),
                        label: const Text(
                          'Ver todas',
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                        style: TextButton.styleFrom(
                          foregroundColor: const Color(0xFF737987),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: _categoryCard(
                          icon: Icons.shopping_cart_outlined,
                          title: 'Compras',
                          count: '${_quantidadeCategoria('Compras')} itens',
                          background: const Color(0xFFFFF5D6),
                          iconBackground: const Color(0xFFFFD65A),
                          onTap: onAbrirCategorias,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _categoryCard(
                          icon: Icons.apple,
                          title: 'Hortifruti',
                          count: '${_quantidadeCategoria('Hortifruti')} itens',
                          background: const Color(0xFFEAF7E9),
                          iconBackground: const Color(0xFFBDE9B8),
                          onTap: onAbrirCategorias,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: _categoryCard(
                          icon: Icons.cleaning_services_outlined,
                          title: 'Limpeza',
                          count: '${_quantidadeCategoria('Limpeza')} itens',
                          background: const Color(0xFFEAF3FF),
                          iconBackground: const Color(0xFFC8E1FF),
                          onTap: onAbrirCategorias,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _categoryCard(
                          icon: Icons.home_outlined,
                          title: 'Casa',
                          count: '${_quantidadeCategoria('Casa')} itens',
                          background: const Color(0xFFF2EBFF),
                          iconBackground: const Color(0xFFDCCAFF),
                          onTap: onAbrirCategorias,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    'Minha lista',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF17191D),
                    ),
                  ),
                  const SizedBox(height: 13),
                  if (items.isEmpty)
                    _buildEstadoVazio(context)
                  else
                    _buildListaItens(context),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTotalCard(bool compact) {
    final progresso = items.isEmpty ? 0.0 : itensComprados / items.length;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(compact ? 22 : 28),
      decoration: BoxDecoration(
        color: const Color(0xFF20242C),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.12),
            blurRadius: 25,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFCC3E),
                  borderRadius: BorderRadius.circular(13),
                ),
                child: const Icon(
                  Icons.account_balance_wallet_outlined,
                  color: Color(0xFF17191D),
                  size: 22,
                ),
              ),
              const SizedBox(width: 13),
              const Expanded(
                child: Text(
                  'TOTAL ESTIMADO',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.09),
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.shopping_cart_outlined,
                      size: 16,
                      color: Colors.white70,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      '${items.length} itens',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 17),
          Text(
            'R\$ ${_formatarPreco(totalEstimado)}',
            style: TextStyle(
              color: Colors.white,
              fontSize: compact ? 38 : 46,
              fontWeight: FontWeight.w900,
              letterSpacing: -1,
            ),
          ),
          const SizedBox(height: 20),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: progresso,
              minHeight: 9,
              backgroundColor: Colors.white.withValues(alpha: 0.12),
              valueColor: const AlwaysStoppedAnimation<Color>(
                Color(0xFFFFCC3E),
              ),
            ),
          ),
          const SizedBox(height: 11),
          Text(
            items.isEmpty
                ? 'Nenhum item comprado ainda'
                : '$itensComprados de ${items.length} itens comprados',
            style: const TextStyle(color: Colors.white60, fontSize: 13),
          ),
        ],
      ),
    );
  }

  Widget _buildEstadoVazio(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: const Color(0xFFE8E7E4)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.035),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 86,
            height: 86,
            decoration: BoxDecoration(
              color: const Color(0xFFFFF5D6),
              borderRadius: BorderRadius.circular(28),
            ),
            child: const Center(
              child: Icon(
                Icons.shopping_bag_outlined,
                size: 43,
                color: Color(0xFFF2B900),
              ),
            ),
          ),
          const SizedBox(height: 18),
          const Text(
            'Sua listinha está vazia',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              color: Color(0xFF17191D),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Adicione produtos para começar\nsuas compras.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              height: 1.5,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 20),
          FilledButton.icon(
            onPressed: () => _abrirAdicionarItem(context),
            icon: const Icon(Icons.add),
            label: const Text('Adicionar primeiro item'),
            style: FilledButton.styleFrom(
              backgroundColor: const Color(0xFFFFCC3E),
              foregroundColor: const Color(0xFF17191D),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              textStyle: const TextStyle(fontWeight: FontWeight.w800),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListaItens(BuildContext context) {
    return Column(
      children: [
        ...items.map(
          (item) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFE8E7E4)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 46,
                    height: 46,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF5D6),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Icon(
                      Icons.shopping_bag_outlined,
                      color: Color(0xFFF2B900),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.nome,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w900,
                            color: const Color(0xFF17191D),
                            decoration: item.comprado
                                ? TextDecoration.lineThrough
                                : null,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${item.categoria} • ${item.quantidade} un.',
                          style: const TextStyle(
                            fontSize: 13,
                            color: Color(0xFF777D89),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    'R\$ ${_formatarPreco(item.total)}',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF17191D),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 4),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () => _abrirAdicionarItem(context),
            icon: const Icon(Icons.add),
            label: const Text('Adicionar outro item'),
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFF17191D),
              side: const BorderSide(color: Color(0xFFFFCC3E)),
              padding: const EdgeInsets.symmetric(vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _categoryCard({
    required IconData icon,
    required String title,
    required String count,
    required Color background,
    required Color iconBackground,
    required Future<void> Function() onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(22),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: background,
            borderRadius: BorderRadius.circular(22),
          ),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: iconBackground,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: const Color(0xFF30343B), size: 25),
              ),
              const SizedBox(width: 11),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF202329),
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      count,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.chevron_right,
                color: Color(0xFF737780),
                size: 21,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
