import 'package:moviemock/services/network_helper.dart';

class MovieListModel {
  Future<dynamic> getMovieList() async {
    NetworkHelper helper = new NetworkHelper(
        url:
            "https://api.themoviedb.org/3/movie/now_playing?api_key=d184498878ccf829742a75963e1eac7a&language=en-US&page=1");

    var movieList = await helper.getData();
    return movieList;
  }
}
