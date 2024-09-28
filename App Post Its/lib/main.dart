import 'package:flutter/material.dart';
import 'package:postit_app/app/postit_app.dart';
import 'package:postit_app/database/postit_repository.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  databaseFactory = databaseFactoryFfi;
  final repository = PostitRepository.instance;
  await repository.init();
  runApp(const PostitApp());
}

// C:\Users\marce\OneDrive\Documentos\Repositorios\outropostitapp\post_it_app\.dart_tool\sqflite_common_ffi\databases
// Para apagar o banco