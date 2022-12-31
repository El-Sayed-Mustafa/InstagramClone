import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram/components/widgets.dart';
import 'package:instagram/models/user.dart' as model;
import 'package:instagram/resources/storage_methode.dart';
import 'package:instagram/screens/home_screen.dart';
import 'package:instagram/screens/login_screen.dart';

import '../responsive/mobile_screen_layout.dart';
import '../responsive/responsoive_layout_screen.dart';
import '../responsive/web_screen_layout.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot documentSnapshot =
    await _firestore.collection('users').doc(currentUser.uid).get();

    return  model.User.fromSnap(documentSnapshot);
  }

  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file,
    required context,
  }) async {
    String res = "Some error Occurred";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          bio.isNotEmpty ||
          file.isNotEmpty) {
        // registering user in auth with email and password
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );


        String photoUrl = await StorageMethods()
            .uploadImageToStorage('profilePics', file, false);

        model.User _user = model.User(
          username: username,
          uid: cred.user!.uid,
          photoURL: photoUrl,
          email: email,
          bio: bio,
          followers: [],
          following: [],
        );

        await _firestore
            .collection("users")
            .doc(cred.user!.uid)
            .set(_user.toJson());

        res = "successfully registered";
        showSnackBar(res, context);
        navigateTo(context, LoginScreen());
      }
    } on FirebaseAuthException catch (e) {
      showToast(msg: Errors.show(e.code.toString()), state: ToastState.ERROR);
    } catch (err) {
      showToast(msg: Errors.show(err.toString()), state: ToastState.ERROR);
    }
    return res;
  }

  Future<String> signInUser(
      {required String email, required String password, context}) async {
    String res = "Some error occurred ";

    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      res = "Success";
      showToast(msg: "Login Successfully", state: ToastState.SUCCESS);
      navigateTo(context, ResponsiveLayout(webScreenLayout: WebScreenLayout(), mobileScreenLayout: MobileScreenLayout()));
    } on FirebaseAuthException catch (e) {
      print(e.code);
      showToast(msg: Errors.show(e.code.toString()), state: ToastState.ERROR);

    } catch (err) {
      print("Error");
      showToast(
          msg: '${Errors.show(err.toString())} error', state: ToastState.ERROR);
    }
    return res;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}

class Errors {
  static String show(String errorCode) {
    switch (errorCode) {
      case 'ERROR_EMAIL_ALREADY_IN_USE':
        return "This e-mail address is already in use, please use a different e-mail address.";

      case 'ERROR_INVALID_EMAIL':
        return "The email address is badly formatted.";

      case 'ERROR_ACCOUNT_EXISTS_WITH_DIFFERENT_CREDENTIAL':
        return "The e-mail address in your Facebook account has been registered in the system before. Please login by trying other methods with this e-mail address.";

      case 'user-not-found':
        return "E-mail address is incorrect.";
      case 'wrong-password':
        return "Password  is incorrect.";
      default:
        return "An error has occurred";
    }
  }
}
