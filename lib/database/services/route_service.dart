import 'package:cligo/constants/variables.dart';
import 'package:cligo/features/list_view_builder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RouteService extends ChangeNotifier {
  //collection reference
  CollectionReference data = firestore.collection('routes');

  //GET MATCHING IDS
  Future getMatchingIDs(location, destination, date, seats) async {
    //get all route ids
    await data.get().then(
      (snapshots) async {
        for (var element in snapshots.docs) {
          var id = element.reference.id;

          //get route fields
          await data.doc(id).get().then(
            (value) {
              Map<String, dynamic> fields =
                  value.data() as Map<String, dynamic>;

              //filter results
              if (location == fields['location'] &&
                  destination == fields['destination'] &&
                  date == fields['date'] &&
                  seats <= fields['available_seats']) {
                matchingRoutesIDs.add(id);
              }
            },
          );
        }
      },
    );
  }

//GET IDS BY DATE
  StreamBuilder getRecentIDs() {
    return StreamBuilder(
      stream: data.orderBy('date', descending: false).snapshots(),
      builder: (context, snapshot) {
        //if error
        if (snapshot.hasError) {
          return Text('Eroare: ${snapshot.error}');
        }
        //loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container();
        }

        //if there are messages to show show them
        if (snapshot.data!.docs.isNotEmpty) {
          for (dynamic doc in snapshot.data.docs) {
            DateTime date = DateFormat('yy-MM-dd').parse(doc['date']);
            if (date.compareTo(DateTime.now()) > 0) {
              routeIDs.add(doc.id);
            } else {
              data.doc(doc.id).delete();
            }
          }
          return ListViewBuilder(
              emptyText: 'Nu sunt rute disponibile la moment!', ids: routeIDs);
        } else {
          return Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 40.0, right: 40.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Color.fromARGB(92, 158, 158, 158),
                  border: Border.all(
                    color: Colors.black,
                    width: 1,
                  ),
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 40,
                      color: Colors.black,
                    ),
                    Flexible(
                      child: Text(
                        'Nu sunt rute disponibile la moment!',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 40,
                        ),
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        maxLines: 4,
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }

  Future getMyRoutesID() async {
    await data.where('sender_ID', isEqualTo: currentUserID).get().then(
      (snapshot) {
        for (var doc in snapshot.docs) {
          myRouteIDs.add(doc.id);
        }
      },
    );
  }
}
