import 'package:flutter/material.dart';
import 'package:futtertutorialnotesapp/constants/routes.dart';
import 'package:futtertutorialnotesapp/services/auth/auth_exceptions.dart';
import 'package:futtertutorialnotesapp/services/auth/auth_service.dart';
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
                await AuthService.firebase().signUp(
                  email: email,
                  password: password,
                );
                if (context.mounted) {
                  Navigator.of(context).pushNamed(verificationRoute);
                }
              } on InvalidEmailAuthException {
                if (context.mounted) {
                  await showErrorDialog(context, "Error! Invalid e-Mail");
                }
              } on EmailAlreadyInUseAuthException {
                    if (context.mounted) {
                      await showErrorDialog(
                          context, 'Error! Invalid e-Mail, already in use');
                }
              } on WeakPasswordAuthException {
                    if (context.mounted) {
                      await showErrorDialog(context,
                          'Error! Password too weak, please try again');
                }
              } on GenericAuthException {
                    if (context.mounted) {
                  await showErrorDialog(context, "Error");
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
