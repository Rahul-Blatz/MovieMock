import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:moviemock/constants.dart';
import 'dart:convert';

import 'package:moviemock/models/movie_details.dart';
import 'package:moviemock/models/ticket_details.dart';
import 'package:moviemock/screens/login_page.dart';
import 'package:moviemock/screens/select_seats_page.dart';

class PickADatePage extends StatefulWidget {
  final movieId;
  final String genre;

  PickADatePage({@required this.movieId, @required this.genre});
  @override
  _PickADatePageState createState() => _PickADatePageState();
}

class _PickADatePageState extends State<PickADatePage> {
  DateTime pickedDate = DateTime.now();
  String pickedLocation = location[0];
  String pickedScreen = screens[0];
  String pickedTime = timings[0];

  Future<MovieDetails> getMovieDetails() async {
    var data = await http.get(
        "https://api.themoviedb.org/3/movie/${widget.movieId}?api_key=d184498878ccf829742a75963e1eac7a&language=en-US");
    var movieDetailsJson = json.decode(data.body);
    MovieDetails movie = new MovieDetails(
      id: widget.movieId,
      genre: widget.genre,
      posterPath: movieDetailsJson['poster_path'],
      rating: movieDetailsJson['vote_average'],
      title: movieDetailsJson['original_title'],
      runTime: movieDetailsJson['runtime'],
    );
//    print(movie);
    return movie;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            "Pick a Date",
            style: GoogleFonts.quicksand(color: Colors.black),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              Icons.chevron_left,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: FutureBuilder(
          future: getMovieDetails(),
          builder: (context, snapshot) {
            if (snapshot.data != null) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: Row(
                          children: <Widget>[
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "${snapshot.data.title}",
                                    style: GoogleFonts.quicksand(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 28,
                                    ),
//                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "${snapshot.data.genre}",
                                    style: GoogleFonts.quicksand(
                                      fontSize: 16,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Icon(
                                        Icons.access_time,
                                        color: Colors.greenAccent,
                                      ),
                                      SizedBox(
                                        width: 2,
                                      ),
                                      Text(
                                        "${snapshot.data.runTime} mins",
                                        style: GoogleFonts.quicksand(
                                            color: Colors.grey),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Icon(
                                        Icons.stars,
                                        color: Colors.orangeAccent,
                                      ),
                                      SizedBox(
                                        width: 2,
                                      ),
                                      Text(
                                        "IMDB: ${snapshot.data.rating}/10",
                                        style: GoogleFonts.quicksand(
                                            color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 15,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: CalendarDatePicker(
                          currentDate: pickedDate,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(
                            Duration(days: 15),
                          ),
                          onDateChanged: (value) {
                            setState(() {
                              pickedDate = value;
                            });
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                    value: pickedLocation,
                                    items: location
                                        .map((value) =>
                                            DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(
                                                value,
                                                style: GoogleFonts.quicksand(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ))
                                        .toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        pickedLocation = value;
                                      });
                                    }),
                              ),
                            ),
                          ),
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                    value: pickedScreen,
                                    items: screens
                                        .map((value) =>
                                            DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(
                                                value,
                                                style: GoogleFonts.quicksand(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ))
                                        .toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        pickedScreen = value;
                                      });
                                    }),
                              ),
                            ),
                          ),
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                    value: pickedTime,
                                    items: timings
                                        .map((value) =>
                                            DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(
                                                value,
                                                style: GoogleFonts.quicksand(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ))
                                        .toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        pickedTime = value;
                                      });
                                    }),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        FirebaseAuth auth = FirebaseAuth.instance;
                        if (auth.currentUser == null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ),
                          );
                        }
                        TicketDetails temp = new TicketDetails(
                          movieId: snapshot.data.id,
                          genre: snapshot.data.genre,
                          runTime: snapshot.data.runTime.toString(),
                          movieName: snapshot.data.title,
                          movieDate: pickedDate,
                          movieLocation: pickedLocation,
                          movieScreen: pickedScreen,
                          movieTimings: pickedTime,
                          posterPath: snapshot.data.posterPath,
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SelectSeatsPage(
                              userTicket: temp,
                            ),
                          ),
                        );
                      },
                      child: Center(
                        child: Container(
                          width: MediaQuery.of(context).size.width - 80,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                            border: Border.all(color: Colors.blueAccent),
                          ),
                          child: Center(
                            child: Text(
                              "Select Seats",
                              style: GoogleFonts.quicksand(
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    )
                  ],
                ),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
