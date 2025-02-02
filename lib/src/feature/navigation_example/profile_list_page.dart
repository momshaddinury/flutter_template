import 'package:flutter/material.dart';
import 'package:flutter_template/src/core/service/navigation/navigation_service.dart';

class ProfileListPage extends StatelessWidget {
  ProfileListPage({super.key});

  final List<String> profiles = [
    'John Doe',
    'Jane Smith',
    'Alice Johnson',
    'Bob Brown',
    'Charlie Davis',
    'Diana Evans',
    'Evan Foster',
    'Fiona Green',
    'George Harris',
    'Hannah Ingram',
    'Ian Jackson',
    'Julia King',
    'Kevin Lewis',
    'Laura Martinez',
    'Michael Nelson',
    'Nina Owens',
    'Oscar Perez',
    'Paula Quinn',
    'Quincy Roberts',
    'Rachel Scott',
    'Samuel Thompson',
    'Tina Underwood',
    'Ulysses Vance',
    'Victoria White',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile List'),
      ),
      body: ListView.builder(
        itemCount: profiles.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(profiles[index]),
            onTap: () {
              Navigator.pushNamed(context, RoutesV2.profileDetails);
            },
          );
        },
      ),
    );
  }
}
