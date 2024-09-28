import 'package:flutter/material.dart';
import 'package:postit_app/database/postit.dart';
import 'package:postit_app/database/postit_repository.dart';
import 'package:postit_app/pages/postit_edit.dart';
import 'package:postit_app/widgets/postit_card.dart';

class PostitView extends StatefulWidget {
  const PostitView({super.key});

  @override
  State<PostitView> createState() => _PostitViewState();
}

class _PostitViewState extends State<PostitView> {
  final PostitRepository _repository = PostitRepository.instance;

  @override
  void initState() {
    super.initState();
    _repository.addListener(updateElements);
  }

  @override
  void dispose() {
    _repository.removeListener(updateElements);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const PostitEditPage()));
        },
        backgroundColor: Colors.amberAccent,
        child: const Icon(Icons.add, size: 48),
      ),
      appBar: AppBar(title: const Text("Meus Postits")),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: FutureBuilder<List<Postit>>(
            future: _repository.getAll(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Erro: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(
                    child: Text(
                  'Nenhum postit encontrado.',
                  style: const TextStyle(color: Colors.white),
                ));
              } else {
                List<Widget> postitCards = snapshot.data!
                    .map((postit) => PostitCard(postit: postit))
                    .toList();

                return ListView(
                  children: [
                    const SizedBox(height: 70),
                    Wrap(
                      spacing: 20,
                      runSpacing: 20,
                      children: postitCards,
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }

  void updateElements() {
    setState(() {});
  }
}
