import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram/components/widgets.dart';
import 'package:instagram/resources/storage_methode.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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

/*
        String photoUrl = await StorageMethods()
            .uploadImageToStorage('profilePics', file, false);

        model.User _user = model.User(
          username: username,
          uid: cred.user!.uid,
          photoUrl: photoUrl,
          email: email,
          bio: bio,
          followers: [],
          following: [],
        );
*/

        String photoUrl = await StorageMethods()
            .uploadImageToStorage('profilePics', file, false);
        // adding user in our database
        await _firestore.collection("users").doc(cred.user!.uid).set({
          'username': username,
          'uid': cred.user!.uid,
          'email': email,
          'bio': bio,
          'followers': [],
          'following': [],
          'photoUrl': photoUrl
        });

        res = "success";
        showSnackBar(res, context);
      } else {
        res = "Please enter all the fields";
        showToast(msg: res, state: ToastState.ERROR);
      }
    } on FirebaseAuthException catch (e) {
      showToast(msg: Errors.show(e.code.toString()), state: ToastState.ERROR);
    } catch (err) {
      showToast(msg: Errors.show(err.toString()), state: ToastState.ERROR);
      print(err.toString());
      return err.toString();
    }
    return res;
  }

  Future<String> SignInUser(
      {required String email, required String password}) async {
    String res = "Some error occurred ";

    try {
      _auth.signInWithEmailAndPassword(email: email, password: password);
      res = "Success";
    } catch (err) {
      res = err.toString();
      print(res);
    }
    return res;
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

      case 'ERROR_WRONG_PASSWORD':
        return "E-mail address or password is incorrect.";

      default:
        return "An error has occurred";
    }
  }
}
