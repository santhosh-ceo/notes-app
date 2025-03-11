import 'package:hive/hive.dart';
import 'package:notes_app/data/model/note/note.dart';
import 'package:notes_app/domain/repositories/note_repo.dart';

class NotesRepositoryImpl implements NotesRepository {
  final Box<Note> notesBox;

  NotesRepositoryImpl(this.notesBox);

  @override
  Future<List<Note>> getNotes() async => notesBox.values.toList();

  @override
  Future<void> addNote(Note note) async => await notesBox.put(note.id, note);

  @override
  Future<void> deleteNote(String id) async => await notesBox.delete(id);

  @override
  Future<void> updateNote(Note note) async => await notesBox.put(note.id, note);
}
