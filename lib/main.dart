import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:futtertutorialnotesapp/constants/routes.dart';
import 'package:futtertutorialnotesapp/firebase_options.dart';
import 'package:futtertutorialnotesapp/views/login_view.dart';
import 'package:futtertutorialnotesapp/views/register_view.dart';
import 'package:futtertutorialnotesapp/views/verify_email_view.dart';
import 'package:futtertutorialnotesapp/views/notes_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      useMaterial3: true,
    ),
    home: const HomePage(),
    routes: {
      loginRoute: (context) => LoginView(),
      registerRoute: (context) => RegisterView(),
      homeRoute: (context) => HomePage(),
    },
  ));
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final user = FirebaseAuth.instance.currentUser;
            if (user != null) {
              // print(user);
              if (user.emailVerified) {
                return NotesView();
              } else {
                // return const LoginView();
                return VerifyEmailView();
              }
            } else {
              return const LoginView();
            }
          default:
            return CircularProgressIndicator();
        }
      },
      // child:
    );
  }
}
