class AuthService {
  Future<void> signOut() async {}
  Future<void> sendEmailVerification() async {}
  Future<void> sendPasswordResetEmail(String email) async {}
  Future<void> signUp(String email, String password) async {}
  Future<void> signIn(String email, String password) async {}
}
