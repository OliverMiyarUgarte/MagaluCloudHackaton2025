import 'package:flutter/material.dart';

class HomeAfterLoginPage extends StatefulWidget {
  const HomeAfterLoginPage({super.key});

  @override
  State<HomeAfterLoginPage> createState() => _HomeAfterLoginPageState();
}

class _HomeAfterLoginPageState extends State<HomeAfterLoginPage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    String userName = 'Ian';
    int dragonLevel = 5;
    int dragonXP = 120;
    int dragonMaxXP = 200;
    int dragonHealth = 80;
    int streak = 3;

    final pages = [
      _buildMainPage(userName, dragonLevel, dragonXP, dragonMaxXP, dragonHealth, streak),
      _buildProfilePage(userName),
    ];

    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: selectedIndex,
            onDestinationSelected: (index) => setState(() => selectedIndex = index),
            backgroundColor: Colors.deepPurple.withOpacity(0.2),
            labelType: NavigationRailLabelType.all,
            leading: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: CircleAvatar(
                radius: 24,
                backgroundImage: const AssetImage('assets/user_photo.png'), // substitua pelo caminho da sua imagem
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
                icon: Icon(Icons.leaderboard, color: Colors.white),
                label: Text('Ranking', style: TextStyle(color: Colors.white)),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.person, color: Colors.white),
                label: Text('Perfil', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
          const VerticalDivider(thickness: 1, width: 1),
          Expanded(child: pages[selectedIndex]),
        ],
      ),
    );
  }

  Widget _buildMainPage(String userName, int dragonLevel, int dragonXP, int dragonMaxXP, int dragonHealth, int streak) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          SizedBox(
            height: 180,
            child: Image.network(
                'https://i.gifer.com/7VE.gif',
                fit: BoxFit.contain),
          ),
          const SizedBox(height: 24),
          Card(
            color: Colors.deepPurpleAccent.withOpacity(0.2),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text('Dragão de $userName',
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  const SizedBox(height: 16),
                  _buildMetric('Nível', '$dragonLevel'),
                  _buildMetric('XP', '$dragonXP / $dragonMaxXP'),
                  _buildMetric('Saúde', '$dragonHealth%'),
                  _buildMetric('Streak', '$streak dias'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Align(
            alignment: Alignment.centerLeft,
            child: Text('Seu Grupo Atual',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    )),
          ),
          const SizedBox(height: 16),
          _groupCard('Estudantes Supremos', 5),
        ],
      ),
    );
  }

  Widget _buildProfilePage(String userName) {
    return Center(
      child: Text('Perfil de $userName',
          style: const TextStyle(color: Colors.white, fontSize: 24)),
    );
  }

  Widget _buildMetric(String name, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(name, style: const TextStyle(color: Colors.white)),
          Text(value,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _groupCard(String groupName, int members) {
    return Card(
      color: Colors.purpleAccent.withOpacity(0.2),
      child: ListTile(
        title: Text(groupName, style: const TextStyle(color: Colors.white)),
        subtitle: Text('$members membros',
            style: const TextStyle(color: Colors.white70)),
        trailing: const Icon(Icons.arrow_forward, color: Colors.white),
        onTap: () {},
      ),
    );
  }
}
