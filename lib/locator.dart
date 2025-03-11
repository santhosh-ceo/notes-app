import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'data/model/auth/user.dart';
import 'data/model/note/note.dart';
import 'data/repository/auth/auth_repo_impl.dart';
import 'data/repository/note_repo_impl.dart';
import 'domain/repositories/auth_repo.dart';
import 'domain/repositories/note_repo.dart';
import 'domain/usecases/auth_usecases.dart';
import 'domain/usecases/note_usecases.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  getIt.registerLazySingleton(() => Hive.box<User>('users'));
  getIt.registerLazySingleton(() => Hive.box<Note>('notes'));
  getIt.registerLazySingleton(() => const FlutterSecureStorage());

  getIt.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(getIt(), getIt()));
  getIt.registerLazySingleton<NotesRepository>(() => NotesRepositoryImpl(getIt()));

  getIt.registerLazySingleton(() => SignUpUseCase(getIt()));
  getIt.registerLazySingleton(() => LoginUseCase(getIt()));
  getIt.registerLazySingleton(() => GetNotesUseCase(getIt()));
  getIt.registerLazySingleton(() => AddNoteUseCase(getIt()));
  getIt.registerLazySingleton(() => UpdateNoteUseCase(getIt()));
  getIt.registerLazySingleton(() => DeleteNoteUseCase(getIt()));
}