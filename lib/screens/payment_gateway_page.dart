import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentGatewayPage extends StatelessWidget {
  final ticketDetails;

  PaymentGatewayPage({this.ticketDetails});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          title: Text(
            "Reservation Summary",
            style: GoogleFonts.quicksand(
              color: Colors.black,
            ),
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
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
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
                              "http://image.tmdb.org/t/p/w154" +
                                  ticketDetails.posterPath,
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
                              "${ticketDetails.movieName}",
                              style: GoogleFonts.quicksand(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "${ticketDetails.genre}",
                              style: GoogleFonts.quicksand(
                                  fontSize: 15, color: Colors.grey),
                              overflow: TextOverflow.clip,
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Chip(
                              avatar: Icon(
                                Icons.calendar_today,
                                color: Colors.blueAccent,
                              ),
                              backgroundColor:
                                  Colors.blueAccent.withOpacity(.3),
                              label: Text(
                                "${ticketDetails.movieDate.toString().substring(0, 10)} - ${ticketDetails.movieTimings}",
                                style: GoogleFonts.quicksand(
                                  color: Colors.blueAccent,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                              ),
                            ),
//                          SizedBox(
//                            height: 10,
//                          ),
                            Chip(
                              padding: EdgeInsets.all(0),
                              avatar: Icon(
                                Icons.event_seat,
                                color: Colors.orangeAccent,
                              ),
                              backgroundColor:
                                  Colors.orangeAccent.withOpacity(.3),
                              label: Text(
                                "${ticketDetails.movieScreen}",
                                style: GoogleFonts.quicksand(
                                  color: Colors.orangeAccent,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                              ),
                            ),
//                          SizedBox(
//                            height: 10,
//                          ),
                            Chip(
                              avatar: Icon(
                                Icons.location_on,
                                color: Colors.greenAccent,
                              ),
                              backgroundColor:
                                  Colors.greenAccent.withOpacity(.3),
                              label: Text(
                                "${ticketDetails.movieLocation}",
                                style: GoogleFonts.quicksand(
                                  color: Colors.greenAccent,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Seats",
                          style: GoogleFonts.quicksand(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Wrap(
                        children: ticketSeatsIcon(),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 3,
                          width: MediaQuery.of(context).size.width - 20,
                          color: Colors.grey.withOpacity(.5),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Total Rs.${ticketDetails.seats.length * 230}",
                          style: GoogleFonts.quicksand(
                            color: Colors.black,
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 3,
                          width: MediaQuery.of(context).size.width - 20,
                          color: Colors.grey.withOpacity(.5),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Select Payment Mode",
                          style: GoogleFonts.quicksand(
                            color: Colors.black,
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> ticketSeatsIcon() {
    List<Widget> seats = [];
    for (int i = 0; i < ticketDetails.seats.length; i++) {
      Widget seat = new Padding(
        padding: EdgeInsets.all(8),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 16,
            ),
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.event_seat,
                  color: Colors.blueAccent,
                ),
                Text(
                  "${ticketDetails.seats[i].toString().substring(1, ticketDetails.seats[i].toString().length - 1)}",
                  style: GoogleFonts.quicksand(
                    color: Colors.blueAccent,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
      seats.add(seat);
    }
    return seats;
  }
}
