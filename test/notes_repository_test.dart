import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mockito/mockito.dart';
import 'package:notes_app/data/model/note/note.dart';
import 'package:notes_app/data/repository/note_repo_impl.dart';
import 'test_setup.dart';
import 'mocks.mocks.dart';

void main() {
  late NotesRepositoryImpl notesRepository;
  late MockBox<Note> mockNotesBox;

  setUp(() async {
    await setupTestDependencies();
    mockNotesBox = getIt<Box<Note>>() as MockBox<Note>;
    notesRepository = NotesRepositoryImpl(mockNotesBox);
  });

  group('NotesRepositoryImpl', () {
    final note = Note(id: '1', title: 'Test', content: 'Content');

    test('getNotes - Success', () async {
      when(mockNotesBox.values).thenReturn([note]);

      final result = await notesRepository.getNotes();

      expect(result, [note]);
    });

    test('addNote - Success', () async {
      when(mockNotesBox.put(any, any)).thenAnswer((_) async => null);

      await notesRepository.addNote(note);

      verify(mockNotesBox.put('1', note)).called(1);
    });

    test('updateNote - Success', () async {
      when(mockNotesBox.put(any, any)).thenAnswer((_) async => null);

      await notesRepository.updateNote(note);

      verify(mockNotesBox.put('1', note)).called(1);
    });

    test('deleteNote - Success', () async {
      when(mockNotesBox.delete(any)).thenAnswer((_) async => null);

      await notesRepository.deleteNote('1');

      verify(mockNotesBox.delete('1')).called(1);
    });
  });
}
