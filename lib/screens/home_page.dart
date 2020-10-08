import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  final movieListData;

  HomePage(this.movieListData);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey.withOpacity(.1),
          elevation: 0.0,
          centerTitle: true,
          leading: Drawer(
            elevation: 0.0,
            child: Container(
              color: Colors.grey.withOpacity(.1),
              child: IconButton(
                color: Colors.grey.withOpacity(.1),
                icon: FaIcon(
                  FontAwesomeIcons.gripLines,
                  color: Colors.black,
                ),
                onPressed: () {
                  print(widget.movieListData.length);
                },
              ),
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.search,
                size: 30,
                color: Colors.black,
              ),
              onPressed: () {},
            ),
          ],
          title: Center(
            child: Text(
              "Movie Mock Cinemas",
              style: GoogleFonts.quicksand(color: Colors.black),
            ),
          ),
        ),
        body: Container(
          color: Colors.grey.withOpacity(.1),
          child: Center(
            child: Text("HomePage"),
          ),
        ),
      ),
    );
  }
}
