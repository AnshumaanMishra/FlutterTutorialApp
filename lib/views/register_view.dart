import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:futtertutorialnotesapp/constants/routes.dart';
import 'package:futtertutorialnotesapp/utilities/show_error_dialog.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _eMail;
  late final TextEditingController _passWord;

  @override
  void initState() {
    _eMail = TextEditingController();
    _passWord = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _eMail.dispose();
    _passWord.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          TextField(
            controller: _eMail,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              hintText: "e-Mail",
            ),
          ),
          TextField(
            controller: _passWord,
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration: const InputDecoration(
              hintText: "PassWord",
            ),
          ),
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
            onPressed: () async {
              final email = _eMail.text;
              final password = _passWord.text;
              try {
                await FirebaseAuth.instance.createUserWithEmailAndPassword(
                  email: email,
                  password: password,
                );
                // final user = FirebaseAuth.instance.currentUser;
                // await user?.sendEmailVerification();
                if (context.mounted) {
                  Navigator.of(context).pushNamed(verificationRoute);
                }
              } on FirebaseAuthException catch (e) {
                switch (e.code) {
                  case "invalid-email":
                    if (context.mounted) {
                      await showErrorDialog(context, "Error! Invalid e-Mail");
                    }
                    break;
                  case "email-already-in-use":
                    if (context.mounted) {
                      await showErrorDialog(
                          context, 'Error! Invalid e-Mail, already in use');
                    }
                    break;
                  case "weak-password":
                    if (context.mounted) {
                      await showErrorDialog(context,
                          'Error! Password too weak, please try again');
                    }
                    break;
                  default:
                    if (context.mounted) {
                      await showErrorDialog(context, e.toString());
                    }
                    break;
                }
              } catch (e) {
                if (context.mounted) {
                  showErrorDialog(context, e.toString());
                }
              }
            },
            child: Text("Register"),
          ),
          TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    verificationRoute, (route) => false);
              },
              child: const Text("Login")),
        ],
      ),
    );
  }
}
          // chil
