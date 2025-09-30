import 'package:flutter/material.dart';
import 'home_after_login_page.dart';
import 'api_service.dart';
import 'user.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  bool _loading = false;

  void _toggleForm() {
    setState(() => isLogin = !isLogin);
  }

  void _submit() async {
    setState(() => _loading = true);

    try {
      User loggedUser;
      if (isLogin) {
        loggedUser = await ApiService.login(
          _emailController.text,
          _passwordController.text,
        );
      } else {
        loggedUser = await ApiService.register(
          _emailController.text,
          _passwordController.text,
          _usernameController.text,
        );
      }

      if (!mounted) return;

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
        SnackBar(content: Text("Erro: $e")),
      );
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Left form panel
          Expanded(
            flex: 4,
            child: Container(
              color: const Color(0xFF1E1E2C),
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        isLogin ? 'Bem-vindo de volta!' : 'Crie sua conta',
                        style: const TextStyle(
                          color: Color(0xFFFFDBDA),
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 32),
                      if (!isLogin)
                        TextField(
                          controller: _usernameController,
                          decoration: InputDecoration(
                            labelText: 'Nome de usuário',
                            labelStyle: const TextStyle(color: Color(0xFFFFDBDA)),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: const Color(0xFF7F7CAF)),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          style: const TextStyle(color: Colors.white),
                        ),
                      if (!isLogin) const SizedBox(height: 16),
                      TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: const TextStyle(color: Color(0xFFFFDBDA)),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: const Color(0xFF7F7CAF)),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        style: const TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Senha',
                          labelStyle: const TextStyle(color: Color(0xFFFFDBDA)),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: const Color(0xFF7F7CAF)),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        style: const TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 32),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: _loading ? null : _submit,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFFA560),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: _loading
                              ? const CircularProgressIndicator(color: Colors.white)
                              : Text(
                                  isLogin ? 'Login' : 'Cadastrar',
                                  style: const TextStyle(color: Colors.white, fontSize: 18),
                                ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextButton(
                        onPressed: _toggleForm,
                        child: Text(
                          isLogin ? 'Não tem conta? Cadastre-se' : 'Já tem conta? Faça login',
                          style: const TextStyle(color: Color(0xFFFFDBDA)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // Right image panel
          Expanded(
            flex: 6,
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/Sprites/tela_de_fundo.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
