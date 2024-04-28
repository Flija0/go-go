/*import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:web_socket_channel/io.dart';

class chat2 extends StatefulWidget {
  const chat2({Key? key}) : super(key: key);

  @override
  State<chat2> createState() => _chat2State();
}

class _chat2State extends State<chat2> {

  late IOWebSocketChannel channel; //channel variable for websocket
  late bool connected;

  String myid = "1234"; //my id
  String recieverid = "4321"; //reciever id
  // swap myid and recieverid value on another mobile to test send and recieve
  String auth = "addauthkeyifrequired"; //auth key
  List<MessageData> msglist = [];

  TextEditingController msgtext = TextEditingController();
  @override
  void initState() {
    connected = false;
    msgtext.text = "";
    channelconnect();
    super.initState();
  }
  channelconnect() {
    //function to connect
    try {
      channel = IOWebSocketChannel.connect(
          "ws://127.0.0.1:6060/$myid"); //channel IP : Port
      channel.stream.listen(
            (message) {
          if (kDebugMode) {
            print(message);
          }
          setState(() {
            if (message == "connected") {
              connected = true;
              setState(() {});
              if (kDebugMode) {
                print("Connection establised.");
              }
            } else if (message == "send:success") {
              if (kDebugMode) {
                print("Message send success");
              }
              setState(() {
                msgtext.text = "";
              });
            } else if (message == "send:error") {
              if (kDebugMode) {
                print("Message send error");
              }
            } else if (message.substring(0, 6) == "{'cmd'") {
              if (kDebugMode) {
                print("Message data");
              }
              message = message.replaceAll(RegExp("'"), '"');
              var jsondata = json.decode(message);

              msglist.add(MessageData(
                //on message recieve, add data to model
                msgtext: jsondata["msgtext"],
                userid: jsondata["userid"],
                isme: false,
              ));
              setState(() {
                //update UI after adding data to message model
              });
            }
          });
        },
        onDone: () {
          //if WebSocket is disconnected
          if (kDebugMode) {
            print("Web socket is closed");
          }
          setState(() {
            connected = false;
          });
        },
        onError: (error) {
          if (kDebugMode) {
            print(error.toString());
          }
        },
      );
    } catch (_) {
      if (kDebugMode) {
        print("error on connecting to websocket.");
      }
    }
  }

  Future<void> sendmsg(String sendmsg, String id) async {
    if (connected == true) {
      String msg =
          "{'auth':'$auth','cmd':'send','userid':'$id', 'msgtext':'$sendmsg'}";
      setState(() {
        msgtext.text = "";
        msglist.add(MessageData(msgtext: sendmsg, userid: myid, isme: true));
      });
      channel.sink.add(msg); //send message to reciever channel
    } else {
      channelconnect();
      if (kDebugMode) {
        print("Websocket is not connected.");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: TextStyle(
                    fontFamily: "Roboto",
                    fontSize: 28,
                    fontWeight: FontWeight.w500,
                    color: Colors.white, // Couleur par défaut du texte
                  ),
                  children: [
                    TextSpan(
                      text: "Messages",
                    ),

                  ],
                ),
              ),
            )
          ],

        ),
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF232D4B), Color(0xFF005573)],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        child:Stack(
          children: [
            Positioned(
                top: 0,
                bottom: 70,
                left: 0,
                right: 0,
                child: Container(
                    padding: const EdgeInsets.all(15),
                    child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Column(
                              children: msglist.map((onemsg) {
                                return Container(
                                    margin: EdgeInsets.only(
                                      //if is my message, then it has margin 40 at left
                                      left: onemsg.isme ? 40 : 0,
                                      right: onemsg.isme
                                          ? 0
                                          : 40, //else margin at right
                                    ),
                                    child: Card(
                                        color: onemsg.isme
                                            ? Colors.blue[100]
                                            : Colors.red[100],
                                        //if its my message then, blue background else red background
                                        child: Container(
                                          width: double.infinity,
                                          padding: const EdgeInsets.all(15),
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Text(onemsg.isme
                                                  ? "ID: ME"
                                                  : "ID: ${onemsg.userid}"),
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    top: 10, bottom: 10),
                                                child: Text(
                                                    "Message: ${onemsg.msgtext}",
                                                    style: const TextStyle(fontSize: 17)),
                                              ),
                                            ],
                                          ),
                                        )));
                              }).toList(),
                            )
                          ],
                        )))),
            Positioned(
              //position text field at bottom of screen

              bottom: 0, left: 0, right: 0,
              child: Container(
                  color: Colors.black12,
                  height: 70,
                  child: Row(
                    children: [
                      Expanded(
                          child: Container(
                            margin: const EdgeInsets.all(10),
                            child: TextField(
                              controller: msgtext,
                              decoration:
                              const InputDecoration(hintText: "Enter your Message"),
                            ),
                          )),
                      Container(
                          margin: const EdgeInsets.all(10),
                          child: ElevatedButton(
                            child: const Icon(Icons.send),
                            onPressed: () {
                              if (msgtext.text != "") {
                                sendmsg(msgtext.text,
                                    recieverid); //send message with webspcket
                              } else {
                                if (kDebugMode) {
                                  print("Enter message");
                                }
                              }
                            },
                          ))
                    ],
                  )),
            )
          ],
        ),
      ),



    );

  }
}

class MessageData {
  //message data model
  String msgtext, userid;
  bool isme;
  MessageData({required this.msgtext, required this.userid, required this.isme});
}
*/