// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';

// class AuthServices {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final GoogleSignIn _googleSignIn = GoogleSignIn();

//   Future<UserCredential?> signInWithGoogle() async {
//     try {
//       final GoogleSignInAccount? gUser = await _googleSignIn.signIn();

//       final GoogleSignInAuthentication gAuth = await gUser!.authentication;
//       final AuthCredential credential = GoogleAuthProvider.credential(
//         idToken: gAuth.idToken,
//         accessToken: gAuth.accessToken,
//       );

//       return await _auth.signInWithCredential(credential);
//     } catch (e) {
//       print('Error during Google Sign-In: $e');
//       return null;
//     }
//   }
// }
