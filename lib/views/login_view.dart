import 'package:flutter/material.dart';
import 'package:futtertutorialnotesapp/constants/routes.dart';
import 'package:futtertutorialnotesapp/services/auth/auth_exceptions.dart';
import 'package:futtertutorialnotesapp/services/auth/auth_service.dart';
import 'package:futtertutorialnotesapp/utilities/show_error_dialog.dart';
import 'dart:developer' as devtools show log;

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
    if (AuthService.firebase().currentUser?.isEmailVerified ?? false) {
      devtools.log(
          AuthService.firebase().currentUser?.toString() ?? "No user found");
      Navigator.of(context).pushNamedAndRemoveUntil(
        homeRoute,
        (route) => false,
      );
    } else {
      devtools.log("No User Found");
    }
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
                await AuthService.firebase().logIn(
                  email: email,
                  password: password,
                );
                if (context.mounted) {
                  if (AuthService.firebase().currentUser?.isEmailVerified ??
                      false) {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      homeRoute,
                      (route) => false,
                    );
                  } else {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      verificationRoute,
                      (route) => false,
                    );
                  }
                }
              } on InvalidEmailAuthException {
                if (context.mounted) {
                  showErrorDialog(context, "Error! Invalid e-Mail");
                }
              } on UserNotFoundAuthException {
                if (context.mounted) {
                  showErrorDialog(context, "Error! User Not Found");
                }
              } on WrongPasswordAuthException {
                if (context.mounted) {
                  showErrorDialog(context, "Error! Invalid e-Mail");
                }
              } on GenericAuthException {
                if (context.mounted) {
                  showErrorDialog(context, 'Error!');
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
