import 'package:firebase_auth/firebase_auth.dart';

class AuthServies {
  // Instance of FirebaseAuth
  final FirebaseAuth auth = FirebaseAuth.instance;

  // Sign in with email and password
  Future<UserCredential?> signInWithEmail(String email, String password) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      // Specific FirebaseAuthException
      print('Sign in error: ${e.message}');
      return null;
    } catch (e) {
      // General error handling
      print('Error signing in: ${e.toString()}');
      return null;
    }
  }

  Future<UserCredential?> signUpWithEmailandPassword(
      String email, String password) async {
    try {
      // Use the FirebaseAuth instance to sign up
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      // Print detailed error for debugging
      print('FirebaseAuthException: ${e.message}');
      throw e; // Re-throw to handle in UI
    } catch (e) {
      // General error handling
      print('General error: ${e.toString()}');
      throw e;
    }
  }

  // Sign out the current user
  Future<void> signOut() async {
    try {
      await auth.signOut();
    } catch (e) {
      print('Error signing out: ${e.toString()}');
    }
  }

  // Get the currently authenticated user
  User? getCurrentUser() {
    return auth.currentUser;
  }

  // Check if a user is signed in

  bool isUserSignedIn() {
    return auth.currentUser != null;
  }
}
