abstract class AuthRepository {
  Future<void> signUp(String email, String name, String password);
  Future<bool> login(String email, String password);
}
