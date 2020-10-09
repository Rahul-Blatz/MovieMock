import 'package:moviemock/constants.dart';
import 'package:moviemock/models/list_of_movies.dart';
import 'package:moviemock/services/network_helper.dart';

class MovieListModel {
  Future<dynamic> getMovieList() async {
    NetworkHelper helper = new NetworkHelper(
        url:
            "https://api.themoviedb.org/3/movie/now_playing?api_key=d184498878ccf829742a75963e1eac7a&language=en-US&page=1");

    var movieList = await helper.getData();
    return movieList;
  }

  getMovieListData() async {
    var movieListJson = await getMovieList().then((value) => value['results']);
    List<ListOfMovies> movieListData = new List<ListOfMovies>();
    for (int i = 0; i < movieListJson.length; i++) {
      String genres = "";
      List<dynamic> tempGenre = new List<dynamic>();
      tempGenre = movieListJson[i]['genre_ids'];
      for (int j = 0; j < tempGenre.length; j++) {
        genres = genres + genreList[tempGenre[j]] + " | ";
      }
      ListOfMovies temp = new ListOfMovies(
        title: movieListJson[i]['title'],
        posterPath: movieListJson[i]['poster_path'],
        genre: genres.substring(0, genres.length - 2),
        id: movieListJson[i]['id'].toInt(),
      );
      movieListData.add(temp);
    }
    return movieListData;
  }
}
