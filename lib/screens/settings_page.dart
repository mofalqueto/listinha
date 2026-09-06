import 'package:flutter/material.dart';

import 'ab_test_result_page.dart';

class SettingsPage extends StatelessWidget {
  final VoidCallback onLimparLista;

  const SettingsPage({super.key, required this.onLimparLista});

  void _confirmarLimpeza(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Limpar listinha?',
            style: TextStyle(fontWeight: FontWeight.w900),
          ),
          content: const Text('Todos os itens serão removidos da sua lista.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancelar'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pop(context);
                onLimparLista();

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Listinha limpa com sucesso.')),
                );
              },
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFFFFCC3E),
                foregroundColor: const Color(0xFF17191D),
              ),
              child: const Text(
                'Limpar',
                style: TextStyle(fontWeight: FontWeight.w800),
              ),
            ),
          ],
        );
      },
    );
  }

  void _abrirResultadoAb(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AbTestResultPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF9F6),
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(22, 24, 22, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Configurações',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -1,
                  color: Color(0xFF17191D),
                ),
              ),

              const SizedBox(height: 6),

              const Text(
                'Ajuste sua experiência no Listinha.',
                style: TextStyle(fontSize: 14, color: Color(0xFF777D89)),
              ),

              const SizedBox(height: 28),

              // =========================
              // MINHA CONTA
              // =========================
              _buildSectionTitle('Minha conta'),

              const SizedBox(height: 10),

              _buildCard(
                child: Row(
                  children: [
                    Container(
                      width: 52,
                      height: 52,
                      decoration: const BoxDecoration(
                        color: Color(0xFFFFCC3E),
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Text(
                          'M',
                          style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFF17191D),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 14),

                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Mô',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w900,
                              color: Color(0xFF17191D),
                            ),
                          ),
                          SizedBox(height: 3),
                          Text(
                            'Minha Listinha',
                            style: TextStyle(
                              fontSize: 13,
                              color: Color(0xFF777D89),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const Icon(
                      Icons.shopping_bag_outlined,
                      color: Color(0xFF777D89),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 26),

              // =========================
              // PREFERÊNCIAS
              // =========================
              _buildSectionTitle('Preferências'),

              const SizedBox(height: 10),

              _buildCard(
                child: Column(
                  children: [
                    _buildOption(
                      icon: Icons.notifications_none_rounded,
                      title: 'Lembretes',
                      subtitle: 'Em breve você poderá ativar lembretes.',
                      trailing: const Icon(
                        Icons.chevron_right,
                        color: Color(0xFF9A9DA5),
                      ),
                    ),

                    const Divider(height: 26, color: Color(0xFFEAE9E6)),

                    _buildOption(
                      icon: Icons.palette_outlined,
                      title: 'Aparência',
                      subtitle: 'Tema claro do Listinha',
                      trailing: const Icon(
                        Icons.chevron_right,
                        color: Color(0xFF9A9DA5),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 26),

              // =========================
              // EXPERIMENTO A/B
              // =========================
              _buildSectionTitle('Experimento'),

              const SizedBox(height: 10),

              _buildCard(
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () {
                    _abrirResultadoAb(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      children: [
                        Container(
                          width: 46,
                          height: 46,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF2EBFF),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: const Icon(
                            Icons.science_outlined,
                            color: Color(0xFF7656A8),
                          ),
                        ),

                        const SizedBox(width: 14),

                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Resultado do teste A/B',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w900,
                                  color: Color(0xFF17191D),
                                ),
                              ),
                              SizedBox(height: 3),
                              Text(
                                'Veja a versão e os acessos registrados',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Color(0xFF777D89),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const Icon(
                          Icons.chevron_right,
                          color: Color(0xFF7656A8),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 26),

              // =========================
              // DADOS
              // =========================
              _buildSectionTitle('Dados'),

              const SizedBox(height: 10),

              _buildCard(
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () {
                    _confirmarLimpeza(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      children: [
                        Container(
                          width: 42,
                          height: 42,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFEAEA),
                            borderRadius: BorderRadius.circular(13),
                          ),
                          child: const Icon(
                            Icons.delete_outline,
                            color: Color(0xFFB95555),
                          ),
                        ),

                        const SizedBox(width: 14),

                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Limpar listinha',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w900,
                                  color: Color(0xFFB95555),
                                ),
                              ),
                              SizedBox(height: 3),
                              Text(
                                'Remove todos os itens salvos',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Color(0xFF777D89),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const Icon(
                          Icons.chevron_right,
                          color: Color(0xFFB95555),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 38),

              // =========================
              // RODAPÉ
              // =========================
              const Center(
                child: Column(
                  children: [
                    Text(
                      'Listinha',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF17191D),
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Pra não esquecer nada. 💛',
                      style: TextStyle(fontSize: 13, color: Color(0xFF777D89)),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Versão 1.0.0',
                      style: TextStyle(fontSize: 12, color: Color(0xFFA0A3AA)),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w900,
        color: Color(0xFF17191D),
      ),
    );
  }

  Widget _buildCard({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFFE8E7E4)),
      ),
      child: child,
    );
  }

  Widget _buildOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required Widget trailing,
  }) {
    return Row(
      children: [
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: const Color(0xFFFFF5D6),
            borderRadius: BorderRadius.circular(13),
          ),
          child: Icon(icon, color: const Color(0xFFB98B00)),
        ),

        const SizedBox(width: 14),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF17191D),
                ),
              ),
              const SizedBox(height: 3),
              Text(
                subtitle,
                style: const TextStyle(fontSize: 13, color: Color(0xFF777D89)),
              ),
            ],
          ),
        ),

        trailing,
      ],
    );
  }
}
