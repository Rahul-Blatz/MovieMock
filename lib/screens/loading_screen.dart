import 'package:flutter/material.dart';
import 'package:moviemock/models/movie_list_model.dart';

import 'home_page.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    getMovieData();
    super.initState();
  }

  getMovieData() async {
    var movieData = await MovieListModel().getMovieListData();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => HomePage(movieData)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text("Loading Movies"),
        ),
      ),
    );
  }
}
