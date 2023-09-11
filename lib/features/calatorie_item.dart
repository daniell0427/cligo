import 'package:cligo/view/info_route_view.dart';
import 'package:flutter/material.dart';
import 'package:cligo/constants/colors.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class CalatorieItem extends StatefulWidget {
  final String pfp;
  final String userName;
  final String location;
  final String destination;
  final int seats;
  final String date;
  final String userID;

  const CalatorieItem({
    Key? key,
    required this.date,
    required this.destination,
    required this.location,
    required this.pfp,
    required this.seats,
    required this.userName,
    required this.userID,
  }) : super(key: key);

  @override
  State<CalatorieItem> createState() => _CalatorieItemState();
}

class _CalatorieItemState extends State<CalatorieItem> {
  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
  }

  @override
  Widget build(BuildContext context) {
    //format date and split the string
    DateTime date = DateFormat('yy-MM-dd').parse(widget.date);
    var formattedDate = DateFormat.yMMMd('ro').format(date);
    var formattedDateFull = DateFormat.yMMMMd('ro').format(date);
    var dateSplitted = formattedDate.split(' ');

    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => InfoRouteView(
            date: formattedDateFull,
            destination: widget.destination,
            location: widget.location,
            seats: widget.seats,
            userName: widget.userName,
            userPfp: widget.pfp,
            userID: widget.userID,
          ),
        ),
      ),
      child: Container(
        margin: const EdgeInsets.fromLTRB(15, 7, 15, 7),
        decoration: BoxDecoration(
          // boxShadow: const [
          //   BoxShadow(
          //     color: Pallete.colorDim3,
          //     blurRadius: 5,
          //     offset: Offset(0, 0),
          //   )
          // ],
          color: const Color.fromARGB(255, 208, 255, 255),
          borderRadius: BorderRadius.circular(15.0),
          border: Border.all(width: 2, color: Pallete.colorDim4),

          // gradient: const LinearGradient(
          //   begin: Alignment.topLeft,
          //   end: Alignment.bottomRight,
          //   colors: [Colors.white54, Colors.white10],
          // ),
        ),
        padding: const EdgeInsets.fromLTRB(8, 15, 8, 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                ClipRRect(
                  // Adding ClipRRect for circular shape
                  borderRadius: BorderRadius.circular(25),
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      // border: Border.all(
                      //   color: Pallete.colorDim4, // Border color
                      //   width: 2.0, // Border width
                      // ),
                    ),

                    //profile picture
                    child: CircleAvatar(
                      radius: 28,
                      backgroundColor: const Color.fromARGB(255, 200, 200, 200),
                      backgroundImage: AssetImage(widget.pfp),
                    ),
                  ),
                ),

                //ad sender userName
                Container(
                  constraints: const BoxConstraints(maxWidth: 80),
                  child: Center(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.center,
                      child: Text(
                        widget.userName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Pallete.textColor,
                        ),
                        maxLines: 1,
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              width: 0,
            ),
            Column(
              children: [
                //location and destination text
                Container(
                  constraints: const BoxConstraints(maxWidth: 220),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "${widget.location} - ${widget.destination}",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            color: Pallete.textColor),
                      ),
                    ),
                  ),
                ),

                //number of seats
                Text(
                  '${widget.seats} locuri',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Pallete.textColor,
                  ),
                ),
              ],
            ),
            const SizedBox(
              width: 0,
            ),

            //date text
            Align(
              alignment: Alignment.centerLeft,
              child: Column(
                children: [
                  Text(
                    dateSplitted[0],
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Pallete.textColor),
                  ),
                  Text(
                    dateSplitted[1].substring(0, dateSplitted[1].length - 1),
                    style:
                        const TextStyle(fontSize: 16, color: Pallete.textColor),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
