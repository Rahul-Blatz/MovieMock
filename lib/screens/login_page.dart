import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moviemock/widgets/FancyButton.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

String email = "";

class _LoginPageState extends State<LoginPage> {
  String _password;

  Future<void> createUser() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: _password);
    } on FirebaseAuthException catch (e) {
      print("FireBaseAuth Error: $e");
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<void> login() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: _password);
    } on FirebaseAuthException catch (e) {
      print("FireBaseAuth Error: $e");
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.withOpacity(.8),
//        appBar: AppBar(
//          backgroundColor: Colors.white,
//          elevation: 0.0,
//          title: Text(
//            "Login",
//            style: GoogleFonts.quicksand(color: Colors.black),
//          ),
//          centerTitle: true,
//        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 200,
              height: 200,
              child: Image.asset('assets/images/TicketLogo.png'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 10.0,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(.5),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      email = value;
                    });
                  },
                  decoration: new InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      contentPadding: EdgeInsets.only(
                          left: 15, bottom: 11, top: 11, right: 15),
                      hintText: "Enter Email"),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 10.0,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(.5),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      _password = value;
                    });
                  },
                  decoration: new InputDecoration(
//                  fillColor: Colors.lightBlueAccent.withOpacity(.5),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      contentPadding: EdgeInsets.only(
                        left: 15,
                        bottom: 11,
                        top: 11,
                        right: 15,
                      ),
                      hintText: "Enter password"),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FancyButton(
                  color: Colors.blueAccent,
                  onPress: createUser,
                  label: 'Register',
                ),
//                GestureDetector(
//                  onTap: createUser,
//                  child: Container(
////                    width: MediaQuery.of(context).size.width - 20,
//                    height: 50,
//                    decoration: BoxDecoration(
//                      color: Colors.white,
//                      borderRadius: BorderRadius.all(
//                        Radius.circular(10),
//                      ),
//                      border: Border.all(color: Colors.blueAccent),
//                    ),
//                    child: Center(
//                      child: Padding(
//                        padding: const EdgeInsets.symmetric(
//                          vertical: 8.0,
//                          horizontal: 15,
//                        ),
//                        child: Text(
//                          "Register",
//                          style: GoogleFonts.quicksand(
//                            fontSize: 20,
//                          ),
//                        ),
//                      ),
//                    ),
//                  ),
//                ),
                SizedBox(
                  width: 20,
                ),
                FancyButton(
                  color: Colors.blueAccent,
                  onPress: login,
                  label: 'Login',
                ),
//                GestureDetector(
//                  onTap: login,
//                  child: Container(
////                    width: MediaQuery.of(context).size.width - 20,
//                    height: 50,
//                    decoration: BoxDecoration(
//                      color: Colors.white,
//                      borderRadius: BorderRadius.all(
//                        Radius.circular(10),
//                      ),
//                      border: Border.all(color: Colors.blueAccent),
//                    ),
//                    child: Center(
//                      child: Padding(
//                        padding: const EdgeInsets.symmetric(
//                          vertical: 8.0,
//                          horizontal: 15,
//                        ),
//                        child: Text(
//                          "Login",
//                          style: GoogleFonts.quicksand(
//                            fontSize: 20,
//                          ),
//                        ),
//                      ),
//                    ),
//                  ),
//                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
