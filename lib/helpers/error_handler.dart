class ErrorHandler {
  static String? firebaseHandler(String message) {
    String errorMessage = "";
    switch (message) {
      case 'user-not-found':
        errorMessage = "البريد الإلكتروني غير مسجل";
        break;
      case 'email-not-verified':
        errorMessage = "البريد الإلكتروني لم يتم التحقق منه";
        break;
      case 'wrong-password':
        errorMessage = "كلمة المرور غير صحيحة";
        break;
      case 'email-already-in-use':
        errorMessage = "البريد الإلكتروني مسجل بالفعل";
        break;
      case 'weak-password':
        errorMessage = "كلمة المرور ضعيفة";
        break;
      case 'invalid-credentials':
        errorMessage = "البريد الإلكتروني أو كلمة المرور غير صحيحة";
        break;
      case 'too-many-requests':
        errorMessage = "لقد حاولت كثيرًا. حاول لاحقًا.";
        break;
      case 'unknown-error':
        errorMessage = "حدث خطأ غير متوقع، حاول مرة أخرى";
        break;
      default:
        errorMessage = "حدث خطأ: $message";
    }
    return errorMessage;
  }
}
