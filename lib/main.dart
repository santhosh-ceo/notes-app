import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notes_app/app.dart';

import 'data/model/auth/user.dart';
import 'data/model/note/note.dart';
import 'locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();

  // Register adapters only if not already registered
  if (!Hive.isAdapterRegistered(UserAdapter().typeId)) {
    Hive.registerAdapter(UserAdapter());
  }
  if (!Hive.isAdapterRegistered(NoteAdapter().typeId)) {
    Hive.registerAdapter(NoteAdapter());
  }

  // Setup dependencies
  await setupDependencies();
  runApp(NoteApp());
}
