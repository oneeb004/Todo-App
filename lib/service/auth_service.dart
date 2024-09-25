import 'package:firebase_auth/firebase_auth.dart';
import 'package:to_do_app/utils/utils.dart';

class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;

   //SingIn

  Future<User?> singInWithEmailAndPassword(String email , String password) async {

    try{

      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return user;
 
    }catch(e){
      Utils.showToast(e.toString());
    }
  }
  
  //SingUp

  Future<User?> registerWithEmailAndPassword(String email , String password) async {

    try{

      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return user;
 
    }catch(e){
      Utils.showToast(e.toString());
    }
  }

  //Singout

  Future<void> singnOut()async{

    try{

      return await _auth.signOut();

    }catch(e){
      Utils.showToast(e.toString());

    }
 


  } 


}