import 'package:cligo/constants/variables.dart';
import 'package:cligo/database/services/chat_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cligo/constants/colors.dart';

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
  //late ScrollController _scrollController;
  //Text edditing controllers
  late final TextEditingController _message;

  @override
  void initState() {
    _message = TextEditingController();
    super.initState();
    //_scrollController = ScrollController();

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    // });
  }

  @override
  void dispose() {
    _message.dispose();
    // _scrollController.dispose();
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

  //CHAT VIEW
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    //get variables
    variables();

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              widget.receiverUserName,
              style: const TextStyle(color: Pallete.colorDim0),
            ),
            backgroundColor: Pallete.colorDim4,
          ),
          body: Container(
            color: Pallete.colorDim0,
            child: Padding(
              padding: const EdgeInsets.only(top: 0.0),
              child: Column(
                children: [
                  //show previous messages

                  Expanded(child: buildMessageList(screenWidth, screenHeight)),

                  //access send_message textfield WIDGET
                  messageTextfield(screenWidth, screenHeight),
                ],
              ),
            ),
          )),
    );
  }

  //!SEND_MESSAGE TEXTFIELD WIDGET
  Widget messageTextfield(screenWidth, screenHeight) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        width: screenWidth,
        height: screenHeight * 0.07,
        child: TextField(
          textAlignVertical: TextAlignVertical.center,
          style: const TextStyle(
            color: Pallete.colorDim0,
            fontSize: 20,
          ),
          controller: _message,
          decoration: InputDecoration(
            suffixIconColor: Pallete.colorDim0,
            hintText: "Mesaj...",
            hintStyle: const TextStyle(
              color: Pallete.colorGray,
              fontSize: 20,
            ),
            filled: true,
            fillColor: Pallete.colorDim4,

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
                color: Pallete.colorDim4,
              ),
              borderRadius: BorderRadius.all(Radius.circular(0.0)),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Pallete.colorDim4,
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
      stream: ChatServices().getMessages(currentUserID, widget.receiverUserID),
      builder: (context, snapshot) {
        //if error]

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
            padding: const EdgeInsets.only(top: 10),
            //controller: _scrollController,
            reverse: true,
            children: snapshot.data!.docs
                .map((doc) => buildMessageItem(doc))
                .toList()
                .reversed
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
                  color: Color.fromARGB(255, 208, 255, 255),
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

  //!MESSAGES ITEM
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
    if (data['senderID'] == currentUserID) {
      alignment = Alignment.centerRight;
      paddingSide = const EdgeInsets.only(right: 10.0);
      boxColor = Pallete.colorDim2;
    } else {
      alignment = Alignment.centerLeft;
      paddingSide = const EdgeInsets.only(left: 10.0);
      boxColor = Pallete.colorGray;
    }

    //message design
    return Column(
      children: [
        showDate(dateShow),
        Container(
          alignment: alignment,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 5.0),
            child: Padding(
              padding: paddingSide,
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                    maxWidth: 320), //TODO: change relative to screen width
                child: IntrinsicWidth(
                  child: Container(
                    //width: ,
                    decoration: BoxDecoration(
                      color: boxColor,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(20.0),
                      ),
                      // border: const Border.fromBorderSide(
                      //   BorderSide(
                      //     color: Colors.black,
                      //   ),
                      // ),
                    ),

                    //message and styles
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(12, 8, 0, 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          //message

                          Flexible(
                            child: Text(
                              data['message'],
                              style: const TextStyle(
                                  fontSize: 22, color: Pallete.textColor),
                              maxLines: 1000,
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),

                          //timestamp
                          Padding(
                            padding: const EdgeInsets.only(right: 10, left: 5),
                            child: Text(
                              hourMinuteSent,
                              style: const TextStyle(fontSize: 12),
                              textAlign: TextAlign.end,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  //SHOW DATE
  Widget showDate(String? dateShow) {
    if (dateShow != null) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Text(dateShow),
      );
    } else {
      return Container();
    }
  }
}
