import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:notes_app/data/model/note/note.dart';
import 'package:notes_app/domain/usecases/note_usecases.dart';
import 'package:notes_app/presentation/notes/bloc/note_bloc.dart';
import 'package:notes_app/presentation/notes/bloc/note_event.dart';
import 'package:notes_app/presentation/notes/bloc/note_state.dart';
import 'test_setup.dart';
import 'mocks.mocks.dart';

void main() {
  late NotesBloc notesBloc;
  late MockGetNotesUseCase mockGetNotes;
  late MockAddNoteUseCase mockAddNote;
  late MockUpdateNoteUseCase mockUpdateNote;
  late MockDeleteNoteUseCase mockDeleteNote;

  setUp(() async {
    await setupTestDependencies();
    mockGetNotes = getIt<GetNotesUseCase>() as MockGetNotesUseCase;
    mockAddNote = getIt<AddNoteUseCase>() as MockAddNoteUseCase;
    mockUpdateNote = getIt<UpdateNoteUseCase>() as MockUpdateNoteUseCase;
    mockDeleteNote = getIt<DeleteNoteUseCase>() as MockDeleteNoteUseCase;
    notesBloc =
        NotesBloc(mockGetNotes, mockAddNote, mockDeleteNote, mockUpdateNote);
  });

  tearDown(() {
    notesBloc.close();
  });

  group('NotesBloc', () {
    final note = Note(id: '1', title: 'Test', content: 'Content');
    final updatedNote =
        Note(id: '1', title: 'Updated Test', content: 'Updated Content');

    // Test FetchNotes Event
    blocTest<NotesBloc, NotesState>(
      'emits [NotesLoading, NotesLoaded] when FetchNotes succeeds with notes',
      build: () {
        when(mockGetNotes()).thenAnswer((_) async => [note]);
        return notesBloc;
      },
      act: (bloc) => bloc.add(FetchNotes()),
      expect: () => [
        NotesLoading(),
        NotesLoaded([note]),
      ],
      verify: (_) {
        verify(mockGetNotes()).called(1);
      },
    );

    blocTest<NotesBloc, NotesState>(
      'emits [NotesLoading, NotesLoaded] when FetchNotes succeeds with empty list',
      build: () {
        when(mockGetNotes()).thenAnswer((_) async => []);
        return notesBloc;
      },
      act: (bloc) => bloc.add(FetchNotes()),
      expect: () => [
        NotesLoading(),
        const NotesLoaded([]),
      ],
      verify: (_) {
        verify(mockGetNotes()).called(1);
      },
    );

    blocTest<NotesBloc, NotesState>(
      'emits [NotesLoading, NotesError] when FetchNotes fails',
      build: () {
        when(mockGetNotes()).thenThrow(Exception('Database error'));
        return notesBloc;
      },
      act: (bloc) => bloc.add(FetchNotes()),
      expect: () => [
        NotesLoading(),
        const NotesError('Exception: Database error'),
      ],
      verify: (_) {
        verify(mockGetNotes()).called(1);
      },
    );

    // Test AddNote Event
    blocTest<NotesBloc, NotesState>(
      'emits [NotesLoaded] when AddNote succeeds',
      build: () {
        when(mockAddNote(any)).thenAnswer((_) async => null);
        when(mockGetNotes()).thenAnswer((_) async => [note]);
        return notesBloc;
      },
      act: (bloc) => bloc.add(AddNote(note)),
      expect: () => [
        NotesLoaded([note]),
      ],
      verify: (_) {
        verify(mockAddNote(note)).called(1);
        verify(mockGetNotes()).called(1);
      },
    );

    blocTest<NotesBloc, NotesState>(
      'emits [NotesError] when AddNote fails',
      build: () {
        when(mockAddNote(any)).thenThrow(Exception('Add failed'));
        when(mockGetNotes()).thenAnswer((_) async => []);
        return notesBloc;
      },
      act: (bloc) => bloc.add(AddNote(note)),
      expect: () => [
        const NotesError('Exception: Add failed'),
      ],
      verify: (_) {
        verify(mockAddNote(note)).called(1);
      },
    );

    // Test UpdateNote Event
    blocTest<NotesBloc, NotesState>(
      'emits [NotesLoaded] when UpdateNote succeeds',
      build: () {
        when(mockUpdateNote(any)).thenAnswer((_) async => null);
        when(mockGetNotes()).thenAnswer((_) async => [updatedNote]);
        return notesBloc;
      },
      act: (bloc) => bloc.add(UpdateNote(updatedNote)),
      expect: () => [
        NotesLoaded([updatedNote]),
      ],
      verify: (_) {
        verify(mockUpdateNote(updatedNote)).called(1);
        verify(mockGetNotes()).called(1);
      },
    );

    blocTest<NotesBloc, NotesState>(
      'emits [NotesError] when UpdateNote fails',
      build: () {
        when(mockUpdateNote(any)).thenThrow(Exception('Update failed'));
        when(mockGetNotes()).thenAnswer((_) async => [note]);
        return notesBloc;
      },
      act: (bloc) => bloc.add(UpdateNote(updatedNote)),
      expect: () => [
        const NotesError('Exception: Update failed'),
      ],
      verify: (_) {
        verify(mockUpdateNote(updatedNote)).called(1);
      },
    );

    // Test DeleteNote Event
    blocTest<NotesBloc, NotesState>(
      'emits [NotesLoaded] when DeleteNote succeeds',
      build: () {
        when(mockDeleteNote(any)).thenAnswer((_) async => null);
        when(mockGetNotes()).thenAnswer((_) async => []);
        return notesBloc;
      },
      act: (bloc) => bloc.add(const DeleteNote('1')),
      expect: () => [
        const NotesLoaded([]),
      ],
      verify: (_) {
        verify(mockDeleteNote('1')).called(1);
        verify(mockGetNotes()).called(1);
      },
    );

    blocTest<NotesBloc, NotesState>(
      'emits [NotesError] when DeleteNote fails',
      build: () {
        when(mockDeleteNote(any)).thenThrow(Exception('Delete failed'));
        when(mockGetNotes()).thenAnswer((_) async => [note]);
        return notesBloc;
      },
      act: (bloc) => bloc.add(const DeleteNote('1')),
      expect: () => [
        const NotesError('Exception: Delete failed'),
      ],
      verify: (_) {
        verify(mockDeleteNote('1')).called(1);
      },
    );
  });
}
