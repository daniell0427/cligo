import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../constants/variables.dart';
import 'calatorie_item.dart';

class ListViewBuilder extends StatefulWidget {
  final String emptyText;
  final List ids;

  const ListViewBuilder({
    super.key,
    required this.emptyText,
    required this.ids,
  });

  @override
  State<ListViewBuilder> createState() => _ListViewBuilderState();
}

class _ListViewBuilderState extends State<ListViewBuilder> {
  @override
  Widget build(BuildContext context) {
    //list view
    if (widget.ids.isNotEmpty) {
      return ListView.builder(
        itemBuilder: (context, index) {
          var itemID = widget.ids[index]; //get ids from list
          CollectionReference data = firestore.collection('routes');
          return FutureBuilder(
            future: data.doc(itemID).get(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container();
              }

              Map<String, dynamic> snapshotData =
                  snapshot.data!.data() as Map<String, dynamic>;

              //calatorie items
              return CalatorieItem(
                  date: snapshotData['date'],
                  destination: snapshotData['destination'],
                  location: snapshotData['location'],
                  pfp: snapshotData['sender_pfp'],
                  seats: snapshotData['available_seats'],
                  userName: snapshotData['sender_name']);
            },
          );
        },
        itemCount: widget.ids.length,
      );
    }

    //if no matches found
    else {
      return Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 40.0, right: 40.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: const Color.fromARGB(92, 158, 158, 158),
              border: Border.all(
                color: Colors.black,
                width: 1,
              ),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.error_outline,
                  size: 40,
                  color: Colors.black,
                ),
                Flexible(
                  child: Text(
                    widget.emptyText,
                    style: const TextStyle(
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
  }
}
