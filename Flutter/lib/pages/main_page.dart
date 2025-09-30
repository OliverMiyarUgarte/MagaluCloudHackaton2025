import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  final String userName;
  final int dragonLevel;
  final int dragonXP;
  final int dragonMaxXP;
  final int dragonHealth;
  final int streak;

  const MainPage({
    super.key,
    required this.userName,
    required this.dragonLevel,
    required this.dragonXP,
    required this.dragonMaxXP,
    required this.dragonHealth,
    required this.streak,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          SizedBox(
            height: 180,
            child: Image.network(
              'https://i.gifer.com/7VE.gif',
              fit: BoxFit.contain,
            ),
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
