import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';
import 'package:mockito/annotations.dart';
import 'package:notes_app/domain/repositories/auth_repo.dart';
import 'package:notes_app/domain/repositories/note_repo.dart';
import 'package:notes_app/domain/usecases/auth_usecases.dart';
import 'package:notes_app/domain/usecases/note_usecases.dart';



@GenerateMocks([
  AuthRepository,
  NotesRepository,
  FlutterSecureStorage,
  Box,
  SignUpUseCase,
  LoginUseCase,
  GetNotesUseCase,
  AddNoteUseCase,
  UpdateNoteUseCase,
  DeleteNoteUseCase,
])
void main() {}