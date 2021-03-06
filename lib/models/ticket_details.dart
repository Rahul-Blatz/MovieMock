import 'package:cloud_firestore/cloud_firestore.dart';

enum PaymentMode { Credit, Debit, UPI }

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
  PaymentMode paymentMode;
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

  factory TicketDetails.fromDocument(DocumentSnapshot data) {
    return TicketDetails(
      posterPath: data['posterPath'],
      movieTimings: data['movieTimings'],
      genre: data['genre'],
      movieScreen: data['movieScreen'],
      movieLocation: data['movieLocation'],
      movieName: data['movieName'],
      runTime: data['seats'].toString(),
    );
  }

  set setSeats(List<String> value) {
    this.seats = value;
  }

  set setPaymentMode(PaymentMode value) {
    this.paymentMode = value;
  }
}
