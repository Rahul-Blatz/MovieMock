import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moviemock/screens/login_page.dart';
import 'package:moviemock/screens/user_tickets_page.dart';
import 'pick_a_date_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserTicketsPage(),
                    ),
                  );
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
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => LoginPage()),
                    (Route<dynamic> route) => false);
              },
            ),
          ],
          title: Text(
            "Movie Mock Cinemas",
            style: GoogleFonts.quicksand(color: Colors.black),
          ),
        ),
        body: Container(
          child: ListView.builder(
            itemCount: widget.movieListData.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Card(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal: 5,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                            child: Image.network(
                              "http://image.tmdb.org/t/p/w92" +
                                  widget.movieListData[index].posterPath,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "${widget.movieListData[index].title}",
                              style: GoogleFonts.quicksand(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "${widget.movieListData[index].genre}",
                              style: GoogleFonts.quicksand(
                                  fontSize: 15, color: Colors.grey),
                              overflow: TextOverflow.clip,
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            RaisedButton(
                              color: Colors.blue,
                              child: Text(
                                "Book Tickets",
                                style: GoogleFonts.quicksand(
                                  color: Colors.white,
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PickADatePage(
                                      movieId: widget.movieListData[index].id,
                                      genre: widget.movieListData[index].genre,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
