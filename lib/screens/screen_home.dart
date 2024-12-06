import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widget/personajes.dart';
import 'screen_detail.dart';
import 'dart:convert';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, String>> cards = [];

  Future<void> _loadCharacters() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? charactersJson = prefs.getString('characters');
    if (charactersJson != null) {
      List<dynamic> decodedData = json.decode(charactersJson);
      setState(() {
        cards = List<Map<String, String>>.from(decodedData.map((item) => Map<String, String>.from(item)));
      });
    }
  }

  Future<void> _saveCharacters() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String charactersJson = json.encode(cards);
    prefs.setString('characters', charactersJson);
  }

  void _deleteCharacter(int index) {
    setState(() {
      cards.removeAt(index);  
      _saveCharacters();  
    });
  }

  void _showAddCharacterDialog() {
    final TextEditingController _titleController = TextEditingController();
    final TextEditingController _descriptionController = TextEditingController();
    final TextEditingController _imageController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Agregar Personaje"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: "Nombre"),
              ),
              TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: "Descripción"),
              ),
              TextField(
                controller: _imageController,
                decoration: const InputDecoration(labelText: "URL de la Imagen en terminacion .png o .jpg"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancelar"),
            ),
            TextButton(
              onPressed: () {
                if (_titleController.text.isNotEmpty &&
                    _descriptionController.text.isNotEmpty &&
                    _imageController.text.isNotEmpty) {
                  setState(() {
                    cards.add({
                      "image": _imageController.text,
                      "title": _titleController.text,
                      "description": _descriptionController.text,
                    });
                    _saveCharacters();  
                  });
                  Navigator.pop(context);
                }
              },
              child: const Text("Agregar"),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _loadCharacters(); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 46, 38, 41),
              Color.fromRGBO(148, 53, 119, 1),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 60, left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Tus personajes",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.menu,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(20),
                itemCount: cards.length,
                itemBuilder: (context, index) {
                  final card = cards[index];
                  return PersonajesCard(
                    image: card['image']!,
                    title: card['title']!,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailsPage(
                            image: card['image']!,
                            title: card['title']!,
                            description: card['description']!,
                          ),
                        ),
                      );
                    },
                    onDelete: () => _deleteCharacter(index), 
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple,
        onPressed: _showAddCharacterDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
