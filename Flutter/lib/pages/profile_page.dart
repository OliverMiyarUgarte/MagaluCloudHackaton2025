import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final String userName;
  final String email;
  final int level;
  final int dragonsOwned;
  final int streak;

  const ProfilePage({
    super.key,
    required this.userName,
    required this.email,
    required this.level,
    required this.dragonsOwned,
    required this.streak,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil de $userName'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage: const AssetImage('assets/user_photo.png'),
            ),
            const SizedBox(height: 24),
            Text(userName,
                style: const TextStyle(
                    color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(email, style: const TextStyle(color: Colors.white70, fontSize: 16)),
            const SizedBox(height: 24),
            Card(
              color: Colors.deepPurpleAccent.withOpacity(0.2),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    _buildInfoRow('Nível', '$level'),
                    _buildInfoRow('Dragões Possuídos', '$dragonsOwned'),
                    _buildInfoRow('Streak', '$streak dias'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.white70)),
          Text(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
