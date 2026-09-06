import 'package:flutter/material.dart';

import '../models/item.dart';

class ListPage extends StatelessWidget {
  final List<Item> items;
  final void Function(int index, bool comprado) onToggleComprado;
  final void Function(int index) onExcluirItem;

  const ListPage({
    super.key,
    required this.items,
    required this.onToggleComprado,
    required this.onExcluirItem,
  });

  String _formatarPreco(double valor) {
    return valor.toStringAsFixed(2).replaceAll('.', ',');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF9F6),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(22, 24, 22, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Minha lista',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -1,
                  color: Color(0xFF17191D),
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Marque os itens conforme for comprando.',
                style: TextStyle(fontSize: 14, color: Color(0xFF777D89)),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: items.isEmpty
                    ? _buildEstadoVazio()
                    : ListView.separated(
                        itemCount: items.length,
                        separatorBuilder: (_, _) => const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final item = items[index];

                          return Container(
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: const Color(0xFFE8E7E4),
                              ),
                            ),
                            child: Row(
                              children: [
                                Checkbox(
                                  value: item.comprado,
                                  activeColor: const Color(0xFFFFCC3E),
                                  checkColor: const Color(0xFF17191D),
                                  onChanged: (value) {
                                    onToggleComprado(index, value ?? false);
                                  },
                                ),
                                const SizedBox(width: 8),
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
                                    IconButton(
                                      onPressed: () {
                                        onExcluirItem(index);
                                      },
                                      tooltip: 'Excluir item',
                                      icon: const Icon(
                                        Icons.delete_outline,
                                        color: Color(0xFFB95555),
                                      ),
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
              Icons.checklist_rounded,
              size: 46,
              color: Color(0xFFF2B900),
            ),
          ),
          const SizedBox(height: 18),
          const Text(
            'Nenhum item na lista',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              color: Color(0xFF17191D),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Adicione produtos pela tela inicial.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: Color(0xFF777D89)),
          ),
        ],
      ),
    );
  }
}
