import 'package:firebase_auth/firebase_auth.dart' as firebase_auth show User;
import 'package:flutter/foundation.dart';

@immutable
class AuthUser {
  final bool isEmailVerified;
  final String email;
  const AuthUser(
    this.isEmailVerified,
    this.email,
  );

  factory AuthUser.fromFirebase(firebase_auth.User user) => AuthUser(
        user.emailVerified,
        user.email ?? "Not Availiable",
      );
}
