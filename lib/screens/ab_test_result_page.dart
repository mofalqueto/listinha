import 'package:flutter/material.dart';

class AbTestResultPage extends StatelessWidget {
  const AbTestResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    // DADOS SIMULADOS PARA DEMONSTRAÇÃO ACADÊMICA
    const usuariosA = 20;
    const usuariosB = 20;

    const acessosA = 82;
    const acessosB = 46;

    const mediaA = acessosA / usuariosA;
    const mediaB = acessosB / usuariosB;

    final diferencaPercentual = ((mediaA - mediaB) / mediaB) * 100;

    return Scaffold(
      backgroundColor: const Color(0xFFFAF9F6),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFAF9F6),
        surfaceTintColor: Colors.transparent,
        title: const Text(
          'Resultado do teste A/B',
          style: TextStyle(
            fontWeight: FontWeight.w900,
            color: Color(0xFF17191D),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(22, 18, 22, 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // =========================
            // AVISO
            // =========================

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF5D6),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFFFE7A0)),
              ),
              child: const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.info_outline, color: Color(0xFFB98B00)),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Dados simulados para fins de demonstração acadêmica.',
                      style: TextStyle(
                        fontSize: 13,
                        height: 1.4,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF6C5815),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 26),

            // =========================
            // OBJETIVO
            // =========================
            const Text(
              'Objetivo do experimento',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.w900,
                color: Color(0xFF17191D),
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              'Verificar se manter a funcionalidade Categorias '
              'visível na barra inferior aumenta a utilização '
              'dessa área do aplicativo.',
              style: TextStyle(
                fontSize: 14,
                height: 1.5,
                color: Color(0xFF666B75),
              ),
            ),

            const SizedBox(height: 28),

            // =========================
            // VERSÃO A
            // =========================
            _buildVersionCard(
              titulo: 'Versão A',
              subtitulo: 'Categorias disponível na Home e na barra inferior',
              icone: Icons.space_dashboard_outlined,
              fundo: const Color(0xFFFFF5D6),
              destaque: const Color(0xFFFFCC3E),
              usuarios: usuariosA,
              acessos: acessosA,
              media: mediaA,
            ),

            const SizedBox(height: 16),

            // =========================
            // VERSÃO B
            // =========================
            _buildVersionCard(
              titulo: 'Versão B',
              subtitulo: 'Categorias disponível apenas pela Home',
              icone: Icons.home_outlined,
              fundo: const Color(0xFFEAF3FF),
              destaque: const Color(0xFFC8E1FF),
              usuarios: usuariosB,
              acessos: acessosB,
              media: mediaB,
            ),

            const SizedBox(height: 30),

            // =========================
            // COMPARAÇÃO
            // =========================
            const Text(
              'Comparação A × B',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.w900,
                color: Color(0xFF17191D),
              ),
            ),

            const SizedBox(height: 14),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: const Color(0xFFE8E7E4)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildBarraComparacao(
                    label: 'Versão A',
                    valor: acessosA.toDouble(),
                    maiorValor: acessosA.toDouble(),
                    texto: '$acessosA acessos',
                    cor: const Color(0xFFFFCC3E),
                  ),

                  const SizedBox(height: 20),

                  _buildBarraComparacao(
                    label: 'Versão B',
                    valor: acessosB.toDouble(),
                    maiorValor: acessosA.toDouble(),
                    texto: '$acessosB acessos',
                    cor: const Color(0xFFBFDFFF),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // =========================
            // RESULTADO PRINCIPAL
            // =========================
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: const Color(0xFF20242C),
                borderRadius: BorderRadius.circular(26),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.analytics_outlined, color: Color(0xFFFFCC3E)),
                      SizedBox(width: 10),
                      Text(
                        'Resultado',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 18),

                  Text(
                    '+${diferencaPercentual.toStringAsFixed(0)}%',
                    style: const TextStyle(
                      fontSize: 42,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFFFFCC3E),
                    ),
                  ),

                  const SizedBox(height: 4),

                  const Text(
                    'mais acessos por usuário na versão A',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 16),

                  const Text(
                    'Nos dados simulados, usuários da versão A '
                    'acessaram a seção Categorias com maior frequência. '
                    'Isso sugere que a presença da funcionalidade na '
                    'barra de navegação inferior pode aumentar sua '
                    'visibilidade e utilização.',
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.5,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            // =========================
            // PERGUNTA DO EXPERIMENTO
            // =========================
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: const Color(0xFFF2EBFF),
                borderRadius: BorderRadius.circular(22),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.science_outlined, color: Color(0xFF7656A8)),
                      SizedBox(width: 10),
                      Text(
                        'Pergunta do experimento',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF17191D),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 12),

                  Text(
                    'A presença da funcionalidade Categorias '
                    'na barra de navegação inferior aumenta sua '
                    'utilização pelos usuários?',
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.5,
                      color: Color(0xFF555A64),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVersionCard({
    required String titulo,
    required String subtitulo,
    required IconData icone,
    required Color fundo,
    required Color destaque,
    required int usuarios,
    required int acessos,
    required double media,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: fundo,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: destaque,
                  shape: BoxShape.circle,
                ),
                child: Icon(icone, color: const Color(0xFF30343B)),
              ),

              const SizedBox(width: 14),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      titulo,
                      style: const TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF17191D),
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      subtitulo,
                      style: const TextStyle(
                        fontSize: 13,
                        height: 1.4,
                        color: Color(0xFF666B75),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 22),

          Row(
            children: [
              Expanded(
                child: _buildMetric(titulo: 'Usuários', valor: '$usuarios'),
              ),
              Expanded(
                child: _buildMetric(titulo: 'Acessos', valor: '$acessos'),
              ),
              Expanded(
                child: _buildMetric(
                  titulo: 'Média',
                  valor: media.toStringAsFixed(1),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetric({required String titulo, required String valor}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          titulo,
          style: const TextStyle(fontSize: 12, color: Color(0xFF777D89)),
        ),
        const SizedBox(height: 5),
        Text(
          valor,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w900,
            color: Color(0xFF17191D),
          ),
        ),
      ],
    );
  }

  Widget _buildBarraComparacao({
    required String label,
    required double valor,
    required double maiorValor,
    required String texto,
    required Color cor,
  }) {
    final proporcao = valor / maiorValor;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF17191D),
                ),
              ),
            ),
            Text(
              texto,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: Color(0xFF666B75),
              ),
            ),
          ],
        ),

        const SizedBox(height: 9),

        LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              children: [
                Container(
                  height: 16,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0F0EE),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),

                AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  height: 16,
                  width: constraints.maxWidth * proporcao,
                  decoration: BoxDecoration(
                    color: cor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
