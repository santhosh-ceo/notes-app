import 'package:equatable/equatable.dart';
import 'package:notes_app/data/model/note/note.dart';

abstract class NotesEvent extends Equatable {
  const NotesEvent();
}

class FetchNotes extends NotesEvent {
  @override
  List<Object> get props => [];
}

class AddNote extends NotesEvent {
  final Note note;

  const AddNote(this.note);

  @override
  List<Object> get props => [note];
}

class DeleteNote extends NotesEvent {
  final String id;

  const DeleteNote(this.id);

  @override
  List<Object> get props => [id];
}


class UpdateNote extends NotesEvent {
  final Note note;

  const UpdateNote(this.note);

  @override
  List<Object> get props => [note];
}