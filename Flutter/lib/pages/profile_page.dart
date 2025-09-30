import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final String userName;
  final String email;
  final List<Dragon> dragons;

  const ProfilePage({
    super.key,
    required this.userName,
    required this.email,
    required this.dragons,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil de $userName'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(userName,
                style: const TextStyle(
                    fontSize: 28, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(email, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 24),
            const Text('Dragões do Usuário',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: dragons.length,
                itemBuilder: (context, index) {
                  final dragon = dragons[index];
                  return Card(
                    child: ListTile(
                      title: Text(dragon.name),
                      subtitle: Text(
                          'Nível: ${dragon.level}, Tipo: ${dragon.type}, Cor: ${dragon.color}, Poder: ${dragon.power}'),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Dragon {
  final String name;
  final int level;
  final String color;
  final String type;
  final int power;

  Dragon({
    required this.name,
    required this.level,
    required this.color,
    required this.type,
    required this.power,
  });
}
