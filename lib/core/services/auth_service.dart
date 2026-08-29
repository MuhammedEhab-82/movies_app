import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../features/auth/model/user_model.dart';

class AuthService {
  AuthService._internal();

  static final AuthService instance = AuthService._internal();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserModel> registerWithEmail({
    required String name,
    required String email,
    required String password,
    required String phone,
    int avatar = 1,
  }) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      final user = credential.user;
      if (user == null) {
        throw AuthException('Something went wrong. Please try again.');
      }

      await user.updateDisplayName(name.trim());
      await user.reload();

      final userModel = UserModel(
        uid: user.uid,
        name: name.trim(),
        email: email.trim(),
        phone: phone.trim(),
        avatar: avatar,
      );

      await _firestore
          .collection('users')
          .doc(user.uid)
          .set({...userModel.toMap(), 'createdAt': FieldValue.serverTimestamp()});

      return userModel;
    } on FirebaseAuthException catch (e) {
      throw AuthException(_mapFirebaseAuthError(e));
    } catch (e) {
      throw AuthException(_mapGenericError(e));
    }
  }

  Future<void> sendPasswordResetEmail({required String email}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email.trim());
    } on FirebaseAuthException catch (e) {
      throw AuthException(_mapFirebaseAuthError(e));
    } catch (e) {
      throw AuthException(_mapGenericError(e));
    }
  }

  String _mapGenericError(Object e) {
    final raw = e.toString().toLowerCase();

    if (raw.contains('already in use')) {
      return 'This email is already registered. Try logging in instead.';
    }
    if (raw.contains('invalid-email') || raw.contains('badly formatted')) {
      return 'Please enter a valid email address.';
    }
    if (raw.contains('weak-password') || raw.contains('weak password')) {
      return 'Password is too weak. Use at least 6 characters.';
    }
    if (raw.contains('network')) {
      return 'No internet connection. Please check your network.';
    }

    return 'Something went wrong. Please try again.';
  }

  String _mapFirebaseAuthError(FirebaseAuthException e) {
    switch (e.code) {
      case 'email-already-in-use':
        return 'This email is already registered. Try logging in instead.';
      case 'invalid-email':
        return 'Please enter a valid email address.';
      case 'weak-password':
        return 'Password is too weak. Use at least 6 characters.';
      case 'operation-not-allowed':
        return 'Email/Password sign-up is not enabled. Contact support.';
      case 'network-request-failed':
        return 'No internet connection. Please check your network.';
      case 'user-not-found':
        return 'No account found with this email.';
      case 'too-many-requests':
        return 'Too many attempts. Please try again later.';
      default:
        return e.message ?? 'Authentication failed. Please try again.';
    }
  }
}

class AuthException implements Exception {
  final String message;
  AuthException(this.message);

  @override
  String toString() => message;
}