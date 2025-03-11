import 'package:bloc/bloc.dart';
import 'package:notes_app/domain/usecases/note_usecases.dart';

import 'note_event.dart';
import 'note_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  final GetNotesUseCase getNotes;
  final AddNoteUseCase addNote;
  final DeleteNoteUseCase deleteNote;
  final UpdateNoteUseCase updateNote;

  NotesBloc(this.getNotes, this.addNote, this.deleteNote, this.updateNote)
      : super(NotesLoading()) {
    on<FetchNotes>(_onFetchNotes);
    on<AddNote>(_onAddNote);
    on<DeleteNote>(_onDeleteNote);
    on<UpdateNote>(_onUpdateNote);
  }

  Future<void> _onFetchNotes(FetchNotes event, Emitter<NotesState> emit) async {
    emit(NotesLoading());
    try {
      final notes = await getNotes();
      emit(NotesLoaded(notes));
    } catch (e) {
      emit(NotesError(e.toString()));
    }
  }

  Future<void> _onAddNote(AddNote event, Emitter<NotesState> emit) async {
    try {
      await addNote(event.note);
      final notes = await getNotes();
      emit(NotesLoaded(notes));
    } catch (e) {
      emit(NotesError(e.toString()));
    }
  }

  Future<void> _onUpdateNote(UpdateNote event, Emitter<NotesState> emit) async {
    try {
      await updateNote(event.note);
      final notes = await getNotes();
      emit(NotesLoaded(notes));
    } catch (e) {
      emit(NotesError(e.toString()));
    }
  }

  Future<void> _onDeleteNote(DeleteNote event, Emitter<NotesState> emit) async {
    try {
      await deleteNote(event.id);
      final notes = await getNotes();
      emit(NotesLoaded(notes));
    } catch (e) {
      emit(NotesError(e.toString()));
    }
  }
}
