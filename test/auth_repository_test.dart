import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:mockito/mockito.dart';
import 'package:notes_app/data/model/auth/user.dart';
import 'package:notes_app/data/repository/auth/auth_repo_impl.dart';

import 'mocks.mocks.dart';
import 'test_setup.dart';


void main() {
  late AuthRepositoryImpl authRepository;
  late MockBox<User> mockUserBox;
  late MockFlutterSecureStorage mockSecureStorage;

  setUp(() async {
    await setupTestDependencies();
    mockUserBox = getIt<Box<User>>() as MockBox<User>;
    mockSecureStorage = getIt<FlutterSecureStorage>() as MockFlutterSecureStorage;
    authRepository = AuthRepositoryImpl(mockUserBox, mockSecureStorage);
  });

  group('AuthRepositoryImpl', () {
    test('signUp - Success', () async {
      when(mockUserBox.containsKey('test@example.com')).thenReturn(false);
      when(mockUserBox.put(any, any)).thenAnswer((_) async => null);
      when(mockSecureStorage.write(key: anyNamed('key'), value: anyNamed('value')))
          .thenAnswer((_) async => null);

      await authRepository.signUp('test@example.com', 'password123', 'Test User');

      verify(mockUserBox.put('test@example.com', any)).called(1);
      verify(mockSecureStorage.write(key: 'logged_in_user', value: 'test@example.com')).called(1);
    });

    test('signUp - User already exists', () async {
      when(mockUserBox.containsKey('test@example.com')).thenReturn(true);

      expect(() => authRepository.signUp('test@example.com', 'password123', 'Test User'),
          throwsException);
    });

    test('login - Success', () async {
      final user = User(email: 'test@example.com', password: 'password123', name: 'Test User');
      when(mockUserBox.get('test@example.com')).thenReturn(user);
      when(mockSecureStorage.write(key: anyNamed('key'), value: anyNamed('value')))
          .thenAnswer((_) async => null);

      final result = await authRepository.login('test@example.com', 'password123');

      expect(result, true);
      verify(mockSecureStorage.write(key: 'logged_in_user', value: 'test@example.com')).called(1);
    });

    test('login - Invalid credentials', () async {
      final user = User(email: 'test@example.com', password: 'password123', name: 'Test User');
      when(mockUserBox.get('test@example.com')).thenReturn(user);

      final result = await authRepository.login('test@example.com', 'wrongpassword');

      expect(result, false);
    });
  });
}