import 'package:notes_app/data/model/note/note.dart';

abstract class NotesRepository {
  Future<List<Note>> getNotes();
  Future<void> addNote(Note note);
  Future<void> deleteNote(String id);
  Future<void> updateNote(Note note);
}
