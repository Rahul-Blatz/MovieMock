import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:moviemock/screens/loading_screen.dart';
import 'package:moviemock/screens/login_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LandingPage(),
    );
  }
}

class LandingPage extends StatelessWidget {
  final Future<FirebaseApp> _initializeFireBase = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeFireBase,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text("Error Loading: ${snapshot.error}"),
            ),
          );
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                User user = snapshot.data;
                print(snapshot.data);
                if (user == null) {
                  return LoginPage();
                } else {
                  return LoadingScreen();
                }
              }
              return Scaffold(
                body: Center(
                  child: Text("Authenticating User..."),
                ),
              );
            },
          );
        }

        return Scaffold(
          body: Center(
            child: Text("Connecting to the App..."),
          ),
        );
      },
    );
  }
}
