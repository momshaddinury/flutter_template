part of 'navigation_service.dart';

Map<String, Widget Function(BuildContext)> appRoutes = {
  RoutesV2.splash: (context) => const BottomNavBarExample(),
  RoutesV2.login: (context) => const LoginPage(),
  RoutesV2.home: (context) => const HomePage(),
  RoutesV2.bottomNavBar: (context) => const BottomNavBarExample(),
  RoutesV2.profileList: (context) => ProfileListPage(),
  RoutesV2.profileDetails: (context) => const ProfileDetailsPage(),
};
