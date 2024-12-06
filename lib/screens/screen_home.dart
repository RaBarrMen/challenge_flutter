import 'package:flutter/material.dart';
import '../widget/personajes.dart';
import 'screen_detail.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, String>> cards = [
    {
      "image": "lib/imagenes/DK.jpg",
      "title": "Donkey Kong",
      "description":
          ""
    },
    {
      "image": "lib/imagenes/link.png",
      "title": "Link",
      "description":
          ""
    },
    {
      "image": "lib/imagenes/luigi.jpg",
      "title": "Luigi",
      "description":
          ""
    },
    {
      "image": "lib/imagenes/mario.jpeg",
      "title": "Mario",
      "description":
          ""
    },
    {
      "image": "lib/imagenes/toad.jpeg",
      "title": "Toad",
      "description":
          ""
    },
  ];

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
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple,
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(""),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}