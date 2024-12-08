import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:futtertutorialnotesapp/constants/routes.dart';
import 'package:futtertutorialnotesapp/utilities/show_error_dialog.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _HomePageState();
}

class _HomePageState extends State<LoginView> {
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
        title: const Text("Login"),
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
                await FirebaseAuth.instance.signInWithEmailAndPassword(
                  email: email,
                  password: password,
                );
                if (context.mounted) {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    homeRoute,
                    (route) => false,
                  );
                }
              } on FirebaseAuthException catch (e) {
                switch (e.code) {
                  case "invalid-email":
                    if (context.mounted) {
                      showErrorDialog(context, "Error! Invalid e-Mail");
                    }
                    break;
                  case "user-not-found":
                    if (context.mounted) {
                      showErrorDialog(context, "Error! User Not Found");
                    }
                    break;
                  case "wrong-password":
                    if (context.mounted) {
                      showErrorDialog(context, "Error! Invalid e-Mail");
                    }
                    break;
                  default:
                    if (context.mounted) {
                      showErrorDialog(context, 'Error! ${e.code}');
                    }
                }
              } catch (e) {
                if (context.mounted) {
                  showErrorDialog(context, e.toString());
                }                
              }
            },
            child: Text("Login"),
          ),
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                side: BorderSide(color: Colors.blue),
              ),
            ),
            onPressed: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/register/', (route) => false);
            },
            child: Text("Register"),
          )
        ],
      ),
    );
  }
}
