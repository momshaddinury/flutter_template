part of '../theme_data.dart';

class _BottomNavigationBarLightThemeData with ThemeExtensions {
  BottomNavigationBarThemeData call() {
    return BottomNavigationBarThemeData(
      elevation: .5,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: lightColor.bottomNavBar.selectedItem,
      unselectedItemColor: lightColor.bottomNavBar.unselectedItem,
      selectedLabelStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      unselectedLabelStyle: const TextStyle(fontSize: 12),
    );
  }
}

class _BottomNavigationBarDarkThemeData with ThemeExtensions {
  BottomNavigationBarThemeData call() {
    return BottomNavigationBarThemeData(
      elevation: .5,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: darkColor.bottomNavBar.selectedItem,
      unselectedItemColor: darkColor.bottomNavBar.unselectedItem,
      selectedLabelStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      unselectedLabelStyle: const TextStyle(fontSize: 12),
    );
  }
}
