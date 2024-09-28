import 'dart:math'; // Importar para gerar números aleatórios
import 'package:flutter/material.dart';
import 'package:postit_app/database/postit.dart';

class PostitCard extends StatelessWidget {
  const PostitCard({
    super.key,
    required this.postit,
  });

  final Postit postit;

  // Função para gerar uma cor aleatória
  Color _getRandomColor() {
    final Random random = Random();
    return Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 200),
      child: Container(
        height: 400,
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: Colors.blueAccent, // Aplicar a cor aleatória
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Text(postit.title,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Container(
              width: double.maxFinite,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              color: Colors.white.withAlpha(100),
              height: 180,
              child: Text(
                postit.description,
                maxLines: 12,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(postit.date),
            ),
          ],
        ),
      ),
    );
  }
}
