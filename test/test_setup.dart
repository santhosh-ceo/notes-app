import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:notes_app/data/model/auth/user.dart';
import 'package:notes_app/data/model/note/note.dart';
import 'package:notes_app/data/repository/auth/auth_repo_impl.dart';
import 'package:notes_app/data/repository/note_repo_impl.dart';
import 'package:notes_app/domain/repositories/auth_repo.dart';
import 'package:notes_app/domain/repositories/note_repo.dart';
import 'package:notes_app/domain/usecases/auth_usecases.dart';
import 'package:notes_app/domain/usecases/note_usecases.dart';
import 'mocks.mocks.dart';

final getIt = GetIt.instance;

Future<void> setupTestDependencies() async {
  getIt.reset();

  final mockUserBox = MockBox<User>();
  final mockNotesBox = MockBox<Note>();
  final mockSecureStorage = MockFlutterSecureStorage();

  getIt.registerSingleton<Box<User>>(mockUserBox);
  getIt.registerSingleton<Box<Note>>(mockNotesBox);
  getIt.registerSingleton<FlutterSecureStorage>(mockSecureStorage);

  getIt.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(mockUserBox, mockSecureStorage));
  getIt.registerLazySingleton<NotesRepository>(
      () => NotesRepositoryImpl(mockNotesBox));

  getIt.registerLazySingleton(() => SignUpUseCase(getIt()));
  getIt.registerLazySingleton(() => LoginUseCase(getIt()));
  getIt.registerLazySingleton(() => GetNotesUseCase(getIt()));
  getIt.registerLazySingleton(() => AddNoteUseCase(getIt()));
  getIt.registerLazySingleton(() => UpdateNoteUseCase(getIt()));
  getIt.registerLazySingleton(() => DeleteNoteUseCase(getIt()));
}
