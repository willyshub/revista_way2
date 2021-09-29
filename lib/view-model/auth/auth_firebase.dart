import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:revista_way2/view/pages/user_info/user_info_page.dart';

class AuthFirebase extends ChangeNotifier {
  User? _user;
  

  void setUser(User? userAux) {
    _user = userAux;
    notifyListeners();
  }

  bool get isLoggedIn => _user != null;

  static Future<FirebaseApp> initializeFirebase(BuildContext? context) async {
    final FirebaseApp firebaseApp = await Firebase.initializeApp();

    final User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      Navigator.of(context!).pushReplacement(
        MaterialPageRoute(
          builder: (context) => UserInfoPage(
            user: user,
          ),
        ),
      );
    }

    AuthFirebase authFirebase = AuthFirebase();
    authFirebase.setUser(user);

    
    return firebaseApp;
  }

  // LOGAR W/ GOOGLE
  static Future<User?> signInWithGoogle({required BuildContext context}) async {
    final auth = FirebaseAuth.instance;
    User? user;

    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
            await auth.signInWithCredential(credential);

        user = userCredential.user;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          ScaffoldMessenger.of(context).showSnackBar(
            customSnackBar(
              content:
                  'The account already exists with a different credential.',
            ),
          );
        } else if (e.code == 'invalid-credential') {
          ScaffoldMessenger.of(context).showSnackBar(
            customSnackBar(
              content: 'Error occurred while accessing credentials. Try again.',
            ),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          customSnackBar(
            content:
                'Ocorreu um error ao tenter usar o Google Sign-In. Tente novamente.',
          ),
        );
      }
    }

    final authFirebase = AuthFirebase();
    authFirebase.setUser(user);
    return user;
  }

  static Future<void> signOut({required BuildContext context}) async {
    try {
      await FirebaseAuth.instance.signOut();
      final authFirebase = AuthFirebase();
      authFirebase.setUser(null);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        customSnackBar(
          content: 'Error signing out. Try again.',
        ),
      );
    }
  }
}

SnackBar customSnackBar({required String content}) {
  return SnackBar(
    backgroundColor: Colors.black,
    content: Text(
      content,
      style: const TextStyle(color: Colors.redAccent, letterSpacing: 0.5),
    ),
  );
}
