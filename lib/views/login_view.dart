import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:futtertutorialnotesapp/firebase_options.dart';

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
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
        body: FutureBuilder(
          future: Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform,
          ),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                return Column(
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
                      onPressed: () async {
                        final email = _eMail.text;
                        final password = _passWord.text;
                        try {
                          final userCredential = await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                            email: email,
                            password: password,
                          );
                          print(" UC = \n");
                          print(userCredential);
                        } on FirebaseAuthException catch (e) {
                          // print("Error Code: ");
                          // print(e.runtimeType);
                          switch (e.code) {
                            case "user-not-found":
                              print('Error! User Not Found');
                              break;
                            case "wrong-password":
                              print('Error! Invalid Password');
                              break;
                            case "invalid-email":
                              print('Error! Invalid e-Mail');
                              break;
                            default:
                              print(e.code);
                          }
                        }
                      },
                      child: Text("Login"),
                    ),
                  ],
                );

              default:
                return const Text("Loading...");
            }
          },
          // child:
        ));
  }
}
