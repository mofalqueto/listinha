import 'dart:math';

import 'package:shared_preferences/shared_preferences.dart';

class AbTestService {
  static const String _chaveVersao = 'ab_test_categorias_versao';
  static const String _chaveAcessosHome =
      'ab_test_categorias_acessos_home';
  static const String _chaveAcessosNavegacao =
      'ab_test_categorias_acessos_navegacao';

  static Future<String> obterVersao() async {
    final prefs = await SharedPreferences.getInstance();

    final versaoSalva = prefs.getString(_chaveVersao);

    if (versaoSalva != null) {
      return versaoSalva;
    }

    final novaVersao = Random().nextBool() ? 'A' : 'B';

    await prefs.setString(_chaveVersao, novaVersao);

    return novaVersao;
  }

  static Future<void> registrarAcessoHome() async {
    final prefs = await SharedPreferences.getInstance();

    final acessos = prefs.getInt(_chaveAcessosHome) ?? 0;

    await prefs.setInt(
      _chaveAcessosHome,
      acessos + 1,
    );
  }

  static Future<void> registrarAcessoNavegacao() async {
    final prefs = await SharedPreferences.getInstance();

    final acessos = prefs.getInt(_chaveAcessosNavegacao) ?? 0;

    await prefs.setInt(
      _chaveAcessosNavegacao,
      acessos + 1,
    );
  }

  static Future<int> obterAcessosHome() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getInt(_chaveAcessosHome) ?? 0;
  }

  static Future<int> obterAcessosNavegacao() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getInt(_chaveAcessosNavegacao) ?? 0;
  }
}