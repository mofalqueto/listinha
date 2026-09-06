class Item {
  final String nome;
  final String categoria;
  final int quantidade;
  final double preco;
  bool comprado;

  Item({
    required this.nome,
    required this.categoria,
    required this.quantidade,
    required this.preco,
    this.comprado = false,
  });

  double get total {
    return quantidade * preco;
  }
}
