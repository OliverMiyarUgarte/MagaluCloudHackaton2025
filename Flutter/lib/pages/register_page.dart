import 'package:flutter/material.dart';
import 'home_after_login_page.dart';
import 'api_service.dart';
import 'user.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  bool _loading = false;

  void _register() async {
    setState(() => _loading = true);

    try {
      // Chama API para registrar usuário
      final User loggedUser = await ApiService.register(
        _emailController.text,
        _passwordController.text,
        _usernameController.text,
      );

      if (!mounted) return;

      // Navega para HomeAfterLoginPage com o usuário logado
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => HomeAfterLoginPage(
            loggedUser: loggedUser,
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro ao cadastrar: $e")),
      );
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 300,
                child: TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Nome de usuário',
                    labelStyle: TextStyle(color: const Color(0xFFFFDBDA)),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: const Color(0xFF7F7CAF)),
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: 300,
                child: TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Email',
                    labelStyle: TextStyle(color: const Color(0xFFFFDBDA)),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: const Color(0xFF7F7CAF)),
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: 300,
                child: TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Senha',
                    labelStyle: TextStyle(color: const Color(0xFFFFDBDA)),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: const Color(0xFF7F7CAF)),
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: 300,
                child: ElevatedButton(
                  onPressed: _loading ? null : _register,
                  child: _loading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text('Cadastrar', style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
