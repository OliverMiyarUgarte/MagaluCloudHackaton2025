import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  final String userName;
  final int streak;
  final double? totalHours;

  const MainPage({
    super.key,
    required this.userName,
    required this.streak,
    this.totalHours,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Bem-vindo, $userName!',
            style: const TextStyle(
              color: Color(0xFF708B75), // da paleta
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Card(
            color: const Color(0xFF2B303A).withOpacity(0.8), // da paleta
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  _buildInfoRow('Streak', '$streak dias'),
                  if (totalHours != null)
                    _buildInfoRow('Horas Estudadas', '${totalHours!.toStringAsFixed(1)} h'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: const Color(0xFFFFDBDA).withOpacity(0.8))),
          Text(value,
              style: const TextStyle(color: Color(0xFF7F7CAF), fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
