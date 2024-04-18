import 'package:firebase_auth/firebase_auth.dart';

class FireBaseAuthService{
  FirebaseAuth auth = FirebaseAuth.instance;
  Future<User?> signupwithEmailandPassword(
    String email, String password
  ) async{
    try{
      UserCredential cred = await auth.createUserWithEmailAndPassword(email: email, password: password);
      return cred.user;
    }
    catch(e){
      return null;
    }
  }

  Future<User?> signInWithEmailandPassword(
    String email, String password
  ) async{
    try{
      UserCredential cred = await auth.signInWithEmailAndPassword(email: email, password: password);
      return cred.user;
    }
    catch(e){
      return null;
    }


  }
}