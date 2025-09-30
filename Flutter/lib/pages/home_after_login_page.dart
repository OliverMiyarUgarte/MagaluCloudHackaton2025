import 'package:flutter/material.dart';
import 'package:hackaton_magalu_2025/pages/main_page.dart';
import 'package:hackaton_magalu_2025/pages/profile_page.dart';
import 'package:hackaton_magalu_2025/pages/group_page.dart';
import 'package:hackaton_magalu_2025/pages/dragons_page.dart';
import 'package:hackaton_magalu_2025/pages/user.dart';
import 'package:hackaton_magalu_2025/pages/dragao.dart'; // sua classe Dragon

class HomeAfterLoginPage extends StatefulWidget {
  final User loggedUser;

  const HomeAfterLoginPage({super.key, required this.loggedUser});

  @override
  State<HomeAfterLoginPage> createState() => _HomeAfterLoginPageState();
}

class _HomeAfterLoginPageState extends State<HomeAfterLoginPage> {
  int selectedIndex = 0;
  double totalHoursStudied = 42.5; // exemplo
  int streak = 3; // exemplo

  @override
  Widget build(BuildContext context) {
    final pages = [
      MainPage(),
      GroupPage(loggedUser: widget.loggedUser),
      DragonsPage(),
    ];

    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: selectedIndex,
            onDestinationSelected: (index) => setState(() => selectedIndex = index),
            backgroundColor: const Color(0xFF2B303A),
            labelType: NavigationRailLabelType.all,
            leading: GestureDetector(
              onTap: () async {
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
                  backgroundColor: Colors.deepPurpleAccent,
                  child: Text(
                    widget.loggedUser.username[0].toUpperCase(),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.book, color: Colors.white),
                label: Text('Estudar Agora', style: TextStyle(color: Colors.white)),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.group_add, color: Colors.white),
                label: Text('Grupos', style: TextStyle(color: Colors.white)),
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

  // Exemplo de função que retorna dragões do usuário
  Future<List<Dragon>> fetchUserDragons(int userId) async {
    // Aqui você implementa consulta via API real
    return [
      Dragon(name: 'Draco', level: 5, color: 'Vermelho', type: 'Fogo', power: 100),
      Dragon(name: 'Aqua', level: 3, color: 'Azul', type: 'Água', power: 80),
    ];
  }
}
