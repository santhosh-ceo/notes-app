import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/presentation/auth/bloc/auth_bloc.dart';
import 'package:notes_app/presentation/auth/screens/login_screen.dart';
import 'package:notes_app/presentation/notes/bloc/note_bloc.dart';
import 'package:notes_app/presentation/notes/bloc/note_event.dart';

import 'locator.dart';

class NoteApp extends StatelessWidget {
  NoteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthBloc(getIt(), getIt())),
        BlocProvider(
            create: (_) => NotesBloc(getIt(), getIt(), getIt(), getIt())
              ..add(FetchNotes())),
      ],
      child: MaterialApp(
        theme: ThemeData(primarySwatch: Colors.blue),
        home: LoginScreen(),
      ),
    );
  }
}
