import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> login(
    String email,
    String password,
    bool rememberPassword,
  ) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      if (userCredential.user != null) {
        if (rememberPassword) {
          await _saveCredentials(email, password);
        } else {
          await _clearCredentials();
        }
        return true;
      }
      return false;
    } on FirebaseAuthException catch (e) {
      throw _handleAuthError(e);
    } catch (e) {
      throw Exception('An unexpected error occurred: ${e.toString()}');
    }
  }

  String _handleAuthError(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'No user found with this email address';
      case 'wrong-password':
        return 'Incorrect password';
      case 'invalid-email':
        return 'Invalid email address';
      case 'user-disabled':
        return 'This user account has been disabled';
      case 'too-many-requests':
        return 'Too many login attempts. Please try again later';
      default:
        return 'Login failed: ${e.message}';
    }
  }

  Future<void> _saveCredentials(String email, String password) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('saved_email', email);
      await prefs.setString('saved_password', password);
      await prefs.setBool('remember_password', true);
    } catch (e) {
      print('Error saving credentials: $e');
    }
  }

  Future<void> _clearCredentials() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('saved_email');
      await prefs.remove('saved_password');
      await prefs.setBool('remember_password', false);
    } catch (e) {
      print('Error clearing credentials: $e');
    }
  }

  Future<Map<String, String>?> getSavedCredentials() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final rememberPassword = prefs.getBool('remember_password') ?? false;

      if (rememberPassword) {
        final email = prefs.getString('saved_email');
        final password = prefs.getString('saved_password');
        if (email != null && password != null) {
          return {'email': email, 'password': password};
        }
      }
    } catch (e) {
      print('Error retrieving credentials: $e');
    }
    return null;
  }

  Future<bool> isLoggedIn() async {
    return _auth.currentUser != null;
  }

  Future<void> logout() async {
    try {
      await _clearCredentials();
      await _auth.signOut();
    } catch (e) {
      print('Error logging out: $e');
    }
  }

  String? getCurrentUserEmail() {
    return _auth.currentUser?.email;
  }
}
