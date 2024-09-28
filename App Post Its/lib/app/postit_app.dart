import 'package:flutter/material.dart';
import 'package:postit_app/pages/postit_view.dart';

class PostitApp extends StatelessWidget {
  const PostitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: PostitView());
  }
}
