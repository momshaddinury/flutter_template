part of '../theme_data.dart';

class _BottomNavigationBarThemeData with ThemeExtensions {
  BottomNavigationBarThemeData call() {
    return BottomNavigationBarThemeData(
      elevation: .5,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: color.bottomNavbar.selectedItem,
      unselectedItemColor: color.bottomNavbar.unselectedItem,
      selectedLabelStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      unselectedLabelStyle: const TextStyle(fontSize: 12),
    );
  }
}
