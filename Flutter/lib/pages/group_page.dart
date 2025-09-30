import 'package:flutter/material.dart';
import 'grupo_service.dart';
import 'grupo.dart';
import 'user.dart';

class GroupPage extends StatefulWidget {
  final User loggedUser;

  const GroupPage({super.key, required this.loggedUser});

  @override
  State<GroupPage> createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _newGroupController = TextEditingController();

  List<Grupo> _allGroups = [];
  List<Grupo> _filteredGroups = [];
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _fetchGroups();
  }

  Future<void> _fetchGroups() async {
    setState(() => _loading = true);
    try {
      final groups = await GrupoService.getGrupos();
      setState(() {
        _allGroups = groups;
        _filteredGroups = groups;
      });
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Erro ao buscar grupos: $e')));
    } finally {
      setState(() => _loading = false);
    }
  }

  void _searchGroups(String query) {
    final filtered = _allGroups
        .where((g) => g.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
    setState(() => _filteredGroups = filtered);
  }

  Future<void> _createGroup() async {
    final name = _newGroupController.text.trim();
    if (name.isEmpty) return;

    setState(() => _loading = true);
    try {
      final newGroup = await GrupoService.createGrupo(
        Grupo(
          id: 0,
          nuser: widget.loggedUser.id, // ⚠️ usa o usuário logado
          name: name,
        ),
      );
      _newGroupController.clear();
      await _fetchGroups();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Grupo "${newGroup.name}" criado com sucesso!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Erro ao criar grupo: $e')));
    } finally {
      setState(() => _loading = false);
    }
  }

  Future<void> _joinGroup(Grupo grupo) async {
    try {
      await GrupoService.joinGrupo(widget.loggedUser.id, grupo.id);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Você entrou no grupo "${grupo.name}"')),
      );
      await _fetchGroups();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao entrar no grupo: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Grupos')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Criar grupo
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _newGroupController,
                    decoration: const InputDecoration(
                      labelText: 'Novo grupo',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _loading ? null : _createGroup,
                  child: const Text('Criar'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Buscar grupo
            TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                labelText: 'Pesquisar grupo',
                border: OutlineInputBorder(),
              ),
              onChanged: _searchGroups,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: _loading
                  ? const Center(child: CircularProgressIndicator())
                  : _filteredGroups.isEmpty
                      ? const Center(
                          child: Text(
                          'Nenhum grupo encontrado',
                          style: TextStyle(color: Colors.white),
                        ))
                      : ListView.builder(
                          itemCount: _filteredGroups.length,
                          itemBuilder: (_, index) {
                            final group = _filteredGroups[index];
                            return Card(
                              color: const Color(0xFF2B303A),
                              child: ListTile(
                                title: Text(group.name,
                                    style: const TextStyle(color: Colors.white)),
                                subtitle: Text('Membros: ${group.nuser}',
                                    style: const TextStyle(color: Colors.grey)),
                                trailing: ElevatedButton(
                                  onPressed: () => _joinGroup(group),
                                  child: const Text('Entrar'),
                                ),
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
