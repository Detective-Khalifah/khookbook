import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// Holds loading/error state for sign-in/sign-up flows.
class AuthState {
  final bool isLoading;
  final String? error;
  AuthState({this.isLoading = false, this.error});
}

class AuthNotifier extends StateNotifier<AuthState> {
  final FirebaseAuth _auth;
  AuthNotifier(this._auth) : super(AuthState());

  Future<void> signIn(String email, String password) async {
    state = AuthState(isLoading: true);
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      state = AuthState();
    } on FirebaseAuthException catch (e) {
      state = AuthState(error: e.message);
    }
  }

  Future<void> signUp(String email, String password) async {
    state = AuthState(isLoading: true);
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      state = AuthState();
    } on FirebaseAuthException catch (e) {
      state = AuthState(error: e.message);
    }
  }
}

final firebaseAuthProvider =
    Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);
final authNotifierProvider =
    StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(ref.watch(firebaseAuthProvider));
});
