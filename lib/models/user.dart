import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String email;
  final String uid;
  final String photoURL;
  final String username;
  final String bio;
  final List followers;
  final List following;

  const User({
    required this.email,
    required this.uid,
    required this.photoURL,
    required this.username,
    required this.bio,
    required this.followers,
    required this.following,
  });

  Map<String, dynamic> toJson() => {
        "username": username,
        "email": email,
        "uid": uid,
        "photoURL": photoURL,
        "bio": bio,
        "followers": followers,
        "following": following
      };

  static User fromSnap(DocumentSnapshot snap) {
    User user = User(
      username: snap["username"],
      uid: snap['uid'],
      photoURL: snap['photoURL'],
      email: snap['email'],
      bio: snap['bio'],
      followers:snap['followers'],
      following:snap ['following'],
    );
    return user;
  }
}
