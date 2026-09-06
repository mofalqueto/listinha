import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/item.dart';

class StorageService {
  static const String _chaveItens = 'itens_listinha';

  static Future<void> salvarItens(List<Item> items) async {
    final prefs = await SharedPreferences.getInstance();

    final listaJson = items.map((item) {
      return {
        'nome': item.nome,
        'categoria': item.categoria,
        'quantidade': item.quantidade,
        'preco': item.preco,
        'comprado': item.comprado,
      };
    }).toList();

    final jsonString = jsonEncode(listaJson);

    await prefs.setString(_chaveItens, jsonString);
  }

  static Future<List<Item>> carregarItens() async {
    final prefs = await SharedPreferences.getInstance();

    final jsonString = prefs.getString(_chaveItens);

    if (jsonString == null || jsonString.isEmpty) {
      return [];
    }

    final listaDecodificada = jsonDecode(jsonString) as List;

    return listaDecodificada.map((itemJson) {
      return Item(
        nome: itemJson['nome'],
        categoria: itemJson['categoria'],
        quantidade: itemJson['quantidade'],
        preco: (itemJson['preco'] as num).toDouble(),
        comprado: itemJson['comprado'] ?? false,
      );
    }).toList();
  }
}