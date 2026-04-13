import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;

  const CustomBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final Color bgColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final Color activeIconColor = const Color(0xFF7553F6);
    final Color inActiveIconColor =
        isDark ? Colors.white38 : const Color(0xFFB6B6B6);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: bgColor,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, -1),
            blurRadius: 20,
            color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.05),
          ),
        ],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(
                Icons.home_rounded, 0, activeIconColor, inActiveIconColor),
            _buildNavItem(
                Icons.favorite_rounded, 1, activeIconColor, inActiveIconColor),
            _buildNavItem(Icons.chat_bubble_rounded, 2, activeIconColor,
                inActiveIconColor),
            _buildNavItem(
                Icons.person_rounded, 3, activeIconColor, inActiveIconColor),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(
      IconData icon, int index, Color activeColor, Color inactiveColor) {
    bool isSelected = selectedIndex == index;
    return GestureDetector(
      onTap: () => onItemSelected(index),
      child: AnimatedScale(
        duration: const Duration(milliseconds: 200),
        scale: isSelected ? 1.2 : 1.0,
        child: Icon(
          icon,
          size: 28,
          color: isSelected ? activeColor : inactiveColor,
        ),
      ),
    );
  }
}
