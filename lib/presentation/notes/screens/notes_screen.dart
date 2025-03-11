import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/core/config/theme/app_textstyles.dart';
import 'package:notes_app/data/model/note/note.dart';
import 'package:notes_app/presentation/notes/bloc/note_bloc.dart';
import 'package:notes_app/presentation/notes/bloc/note_event.dart';
import 'package:notes_app/presentation/notes/bloc/note_state.dart';

class NotesScreen extends StatelessWidget {
  const NotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notes')),
      body: BlocBuilder<NotesBloc, NotesState>(
        builder: (context, state) {
          if (state is NotesLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is NotesLoaded) {
            return ListView.builder(
              itemCount: state.notes.length,
              itemBuilder: (context, index) {
                final note = state.notes[index];
                return ListTile(
                  title: Text(note.title, style: AppTextStyles.title),
                  subtitle: Text(note.content, style: AppTextStyles.subtitle),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => _showUpdateNoteDialog(context, note),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => context.read<NotesBloc>().add(DeleteNote(note.id)),
                      ),
                    ],
                  ),
                );
              },
            );
          } else if (state is NotesError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddNoteDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddNoteDialog(BuildContext context) {
    final titleController = TextEditingController();
    final contentController = TextEditingController();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Add Note'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: titleController, decoration: const InputDecoration(labelText: 'Title')),
            TextField(controller: contentController, decoration: const InputDecoration(labelText: 'Content')),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              final note = Note(
                id: DateTime.now().toString(),
                title: titleController.text,
                content: contentController.text,
              );
              context.read<NotesBloc>().add(AddNote(note));
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showUpdateNoteDialog(BuildContext context, Note note) {
    final titleController = TextEditingController(text: note.title);
    final contentController = TextEditingController(text: note.content);
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Update Note'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: titleController, decoration: const InputDecoration(labelText: 'Title')),
            TextField(controller: contentController, decoration: const InputDecoration(labelText: 'Content')),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              final updatedNote = Note(
                id: note.id,
                title: titleController.text,
                content: contentController.text,
              );
              context.read<NotesBloc>().add(UpdateNote(updatedNote));
              Navigator.pop(context);
            },
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }
}