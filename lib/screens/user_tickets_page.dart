import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moviemock/models/ticket_details.dart';

class UserTicketsPage extends StatefulWidget {
  @override
  _UserTicketsPageState createState() => _UserTicketsPageState();
}

class _UserTicketsPageState extends State<UserTicketsPage> {
  String currentUser = FirebaseAuth.instance.currentUser.email;
  CollectionReference userRef = FirebaseFirestore.instance.collection('users');
  List<TicketDetails> tickets = [];

  @override
  void initState() {
    getTickets();
    super.initState();
  }

  getUserTickets() async {
    await userRef.doc(currentUser).collection('tickets').get();
  }

  getTickets() async {
    QuerySnapshot temp =
        await userRef.doc(currentUser).collection('tickets').get();
    setState(() {
      tickets = temp.docs.map((e) => TicketDetails.fromDocument(e)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text("Booked Tickets"),
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.white,
          ),
          body: FutureBuilder(
            future: getUserTickets(),
            builder: (context, snapshot) {
//              if (!snapshot.hasData) {
//                return CircularProgressIndicator();
//              }
              return Container(
                child: ListView.builder(
                  itemCount: tickets.length,
                  itemBuilder: (context, index) {
                    return Card(
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
                                  "http://image.tmdb.org/t/p/w92" +
                                      tickets[index].posterPath,
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
                                  "${tickets[index].movieName}",
                                  style: GoogleFonts.quicksand(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "${tickets[index].genre}",
                                  style: GoogleFonts.quicksand(
                                      fontSize: 15, color: Colors.grey),
                                  overflow: TextOverflow.clip,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Wrap(
                                  children: <Widget>[
                                    Chip(
                                      avatar: Icon(
                                        Icons.calendar_today,
                                        color: Colors.blueAccent,
                                      ),
                                      backgroundColor:
                                          Colors.blueAccent.withOpacity(.3),
                                      label: Text(
                                        " ${tickets[index].movieTimings}",
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
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Chip(
                                      avatar: Icon(
                                        Icons.event_seat,
                                        color: Colors.orangeAccent,
                                      ),
                                      backgroundColor:
                                          Colors.orangeAccent.withOpacity(.3),
                                      label: Text(
                                        "${tickets[index].movieScreen}",
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
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Chip(
                                      avatar: Icon(
                                        Icons.location_on,
                                        color: Colors.greenAccent,
                                      ),
                                      backgroundColor:
                                          Colors.greenAccent.withOpacity(.3),
                                      label: Text(
                                        "${tickets[index].movieLocation}",
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
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            },
          )),
    );
  }
}
