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
  double totalHoursStudied = 42.5;

  @override
  Widget build(BuildContext context) {
    String userName = 'Ian';
    int streak = 3;

    final pages = [
      MainPage(
        userName: userName,
        streak: streak,
        totalHours: totalHoursStudied,
      ),
      const AddFriendPage(),
      const DragonsPage(),
    ];

    return Scaffold(
      body: Stack(
        children: [
          Row(
            children: [
              NavigationRail(
                selectedIndex: selectedIndex,
                onDestinationSelected: (index) => setState(() => selectedIndex = index),
                backgroundColor: const Color(0xFF2B303A),
                labelType: NavigationRailLabelType.all,
                leading: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ProfilePage(
                          userName: userName,
                          email: 'ian@email.com',
                          level: (totalHoursStudied ~/ 10) + 1,
                          dragonsOwned: 0,
                          streak: streak,
                        ),
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
          // Quadradinho de grama no canto inferior direito
          Positioned(
            bottom: 16,
            right: 16,
            child: Image.asset(
              'assets/Sprites/grama.png',
              width: 50,
              height: 50,
            ),
          ),
        ],
      ),
    );
  }
}
