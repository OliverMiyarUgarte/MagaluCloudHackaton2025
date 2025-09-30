import 'package:flutter/material.dart';
import 'package:hackaton_magalu_2025/pages/user.dart';
import 'main_page.dart';
import 'profile_page.dart';
import 'add_friend_page.dart';
import 'dragons_page.dart';

class HomeAfterLoginPage extends StatefulWidget {
  final User loggedUser;

  const HomeAfterLoginPage({super.key, required this.loggedUser});

  @override
  State<HomeAfterLoginPage> createState() => _HomeAfterLoginPageState();
}

class _HomeAfterLoginPageState extends State<HomeAfterLoginPage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final pages = [
      const MainPage(),
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
                  onTap: () async {
                    // Buscar dragões do usuário (função deve ser implementada para puxar do banco real)
                    final dragons = await fetchUserDragons(widget.loggedUser.id);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ProfilePage(
                          userName: widget.loggedUser.username,
                          email: widget.loggedUser.email,
                          dragons: dragons,
                        ),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: CircleAvatar(
                      radius: 24,
                      child: Text(
                        widget.loggedUser.username[0].toUpperCase(),
                        style: const TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Colors.deepPurpleAccent,
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

  // Função de exemplo para buscar dragões do usuário
  Future<List<Dragon>> fetchUserDragons(int userId) async {
    // Aqui você implementa a consulta real no banco ou via API
    return [
      Dragon(name: 'Draco', level: 5, color: 'Vermelho', type: 'Fogo', power: 100),
      Dragon(name: 'Aqua', level: 3, color: 'Azul', type: 'Água', power: 80),
    ];
  }
}
