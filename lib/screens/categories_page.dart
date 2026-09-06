import 'package:flutter/material.dart';

import '../models/item.dart';

class CategoriesPage extends StatefulWidget {
  final List<Item> items;

  const CategoriesPage({super.key, required this.items});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  String? categoriaSelecionada;

  final List<Map<String, dynamic>> categorias = [
    {
      'nome': 'Compras',
      'icone': Icons.shopping_cart_outlined,
      'fundo': const Color(0xFFFFF5D6),
      'iconeFundo': const Color(0xFFFFD65A),
    },
    {
      'nome': 'Hortifruti',
      'icone': Icons.apple,
      'fundo': const Color(0xFFEAF7E9),
      'iconeFundo': const Color(0xFFBDE9B8),
    },
    {
      'nome': 'Limpeza',
      'icone': Icons.cleaning_services_outlined,
      'fundo': const Color(0xFFEAF3FF),
      'iconeFundo': const Color(0xFFC8E1FF),
    },
    {
      'nome': 'Casa',
      'icone': Icons.home_outlined,
      'fundo': const Color(0xFFF2EBFF),
      'iconeFundo': const Color(0xFFDCCAFF),
    },
  ];

  List<Item> get itensFiltrados {
    if (categoriaSelecionada == null) {
      return widget.items;
    }

    return widget.items
        .where((item) => item.categoria == categoriaSelecionada)
        .toList();
  }

  int _quantidadeCategoria(String categoria) {
    return widget.items.where((item) => item.categoria == categoria).length;
  }

  double _totalCategoria(String categoria) {
    return widget.items
        .where((item) => item.categoria == categoria)
        .fold(0.0, (total, item) => total + item.total);
  }

  String _formatarPreco(double valor) {
    return valor.toStringAsFixed(2).replaceAll('.', ',');
  }

  @override
  Widget build(BuildContext context) {
    final podeVoltar = Navigator.canPop(context);

    return Scaffold(
      backgroundColor: const Color(0xFFFAF9F6),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(22, 18, 22, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (podeVoltar) ...[
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.arrow_back,
                          size: 22,
                          color: Color(0xFF17191D),
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Voltar',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF17191D),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 6),
              ],
              const Text(
                'Categorias',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -1,
                  color: Color(0xFF17191D),
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Veja seus produtos organizados por categoria.',
                style: TextStyle(fontSize: 14, color: Color(0xFF777D89)),
              ),
              const SizedBox(height: 24),
              SizedBox(
                height: 130,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: categorias.length,
                  separatorBuilder: (_, _) => const SizedBox(width: 12),
                  itemBuilder: (context, index) {
                    final categoria = categorias[index];

                    final nome = categoria['nome'] as String;

                    final selecionada = categoriaSelecionada == nome;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          if (selecionada) {
                            categoriaSelecionada = null;
                          } else {
                            categoriaSelecionada = nome;
                          }
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: 180,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: categoria['fundo'] as Color,
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: selecionada
                                ? const Color(0xFF17191D)
                                : Colors.transparent,
                            width: 2,
                          ),
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
                                    color: categoria['iconeFundo'] as Color,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    categoria['icone'] as IconData,
                                    color: const Color(0xFF30343B),
                                  ),
                                ),
                                const Spacer(),
                                if (selecionada)
                                  const Icon(
                                    Icons.check_circle,
                                    color: Color(0xFF17191D),
                                    size: 20,
                                  ),
                              ],
                            ),
                            const Spacer(),
                            Text(
                              nome,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w900,
                                color: Color(0xFF202329),
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              '${_quantidadeCategoria(nome)} itens • R\$ ${_formatarPreco(_totalCategoria(nome))}',
                              style: const TextStyle(
                                fontSize: 12,
                                color: Color(0xFF60646D),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 26),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    categoriaSelecionada == null
                        ? 'Todos os itens'
                        : categoriaSelecionada!,
                    style: const TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF17191D),
                    ),
                  ),
                  if (categoriaSelecionada != null)
                    TextButton(
                      onPressed: () {
                        setState(() {
                          categoriaSelecionada = null;
                        });
                      },
                      child: const Text(
                        'Limpar filtro',
                        style: TextStyle(
                          color: Color(0xFF777D89),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 12),
              Expanded(
                child: itensFiltrados.isEmpty
                    ? _buildEstadoVazio()
                    : ListView.separated(
                        itemCount: itensFiltrados.length,
                        separatorBuilder: (_, _) => const SizedBox(height: 10),
                        itemBuilder: (context, index) {
                          final item = itensFiltrados[index];

                          return Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: const Color(0xFFE8E7E4),
                              ),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                const SizedBox(width: 12),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      'R\$ ${_formatarPreco(item.total)}',
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w900,
                                        color: Color(0xFF17191D),
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Icon(
                                      item.comprado
                                          ? Icons.check_circle
                                          : Icons.radio_button_unchecked,
                                      size: 18,
                                      color: item.comprado
                                          ? const Color(0xFF62A65E)
                                          : const Color(0xFFB4B6BC),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEstadoVazio() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              color: const Color(0xFFFFF5D6),
              borderRadius: BorderRadius.circular(28),
            ),
            child: const Icon(
              Icons.category_outlined,
              size: 45,
              color: Color(0xFFF2B900),
            ),
          ),
          const SizedBox(height: 18),
          const Text(
            'Nenhum item por aqui',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              color: Color(0xFF17191D),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            categoriaSelecionada == null
                ? 'Sua listinha ainda não tem produtos.'
                : 'Não há produtos nesta categoria.',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14, color: Color(0xFF777D89)),
          ),
        ],
      ),
    );
  }
}
