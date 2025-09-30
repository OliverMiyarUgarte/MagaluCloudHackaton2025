import 'package:flutter/material.dart';
import 'main_page.dart';
import 'profile_page.dart';
import 'add_friend_page.dart';
import 'dragons_page.dart';

class HomeAfterLoginPage extends StatefulWidget {
  const HomeAfterLoginPage({super.key});

  @override
  State<HomeAfterLoginPage> createState() => _HomeAfterLoginPageState();
}

class _HomeAfterLoginPageState extends State<HomeAfterLoginPage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    // Dados do usuário
    String userName = 'Ian';
    int dragonLevel = 5;
    int dragonXP = 120;
    int dragonMaxXP = 200;
    int dragonHealth = 80;
    int streak = 3;

    final pages = [
      MainPage(
        userName: userName,
        dragonLevel: dragonLevel,
        dragonXP: dragonXP,
        dragonMaxXP: dragonMaxXP,
        dragonHealth: dragonHealth,
        streak: streak,
      ),
      const AddFriendPage(),
      const DragonsPage(),
    ];

    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: selectedIndex,
            onDestinationSelected: (index) => setState(() => selectedIndex = index),
            backgroundColor: Colors.deepPurple.withOpacity(0.2),
            labelType: NavigationRailLabelType.all,
            leading: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ProfilePage(userName: userName),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: CircleAvatar(
                  radius: 24,
                  backgroundImage: const AssetImage('assets/user_photo.png'),
                ),
              ),
            ),
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.book, color: Colors.white),
                label: Text('Estudar Agora', style: TextStyle(color: Colors.white)),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.person_add, color: Colors.white),
                label: Text('Adicionar Amigo', style: TextStyle(color: Colors.white)),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.auto_awesome, color: Colors.white),
                label: Text('Dragões', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
          const VerticalDivider(thickness: 1, width: 1),
          Expanded(child: pages[selectedIndex]),
        ],
      ),
    );
  }
}
