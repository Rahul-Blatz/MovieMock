class TicketDetails {
  final String movieName;
  final int movieId;
  final String posterPath;
  final String genre;
  final String runTime;
  final DateTime movieDate;
  final String movieLocation;
  final String movieScreen;
  final String movieTimings;
  List<String> seats = [];

  TicketDetails({
    this.movieId,
    this.posterPath,
    this.movieName,
    this.genre,
    this.runTime,
    this.movieDate,
    this.movieLocation,
    this.movieScreen,
    this.movieTimings,
  });

  set setSeats(List<String> value) {
    this.seats = value;
  }
}
