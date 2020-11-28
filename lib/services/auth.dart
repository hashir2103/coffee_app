import 'package:firebase_app1/models/user.dart';
import 'package:firebase_app1/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Authservices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = GoogleSignIn();

  //creates our on custom user obj based on firebaseUser=(FBuser) we can use FBobj directly we dont need to make custom obj but its upto us and situations it make easy
  User _userFromFirebase(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  //auth changes signedIN/out of user by stream method for showing diff screen depending weather sign in or out
  Stream<User> get user {
    return _auth.onAuthStateChanged.map(
        _userFromFirebase); //this line will do same .map((FirebaseUser user) => _userFromFirebase()); //mapping FBuser to Our custom user bcuz _auth return FBuser as _auth is FBinstance
    //So in our app when we listen to strem we can grab our custom user do something with it.
  } //now we want this data to be in root widget so we can display screen respectively we can do this by package call Provider and calling this user

  //sign in anonmously
  Future signInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign in with google

  Future handleGoogleSignIn() async {
    try {
      bool isSignedIn = await _googleSignIn.isSignedIn();
      if (isSignedIn) {
        FirebaseUser user = await _auth.currentUser();
        return user;
      }
      else{
        GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();

        GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        AuthCredential credential = GoogleAuthProvider.getCredential(
            idToken: googleSignInAuthentication.idToken,
            accessToken: googleSignInAuthentication.accessToken);

        AuthResult result = (await _auth.signInWithCredential(credential));
        FirebaseUser user = result.user;
        return user;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //google signout
  Future signoutGoogle() async {
    await _auth.signOut().then((value) => _googleSignIn.signOut());
  }

  //sign in with email & pass
  Future signInwithEmailAndPassword(email, password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // register with email & pass
  Future registerWithEmail(email, password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;

      // create new doc for user with this uid and dummy data which can be update by user later.
      await DatabaseService(uid: user.uid)
          .updateUserData('new member', '0', 100);

      return _userFromFirebase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signout() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print((e.toString()));
      return null;
    }
  }
}
