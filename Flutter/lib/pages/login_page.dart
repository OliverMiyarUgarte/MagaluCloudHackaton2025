import 'package:flutter/material.dart';
import 'home_after_login_page.dart';
import 'api_service.dart'; // Certifique-se de ter ApiService com login funcionando
import 'user.dart'; // Sua classe User

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _loading = false; // Para mostrar progress enquanto chama API

 void _login() async {
  setState(() => _loading = true);

  try {
    final User loggedUser = await ApiService.login(
      _emailController.text,
      _passwordController.text,
    );

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => HomeAfterLoginPage(
          loggedUser: loggedUser, // passa o usuário logado
        ),
      ),
    );
  } catch (e) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Erro ao logar: $e")),
    );
  } finally {
    if (mounted) setState(() => _loading = false);
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
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
                  onPressed: _loading ? null : _login,
                  child: _loading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text('Login', style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
