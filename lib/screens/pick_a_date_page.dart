import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:moviemock/models/movie_details.dart';

class PickADatePage extends StatefulWidget {
  final movieId;
  final String genre;

  PickADatePage({@required this.movieId, @required this.genre});

  @override
  _PickADatePageState createState() => _PickADatePageState();
}

class _PickADatePageState extends State<PickADatePage> {
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
    print(movie);
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
              return Container(
                child: Column(
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
                            Column(
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
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
