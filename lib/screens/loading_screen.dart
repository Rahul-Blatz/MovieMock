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
    var movieData =
        await MovieListModel().getMovieList().then((value) => value['results']);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomePage(movieData)));
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
