import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moviemock/models/ticket_details.dart';
import 'package:moviemock/widgets/curve_painter.dart';

import 'payment_gateway_page.dart';

class SelectSeatsPage extends StatefulWidget {
  final TicketDetails userTicket;

  SelectSeatsPage({@required this.userTicket});
  @override
  _SelectSeatsPageState createState() => _SelectSeatsPageState();
}

int numberOfSeats;
List<String> pickedSeats;

class _SelectSeatsPageState extends State<SelectSeatsPage> {
  @override
  void initState() {
    // TODO: implement initState
    numberOfSeats = 0;
    pickedSeats = [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: Text(
            "Select seats",
            style: GoogleFonts.quicksand(
              color: Colors.black,
            ),
          ),
          leading: IconButton(
              icon: Icon(
                Icons.chevron_left,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        body: SingleChildScrollView(
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
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "${widget.userTicket.movieName}",
                              style: GoogleFonts.quicksand(
                                fontWeight: FontWeight.bold,
                                fontSize: 28,
                              ),
//                                    overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "${widget.userTicket.genre}",
                              style: GoogleFonts.quicksand(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
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
                                    "${widget.userTicket.movieDate.toString().substring(0, 10)} - ${widget.userTicket.movieTimings}",
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
                                    "${widget.userTicket.movieScreen}",
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
                                    "${widget.userTicket.movieLocation}",
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
                            SizedBox(
                              height: 15,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Center(
                  child: Container(
                    height: 50,
                    child: CustomPaint(
                      painter: CurvePainter(),
                      child: Container(),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Icon(
                    Icons.arrow_upward,
                    color: Colors.blueAccent,
                  ),
                  Text(
                    "This side Screen",
                    style: GoogleFonts.quicksand(
                      color: Colors.blueAccent,
                    ),
                  ),
                  Icon(
                    Icons.arrow_upward,
                    color: Colors.blueAccent,
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                height: 290,
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 10,
                    childAspectRatio: 3 / 2,
                    crossAxisSpacing: 3,
                    mainAxisSpacing: 3,
                  ),
                  itemBuilder: (context, index) {
                    return Seat(
                      index: index,
                      context: context,
                    );
                  },
                  itemCount: 100,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    widget.userTicket.setSeats = pickedSeats;
                    print(widget.userTicket.seats.length);
                    if (numberOfSeats != 0) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PaymentGatewayPage(
                            ticketDetails: widget.userTicket,
                          ),
                        ),
                      );
                    }
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
                        "Pay For Tickets",
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
}

class Seat extends StatefulWidget {
  final BuildContext context;
  final int index;

  Seat({
    this.index,
    this.context,
  });

  @override
  _SeatState createState() => _SeatState();
}

class _SeatState extends State<Seat> {
  bool occupied = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          occupied = !occupied;
        });
        if (occupied == true) {
          setState(() {
            numberOfSeats++;
            pickedSeats.add({widget.index + 1}.toString());
          });
        }

        if (occupied == false) {
          setState(() {
            numberOfSeats--;
            pickedSeats.remove({widget.index + 1}.toString());
          });
        }

        print(numberOfSeats);
        print(pickedSeats);
      },
      child: Card(
        color: occupied ? Colors.blueAccent : Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Center(
            child: Text("${widget.index + 1}"),
          ),
        ),
      ),
    );
  }
}
