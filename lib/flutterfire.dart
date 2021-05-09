import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_storage/firebase_storage.dart';

Future<String> registerEmail(String email, String password) async {
  try {
    UserCredential credential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    return null;
  } on FirebaseAuthException catch (e) {
    switch (e.code) {
      case "weak-password":
        return "Password is too weak.";
      case "email-already-in-use":
        return "Email already in use.";
      case "invalid-email":
        return "Invalid email.";
      case "unknown":
        return "Missing information.";
      default:
        break;
    }

    print(e.code);
  } catch (e) {
    print(e);
  }
  return "Something went wrong.";
}

Future<String> loginEmail(String email, String password) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return null;
  } on FirebaseAuthException catch (e) {
    switch (e.code) {
      case "user-not-found":
        return "User not found.";
      case "wrong-password":
        return "Incorrect password.";
      case "invalid-email":
        return "Invalid email.";
      case "unknown":
        return "Missing information.";
      default:
        break;
    }

    print(e.code);
  } catch (e) {
    print(e);
  }
  return "Something went wrong.";
}

Future<bool> loginGoogle() async {
  try {
    final GoogleSignInAccount account = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication authentication = await account
        .authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: authentication.accessToken,
      idToken: authentication.idToken,
    );

    FirebaseAuth.instance.signInWithCredential(credential);
    return true;
  }
  catch (e) {
    print(e);
  }
  return false;
}

Future<bool> recordGrade(String grade) async {
  try {
    String uid = FirebaseAuth.instance.currentUser.uid;
    var time = FieldValue.serverTimestamp();

    DocumentReference docRef = FirebaseFirestore.instance.collection("users")
        .doc(uid)
        .collection("quiz")
        .doc("grade");

    return await FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(docRef);
      transaction.set(docRef, {"answer": grade, "time": time});

      if (!snapshot.exists) {
        return await recordGradeMeta(grade, false, null);
      }
      else {
        String old = snapshot.data()["answer"];
        return await recordGradeMeta(grade, true, old);
      }
    });
  }
  catch (e) {
    print(e);
  }
  return false;
}

Future<bool> recordGradeMeta(String grade, bool replaced, String replacedGrade) async {
  try {
    DocumentReference docRef = FirebaseFirestore.instance.collection("meta")
        .doc("grades");

    FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(docRef);

      if (!snapshot.exists) {
        transaction.set(docRef, {"freshman": 0, "sophomore": 0, "junior": 0, "senior": 0});
        transaction.update(docRef, {grade: 1});
        return true;
      }
      else if (replaced && grade != replacedGrade) {
        var gradeAmount = snapshot.data()[grade] + 1;
        var replacedAmount = snapshot.data()[replacedGrade] - 1;
        transaction.update(docRef, {grade: gradeAmount, replacedGrade: replacedAmount});
      }
      else if (!replaced) {
        var gradeAmount = snapshot.data()[grade] + 1;
        transaction.update(docRef, {grade: gradeAmount});
      }
    });
    print("Returning true");
    return true;
  }
  catch (e) {
    print(e);
  }
  return false;
}

void fireLogout() {
  FirebaseAuth.instance.signOut();
  GoogleSignIn().signOut();
  FacebookAuth.instance.logOut();
}

Future<bool> uploadAudio(String filePath) async {
  try {
    var uid = FirebaseAuth.instance.currentUser.uid;
    var ref = FirebaseStorage.instance.ref("/users/" + uid + "/audio/" + Timestamp.now().toDate().toString() + ".mp4");

    print(filePath);

    await ref.putFile(File(filePath));
    return true;
  }
  catch (e) {
    print(e);
  }
  return false;
}

Future<bool> loginFacebook() async {
  try {
    final AccessToken result = await FacebookAuth.instance.login();
    final credential = FacebookAuthProvider.credential(result.token);

    await FirebaseAuth.instance.signInWithCredential(credential);

    return true;
  }
  catch (e) {
    print(e);
  }
  return false;
}

Future<ListResult> recordingList() async {
  try {
    var uid = FirebaseAuth.instance.currentUser.uid;
    ListResult result = await FirebaseStorage.instance.ref("users/" + uid + "/audio/").listAll();

    return result;
  }
  catch (e) {
    print(e);
  }
  return null;
}