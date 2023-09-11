import 'package:cligo/features/screen_size.dart';
import 'package:cligo/view/profile_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'chat_view.dart';

class InfoRouteView extends StatefulWidget {
  final String userPfp;
  final int seats;
  final String userName;
  final String location;
  final String destination;
  final String date;
  final String userID;
  const InfoRouteView({
    super.key,
    required this.userName,
    required this.location,
    required this.destination,
    required this.date,
    required this.seats,
    required this.userPfp,
    required this.userID,
  });

  @override
  State<InfoRouteView> createState() => _InfoRouteViewState();
}

class _InfoRouteViewState extends State<InfoRouteView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text('no idea')),
      body: Container(
        margin: const EdgeInsets.only(top: 10),
        child: Column(
          children: [
            //profile picture
            SizedBox(
                width: ScreenSize(context).width * 0.2,
                height: ScreenSize(context).width * 0.2,
                child: Ink.image(image: AssetImage(widget.userPfp))),

            //user name
            Text(
              widget.userName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: ScreenSize(context).width * 0.12,
                color: Colors.black,
              ),
            ),

            Container(
              margin: const EdgeInsets.all(10),
              color: const Color.fromARGB(158, 158, 158, 158),
              child: Row(
                children: [
                  //profile
                  Expanded(
                    flex: 1,
                    child: IconButton(
                      onPressed: () =>
                          Navigator.of(context).push(CupertinoPageRoute(
                        builder: (context) => ProfileView(
                          urProfile: false,
                          userName: widget.userName,
                          userPfp: widget.userPfp,
                        ),
                      )),
                      icon: const Icon(Icons.person),
                      iconSize: ScreenSize(context).width * 0.15,
                    ),
                  ),

                  //send message
                  Expanded(
                    flex: 1,
                    child: IconButton(
                      onPressed: () => Navigator.of(context).push(
                        CupertinoPageRoute(
                          builder: (context) => ChatView(
                            receiverUserName: widget.userName,
                            receiverUserID: widget.userID,
                          ),
                        ),
                      ),
                      icon: const Icon(Icons.message),
                      iconSize: ScreenSize(context).width * 0.15,
                    ),
                  ),
                ],
              ),
            ),

            //route info
            Container(
              color: const Color.fromARGB(158, 158, 158, 158),
              margin: const EdgeInsets.all(10.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //location
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 15.0,
                        left: 15.0,
                        right: 15.0,
                      ),
                      child: Row(
                        children: [
                          Text(
                            'Locația: ',
                            style: TextStyle(
                              fontSize: ScreenSize(context).width * 0.07,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              widget.location,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: TextStyle(
                                fontSize: ScreenSize(context).width * 0.07,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    //destination
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 15.0,
                        left: 15.0,
                        right: 15.0,
                      ),
                      child: Row(
                        children: [
                          Text(
                            'Destinația: ',
                            style: TextStyle(
                              fontSize: ScreenSize(context).width * 0.07,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              widget.destination,
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: TextStyle(
                                fontSize: ScreenSize(context).width * 0.07,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    //date
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 15.0,
                        left: 15.0,
                        right: 15.0,
                      ),
                      child: Row(
                        children: [
                          Text(
                            'Data: ',
                            style: TextStyle(
                              fontSize: ScreenSize(context).width * 0.07,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              widget.date,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: TextStyle(
                                fontSize: ScreenSize(context).width * 0.07,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    //seats
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 15.0,
                        left: 15.0,
                        right: 15.0,
                        bottom: 15,
                      ),
                      child: Row(
                        children: [
                          Text(
                            'Locuri disponibile: ',
                            style: TextStyle(
                              fontSize: ScreenSize(context).width * 0.07,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              widget.seats.toString(),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: TextStyle(
                                fontSize: ScreenSize(context).width * 0.07,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),
            )
          ],
        ),
      ),
    );
  }
}
