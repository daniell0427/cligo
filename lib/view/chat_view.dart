import 'package:cligo/database/services/chat_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatView extends StatefulWidget {
  final String receiverUserName;
  final String receiverUserID;

  const ChatView({
    super.key,
    required this.receiverUserName,
    required this.receiverUserID,
  });

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  //Text edditing controllers
  late final TextEditingController _message;

  @override
  void initState() {
    _message = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _message.dispose();
    super.dispose();
  }

  //SEND MESSAGE IF TEXT IN NOT EMPTY FUNCTION
  void sendMessage() async {
    //send message only if there is somethig to send
    if (_message.text.isNotEmpty) {
      await ChatServices().sendMessage(
        widget.receiverUserID,
        _message.text,
      );
      //clear the text editing controller
      _message.clear();
    }
  }

  //instances of firebase
  final _fireauth = FirebaseAuth.instance;

  //CHAT VIEW
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
          appBar: AppBar(
            title: Text(widget.receiverUserName),
          ),
          body: Column(
            children: [
              //show previous messages
              Expanded(child: buildMessageList(screenWidth, screenHeight)),

              //access send_message textfield WIDGET
              messageTextfield(screenWidth, screenHeight),
            ],
          )),
    );
  }

  //SEND_MESSAGE TEXTFIELD WIDGET
  Widget messageTextfield(screenWidth, screenHeight) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        width: screenWidth,
        height: screenHeight * 0.06,
        child: TextField(
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
          controller: _message,
          decoration: InputDecoration(
            suffixIconColor: Colors.white,
            hintText: "Mesaj..",
            hintStyle: const TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
            filled: true,
            fillColor: const Color.fromARGB(122, 57, 57, 57),

            //send message button
            suffixIcon: IconButton(
              icon: const Icon(Icons.send),
              onPressed: () {
                sendMessage(); //send message
              },
            ),

            //textfield border
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,
              ),
              borderRadius: BorderRadius.all(Radius.circular(0.0)),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(0.0),
              ),
            ),
          ),
        ),
      ),
    );
  }

  //LIST OF ITEMS
  Widget buildMessageList(screenWidth, screenHeight) {
    return StreamBuilder(
      stream: ChatServices()
          .getMessages(_fireauth.currentUser!.uid, widget.receiverUserID),
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
          return ListView(
            children: snapshot.data!.docs
                .map((doc) => buildMessageItem(doc))
                .toList(),
          );
        }

        //if there are no messages => show a box
        else {
          return Container(
            alignment: Alignment.center,
            child: SizedBox(
              width: screenWidth * 0.6,
              height: screenHeight * 0.15,
              child: Container(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(43, 158, 158, 158),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                  border: Border.fromBorderSide(
                    BorderSide(
                      color: Colors.black,
                    ),
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: screenHeight * 0.02),
                      child: Text(
                        'Nu exista mesaje aici..',
                        style: TextStyle(
                          fontSize: screenWidth * 0.055,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: screenHeight * 0.03)),
                    Text(
                      'Trimite un mesaj acum!',
                      style: TextStyle(fontSize: screenWidth * 0.045),
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

  //MESSAGES ITEM
  String? previousMessage;

  Widget buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    //get the time the message was sent
    Timestamp timestamp = data['timestamp'];
    var sentDate =
        DateTime.fromMicrosecondsSinceEpoch(timestamp.microsecondsSinceEpoch);
    var today = DateTime.now();
    var yesterday = DateTime.now().subtract(const Duration(days: 1));
    var currentYear = today.year.toString();
    var hourMinuteSent = DateFormat('Hm').format(sentDate);
    var sentDateFormatted = DateFormat('dd MMMM yyyy').format(sentDate);
    var sentDateFormattedWithouYear = DateFormat('dd MMMM').format(sentDate);
    var sentYear = DateFormat('yyyy').format(sentDate);
    var todayFormatted = DateFormat('dd MMMM yyyy').format(today);
    var yesterdayFormatted = DateFormat('dd MMMM yyyy').format(yesterday);
    String theDayMessageSent;

    if (todayFormatted == sentDateFormatted) {
      theDayMessageSent = 'Astăzi';
    } else if (yesterdayFormatted == sentDateFormatted) {
      theDayMessageSent = 'Ieri';
    } else if (currentYear == sentYear) {
      theDayMessageSent = sentDateFormattedWithouYear;
    } else {
      theDayMessageSent = sentDateFormatted;
    }

    String? dateShow;
    if (previousMessage == theDayMessageSent) {
      dateShow = null;
    } else {
      previousMessage = theDayMessageSent;
      dateShow = previousMessage;
    }

    //align the text to the right or left, boxcolor and paddingside based on being the sender or receiver
    dynamic alignment;
    dynamic paddingSide;
    dynamic boxColor;
    if (data['senderID'] == _fireauth.currentUser!.uid) {
      alignment = Alignment.centerRight;
      paddingSide = const EdgeInsets.only(left: 20.0, right: 5.0);
      boxColor = const Color.fromARGB(156, 1, 119, 237);
    } else {
      alignment = Alignment.centerLeft;
      paddingSide = const EdgeInsets.only(right: 20.0, left: 5.0);
      boxColor = const Color.fromARGB(141, 87, 87, 87);
    }

    //message design
    return Column(
      children: [
        showDate(dateShow),
        Container(
          alignment: alignment,
          child: Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Column(children: [
              //message container decorations
              Padding(
                padding: paddingSide,
                child: Container(
                  decoration: BoxDecoration(
                    color: boxColor,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                    border: const Border.fromBorderSide(
                      BorderSide(
                        color: Colors.black,
                      ),
                    ),
                  ),

                  //message and styles
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      children: [
                        //message

                        Flexible(
                          child: Text(
                            data['message'],
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                            maxLines: 1000,
                            softWrap: false,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),

                        //timestamp
                        FittedBox(
                          child: Text(
                            hourMinuteSent,
                            style: const TextStyle(fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ),
      ],
    );
  }

  //SHOW DATE
  Widget showDate(String? dateShow) {
    if (dateShow != null) {
      return Text(dateShow);
    } else {
      return Container();
    }
  }
}
