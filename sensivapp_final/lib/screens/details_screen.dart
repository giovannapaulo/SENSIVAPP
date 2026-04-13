import 'package:flutter/material.dart';
import '../model/course.dart';
import '../../widgets/theme_toggle_button.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Object? args = ModalRoute.of(context)?.settings.arguments;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final course = (args is Course)
        ? args
        : Course(title: "Detalhes", color: const Color(0xFF7553F6));

    bool isAudioType = course.title.toLowerCase().contains("ruído") ||
        course.icon == Icons.volume_up;

    final Color primaryColor = course.color;
    final Color headerColor =
        isDark ? primaryColor : primaryColor.withValues(alpha: 0.15);
    final Color contentColor = isDark ? Colors.white : primaryColor;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: isDark ? const Color(0xFF121212) : Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,
              color: isDark ? Colors.white : primaryColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          course.title,
          style: TextStyle(
              color: isDark ? Colors.white : primaryColor,
              fontWeight: FontWeight.bold),
        ),
        actions: const [ThemeToggleButton(), SizedBox(width: 10)],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeroHeader(course, headerColor, contentColor, isDark),
            _buildBody(isAudioType, course, contentColor, isDark),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroHeader(
      Course course, Color bgColor, Color iconColor, bool isDark) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 40),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(50),
          bottomRight: Radius.circular(50),
        ),
      ),
      child: Hero(
        tag: course.title,
        child: Icon(course.icon,
            size: 100, color: isDark ? Colors.white : iconColor),
      ),
    );
  }

  Widget _buildBody(bool isAudio, Course course, Color color, bool isDark) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Sobre o Monitoramento",
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black87),
          ),
          const SizedBox(height: 12),
          Text(
            isAudio
                ? "Análise e mapeamento de frequências sonoras para identificar picos de estresse e gatilhos sensoriais no ambiente."
                : "Acompanhamento contínuo de ${course.title} para garantir o equilíbrio e bem-estar sensorial do paciente.",
            style: TextStyle(
                fontSize: 16,
                color: isDark ? Colors.white70 : Colors.black54,
                height: 1.5),
          ),
          const SizedBox(height: 35),
          Text(
            "Status Atual",
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black87),
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              _buildSmallStatCard("Frequência", "Diária", color, isDark),
              const SizedBox(width: 15),
              _buildSmallStatCard("Status", "Ativo", Colors.green, isDark),
            ],
          ),
          const SizedBox(height: 30),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: color.withValues(alpha: isDark ? 0.2 : 0.1),
              borderRadius: BorderRadius.circular(25),
              border: Border.all(color: color.withValues(alpha: 0.2)),
            ),
            child: Row(
              children: [
                Icon(isAudio ? Icons.mic : Icons.analytics,
                    color: color, size: 30),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isAudio ? "Iniciar Gravação" : "Ver Relatório Completo",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.white : color,
                            fontSize: 16),
                      ),
                      Text(
                        "Última atualização: Hoje, 14:00",
                        style: TextStyle(
                            color: isDark ? Colors.white60 : Colors.black45,
                            fontSize: 13),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.arrow_forward_ios, color: color, size: 15),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSmallStatCard(
      String label, String value, Color color, bool isDark) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: isDark
              ? Colors.white.withValues(alpha: 0.05)
              : Colors.grey.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: isDark ? Colors.white10 : Colors.black12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label,
                style: const TextStyle(color: Colors.grey, fontSize: 12)),
            const SizedBox(height: 5),
            Text(value,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : color,
                    fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
