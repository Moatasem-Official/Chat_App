class AuthService {
  static Future<void> signOut() async {}
  static Future<void> sendEmailVerification() async {}
  static Future<void> sendPasswordResetEmail(String email) async {}
  static Future<void> signUp(String email, String password) async {}
  static Future<void> signIn(String email, String password) async {}
}
