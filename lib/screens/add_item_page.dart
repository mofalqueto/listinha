import 'package:flutter/material.dart';
import '../models/item.dart';

class AddItemPage extends StatefulWidget {
  const AddItemPage({super.key});

  @override
  State<AddItemPage> createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage> {
  String selectedCategory = 'Compras';

  final TextEditingController nomeController = TextEditingController();
  final TextEditingController quantidadeController =
      TextEditingController(text: '1');
  final TextEditingController precoController = TextEditingController();

  @override
  void dispose() {
    nomeController.dispose();
    quantidadeController.dispose();
    precoController.dispose();
    super.dispose();
  }

  void _adicionarItem() {
    final nome = nomeController.text.trim();

    final quantidade = int.tryParse(
          quantidadeController.text.trim(),
        ) ??
        1;

    final precoTexto = precoController.text
        .trim()
        .replaceAll('R\$', '')
        .replaceAll('.', '')
        .replaceAll(',', '.');

    final preco = double.tryParse(precoTexto) ?? 0.0;

    if (nome.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Digite o nome do produto.'),
        ),
      );
      return;
    }

    final item = Item(
      nome: nome,
      categoria: selectedCategory,
      quantidade: quantidade,
      preco: preco,
    );

    Navigator.pop(context, item);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF9F6),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFAF9F6),
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Adicionar item',
          style: TextStyle(
            fontWeight: FontWeight.w900,
            color: Color(0xFF17191D),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(22, 10, 22, 30),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 650,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Novo produto',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -1,
                    color: Color(0xFF17191D),
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Adicione as informações do item à sua listinha.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF777D89),
                  ),
                ),
                const SizedBox(height: 28),
                _label('Nome do produto'),
                const SizedBox(height: 8),
                TextField(
                  controller: nomeController,
                  decoration: _inputDecoration(
                    hint: 'Ex.: Arroz',
                    icon: Icons.shopping_bag_outlined,
                  ),
                ),
                const SizedBox(height: 22),
                _label('Categoria'),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    _categoryOption('Compras'),
                    _categoryOption('Hortifruti'),
                    _categoryOption('Limpeza'),
                    _categoryOption('Casa'),
                  ],
                ),
                const SizedBox(height: 22),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _label('Quantidade'),
                          const SizedBox(height: 8),
                          TextField(
                            controller: quantidadeController,
                            keyboardType: TextInputType.number,
                            decoration: _inputDecoration(
                              hint: '1',
                              icon: Icons.numbers,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _label('Preço'),
                          const SizedBox(height: 8),
                          TextField(
                            controller: precoController,
                            keyboardType:
                                const TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                            decoration: _inputDecoration(
                              hint: 'R\$ 0,00',
                              icon: Icons.attach_money,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: FilledButton.icon(
                    onPressed: _adicionarItem,
                    icon: const Icon(Icons.add),
                    label: const Text(
                      'Adicionar à listinha',
                    ),
                    style: FilledButton.styleFrom(
                      backgroundColor: const Color(0xFFFFCC3E),
                      foregroundColor: const Color(0xFF17191D),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(17),
                      ),
                      textStyle: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _label(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w800,
        color: Color(0xFF34373D),
      ),
    );
  }

  InputDecoration _inputDecoration({
    required String hint,
    required IconData icon,
  }) {
    return InputDecoration(
      hintText: hint,
      prefixIcon: Icon(icon),
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(17),
        borderSide: const BorderSide(
          color: Color(0xFFE7E5E1),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(17),
        borderSide: const BorderSide(
          color: Color(0xFFE7E5E1),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(17),
        borderSide: const BorderSide(
          color: Color(0xFFFFCC3E),
          width: 2,
        ),
      ),
    );
  }

  Widget _categoryOption(String category) {
    final selected = selectedCategory == category;

    return ChoiceChip(
      label: Text(category),
      selected: selected,
      onSelected: (_) {
        setState(() {
          selectedCategory = category;
        });
      },
      selectedColor: const Color(0xFFFFE79A),
      backgroundColor: Colors.white,
      labelStyle: TextStyle(
        fontWeight: FontWeight.w700,
        color: selected
            ? const Color(0xFF17191D)
            : const Color(0xFF646A73),
      ),
      side: BorderSide(
        color: selected
            ? const Color(0xFFFFCC3E)
            : const Color(0xFFE7E5E1),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
    );
  }
}