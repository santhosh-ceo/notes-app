import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';
import 'package:notes_app/data/model/auth/user.dart';
import 'package:notes_app/domain/repositories/auth_repo.dart';

class AuthRepositoryImpl implements AuthRepository {
  final Box<User> userBox;
  final FlutterSecureStorage secureStorage;

  AuthRepositoryImpl(this.userBox, this.secureStorage);

  @override
  Future<bool> login(String email, String password) async {
    final user = userBox.get(email);

    if (user != null && user.password == password) {
      await secureStorage.write(key: 'logged_in_user', value: email);
      return true;
    }

    return false;
  }

  @override
  Future<void> signUp(String email, String name, String password) async {
    if (userBox.containsKey(email)) {
      throw Exception('User already exists');
    }

    final user = User(email: email, name: name, password: password);
    await userBox.put(email, user);
    await secureStorage.write(key: 'logged_in_user', value: email);
  }
}
