import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moviemock/models/ticket_details.dart';
import 'package:moviemock/screens/login_page.dart';

import 'payment_successfull_page.dart';

class PaymentGatewayPage extends StatefulWidget {
  final ticketDetails;

  PaymentGatewayPage({this.ticketDetails});

  @override
  _PaymentGatewayPageState createState() => _PaymentGatewayPageState();
}

class _PaymentGatewayPageState extends State<PaymentGatewayPage> {
  PaymentMode paymentMode = PaymentMode.Credit;
  bool isUploading = false;
  CollectionReference userRef = FirebaseFirestore.instance.collection('users');
  String currentUser = FirebaseAuth.instance.currentUser.email;

  initState() {
    getUsers();
    super.initState();
  }

  getUsers() async {
    await userRef.get().then((snap) {
      snap.docs.forEach((doc) {
        print("Received from Firestore: ${doc.data()}");
      });
    });
  }

  Future<void> testFireStore() {
    return userRef.add({
      "email": "rahul",
    }).then((value) => print("User Added"));
  }

  Future<void> createUserInFireStore() {
    return userRef
        .doc(currentUser)
        .collection("tickets")
        .doc(widget.ticketDetails.movieId.toString())
        .set({
      "movieName": widget.ticketDetails.movieName,
      "movieDate": widget.ticketDetails.movieDate,
      "movieTimings": widget.ticketDetails.movieTimings,
      "movieLocation": widget.ticketDetails.movieLocation,
      "movieScreen": widget.ticketDetails.movieScreen,
      "seats": widget.ticketDetails.seats.join(',').toString(),
      "posterPath": widget.ticketDetails.posterPath,
      "genre": widget.ticketDetails.genre,
      "paymentMode": widget.ticketDetails.paymentMode.toString(),
    }).whenComplete(
      () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PaymentSuccessfulPage(),
        ),
      ),
    );
  }

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
                                  widget.ticketDetails.posterPath,
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
                              "${widget.ticketDetails.movieName}",
                              style: GoogleFonts.quicksand(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "${widget.ticketDetails.genre}",
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
                                "${widget.ticketDetails.movieDate.toString().substring(0, 10)} - ${widget.ticketDetails.movieTimings}",
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
                                "${widget.ticketDetails.movieScreen}",
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
                                "${widget.ticketDetails.movieLocation}",
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
                          "Total Rs.${widget.ticketDetails.seats.length * 230}",
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
                      Container(
                        child: Column(
                          children: <Widget>[
                            ListTile(
                              title: Text(
                                'Credit',
                                style: GoogleFonts.quicksand(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              leading: Radio(
                                value: PaymentMode.Credit,
                                groupValue: paymentMode,
                                onChanged: (value) {
                                  setState(() {
                                    paymentMode = value;
                                  });
                                },
                              ),
                            ),
                            ListTile(
                              title: Text(
                                'Debit',
                                style: GoogleFonts.quicksand(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              leading: Radio(
                                value: PaymentMode.Debit,
                                groupValue: paymentMode,
                                onChanged: (value) {
                                  setState(() {
                                    paymentMode = value;
                                  });
                                },
                              ),
                            ),
                            ListTile(
                              title: Text(
                                'UPI',
                                style: GoogleFonts.quicksand(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              leading: Radio(
                                value: PaymentMode.UPI,
                                groupValue: paymentMode,
                                onChanged: (value) {
                                  setState(() {
                                    paymentMode = value;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    widget.ticketDetails.setPaymentMode = paymentMode;
                    print(widget.ticketDetails.paymentMode);
                    createUserInFireStore();
//                    Navigator.pushReplacement(
//                        context,
//                        MaterialPageRoute(
//                            builder: (context) => PaymentSuccessfulPage()));
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width - 20,
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
                        "Pay Rs.${widget.ticketDetails.seats.length * 230} Only",
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> ticketSeatsIcon() {
    List<Widget> seats = [];
    for (int i = 0; i < widget.ticketDetails.seats.length; i++) {
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
                  "${widget.ticketDetails.seats[i].toString().substring(1, widget.ticketDetails.seats[i].toString().length - 1)}",
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
