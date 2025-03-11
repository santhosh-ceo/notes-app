import 'package:notes_app/data/model/note/note.dart';
import 'package:notes_app/domain/repositories/note_repo.dart';

class GetNotesUseCase {
  final NotesRepository repository;

  GetNotesUseCase(this.repository);

  Future<List<Note>> call() => repository.getNotes();
}

class AddNoteUseCase {
  final NotesRepository repository;

  AddNoteUseCase(this.repository);

  Future<void> call(Note note) => repository.addNote(note);
}

class DeleteNoteUseCase {
  final NotesRepository repository;

  DeleteNoteUseCase(this.repository);

  Future<void> call(String id) => repository.deleteNote(id);
}


class UpdateNoteUseCase {
  final NotesRepository repository;

  UpdateNoteUseCase(this.repository);

  Future<void> call(Note note) => repository.updateNote(note);
}