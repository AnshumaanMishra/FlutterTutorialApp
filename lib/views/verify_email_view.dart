import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Verify Your eMail"),
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Text("Please Verify Your eMail"),
          TextButton(
            onPressed: () async {
              final user = FirebaseAuth.instance.currentUser;
              await user?.sendEmailVerification();
            },
            child: Text("Send verification eMail"),
          ),
        ],
      ),
    );
    // Scaffold(
    //   appBar: AppBar(
    //     title: const Text("Verify Your eMail"),
    //     foregroundColor: Colors.white,
    //     backgroundColor: Colors.blue,
    //   ),
    //   body:
    // );
  }
}
