import "package:firebase_auth/firebase_auth.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:flutter/material.dart";
import "package:khookbook/utilities/network/network_loader.dart";

final authProvider = StateNotifierProvider<AuthNotifier, User?>((ref) {
  return AuthNotifier();
});

class AuthNotifier extends StateNotifier<User?> {
  AuthNotifier() : super(FirebaseAuth.instance.currentUser) {
    FirebaseAuth.instance.authStateChanges().listen((user) {
      state = user;
    });
  }

  Future<void> signUp(
    BuildContext context, {
    required String email,
    required String password,
  }) async {
    await executeNetworkOperation(
      context: context,
      loadingText: "Creating account...",
      successMessage: "Account created successfully",
      loader: () => FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      ),
    );
  }

  Future<void> signIn(
    BuildContext context, {
    required String email,
    required String password,
    required void Function()? onSuccess,
  }) async {
    await executeNetworkOperation(
      context: context,
      loadingText: "Signing in...",
      successMessage: "Signed in successfully",
      loader: () => FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      ),
      onSuccess: (_) => onSuccess?.call(),
    );
  }

  Future<void> signOut(BuildContext context) async {
    await executeNetworkOperation(
      context: context,
      loadingText: "Signing out...",
      successMessage: "Signed out successfully",
      loader: () => FirebaseAuth.instance.signOut(),
    );
  }

  Future<void> sendVerificationEmail(BuildContext context) async {
    await executeNetworkOperation(
      context: context,
      loadingText: "Sending verification email...",
      successMessage: "Verification email sent",
      loader: () => FirebaseAuth.instance.currentUser!.sendEmailVerification(),
    );
  }

  Future<void> changePassword(
    BuildContext context, {
    required String currentPassword,
    required String newPassword,
  }) async {
    await executeNetworkOperation(
      context: context,
      loadingText: "Changing password...",
      successMessage: "Password changed successfully",
      loader: () async {
        final user = FirebaseAuth.instance.currentUser!;
        final credential = EmailAuthProvider.credential(
          email: user.email!,
          password: currentPassword,
        );
        await user.reauthenticateWithCredential(credential);
        await user.updatePassword(newPassword);
      },
    );
  }

  Future<void> deleteAccount(BuildContext context, String password) async {
    await executeNetworkOperation(
      context: context,
      loadingText: "Deleting account...",
      successMessage: "Account deleted successfully",
      loader: () async {
        final user = FirebaseAuth.instance.currentUser!;
        final credential = EmailAuthProvider.credential(
          email: user.email!,
          password: password,
        );
        await user.reauthenticateWithCredential(credential);
        await user.delete();
      },
    );
  }
}
