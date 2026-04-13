import 'package:flutter/material.dart';
import '../../model/course.dart';
import 'components/course_card.dart';
import 'components/secondary_course_card.dart';
import 'components/custom_bottom_nav.dart';
import '../../widgets/theme_toggle_button.dart';
import '../../core/app_theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final ScrollController _scrollController = ScrollController();

  void _scroll(double offset) {
    _scrollController.animateTo(
      _scrollController.offset + offset,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOutQuart,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final navColor = isDark ? const Color(0xFF7553F6) : AppTheme.pastelPurple;
    final navContentColor = isDark ? Colors.white : AppTheme.textPurpleDark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: _buildAppBar(navColor, navContentColor),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader("Monitoramento"),
            _buildMonitoramentoComSetas(),
            _buildSectionHeader("Tarefas Médicas"),
            _buildTarefasList(),
            const SizedBox(height: 100),
          ],
        ),
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(canvasColor: navColor),
        child: CustomBottomNavBar(
          selectedIndex: _selectedIndex,
          onItemSelected: (index) => setState(() => _selectedIndex = index),
        ),
      ),
    );
  }

  AppBar _buildAppBar(Color bgColor, Color contentColor) {
    return AppBar(
      backgroundColor: bgColor,
      elevation: 0,
      iconTheme: IconThemeData(color: contentColor),
      title: Text(
        "SensivApp",
        style: TextStyle(color: contentColor, fontWeight: FontWeight.bold),
      ),
      actions: [
        const ThemeToggleButton(),
        Padding(
          padding: const EdgeInsets.only(right: 16, left: 8),
          child: CircleAvatar(
            backgroundColor: contentColor.withOpacity(0.2),
            child: Icon(Icons.person, color: contentColor),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 10),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.white
              : Colors.black,
        ),
      ),
    );
  }

  Widget _buildMonitoramentoComSetas() {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          height: 300,
          child: ListView.builder(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: courses.length,
            itemBuilder: (context, index) {
              final course = courses[index];
              return Padding(
                padding: const EdgeInsets.only(right: 20, bottom: 10),
                child: GestureDetector(
                  onTap: () => Navigator.pushNamed(context, '/details',
                      arguments: course),
                  child: CourseCard(
                      title: course.title,
                      icon: course.icon,
                      color: course.color),
                ),
              );
            },
          ),
        ),
        Positioned(
          left: 5,
          child: _navArrow(Icons.chevron_left, () => _scroll(-300)),
        ),
        Positioned(
          right: 5,
          child: _navArrow(Icons.chevron_right, () => _scroll(300)),
        ),
      ],
    );
  }

  Widget _navArrow(IconData icon, VoidCallback onPress) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        shape: BoxShape.circle,
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8)],
      ),
      child: IconButton(
        icon: Icon(icon, color: const Color(0xFF7553F6), size: 30),
        onPressed: onPress,
      ),
    );
  }

  Widget _buildTarefasList() {
    return Column(
      children: recentCourses
          .map((course) => Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                child: SecondaryCourseCard(
                    title: course.title, color: course.color),
              ))
          .toList(),
    );
  }
}
