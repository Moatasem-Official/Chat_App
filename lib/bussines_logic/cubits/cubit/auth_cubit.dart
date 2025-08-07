import 'package:bloc/bloc.dart';
import 'package:chat_app/data/services/firebase/auth/auth_service.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  Future<void> signUp({required String email, required String password}) async {
    emit(AuthLoading());
    try {
      await AuthService.signUp(email, password);
      await AuthService.sendEmailVerification();
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> signIn({required String email, required String password}) async {
    emit(AuthLoading());
    try {
      await AuthService.signIn(email, password);
      if (FirebaseAuth.instance.currentUser!.emailVerified) {
        emit(AuthSuccess());
      } else {
        await AuthService.sendEmailVerification();
        emit(const AuthError(message: 'email-not-verified'));
      }
    } catch (e) {
      if (e is String) {
        emit(AuthError(message: e));
      } else {
        emit(const AuthError(message: 'unknown-error'));
      }
    }
  }
}
