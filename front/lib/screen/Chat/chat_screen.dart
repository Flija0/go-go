import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_and_go/models/chat_model.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:provider/provider.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controllers/chat_provider.dart';

class ChatScreen extends StatefulWidget {
  final int conversationId;

  ChatScreen({required this.conversationId});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String _formatMessageTime(String createdAt) {
    final now = DateTime.now();
    final createdAtDateTime = DateTime.parse(createdAt);
    final difference = now.difference(createdAtDateTime);

    if (difference.inDays > 0) {
      return '${difference.inDays} jour(s) ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} heure(s) ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minute(s) ago';
    } else {
      return 'Just now';
    }
  }
  TextEditingController _controller = TextEditingController();
  late int userId;
  String? firstName;
  String? lastName;
  late ChatProvider chatProvider;
  List<Message> messages = []; // Initialisation de la liste messages

  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
    chatProvider = Provider.of<ChatProvider>(context, listen: false);
    _loadMessages();
    _startMessageRefreshTimer();
  }


  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _startMessageRefreshTimer() async {
    _timer = Timer.periodic(Duration(seconds: 1), (_) async {
      await _loadMessages();
    });
  }

  Future<void> _loadUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    debugPrint('decodedToken : $token');

    if (token != null) {
      Map<String, dynamic> decodedToken = Jwt.parseJwt(token);
      userId = decodedToken['user'] as int;
      firstName = decodedToken['firstName'] as String;
      lastName = decodedToken['lastName'] as String;
    }
  }

  Future<void> _loadMessages() async {
    try {
      final pusher = PusherChannelsFlutter();
      await pusher.init(apiKey: "fabd281453b94b3c02f6", cluster: "eu");
      await pusher.connect();

      void onEvent(dynamic event) {
        setState(() {
          messages.add(Message(
            id: event['id'],
            body: event['message'],
            createdAt: DateTime.now().toString(),
            conversation: chatProvider.getSelectedConversation(widget.conversationId),
            sender: User(
              id: event['senderId'],
              firstName: event['senderFirstName'],
              lastName: event['senderLastName'],
              active: true,
              consumptionExpected: 0,
              dateCompte: DateTime.now().toString(),
              email: "abc@inetum.com",
              gender: "Male",
              mdp: "123456",
              phone: 8545111,
              role: 0,
              verified: 1,
            ),
          ));
        });
      }

      await pusher.subscribe(
        channelName: widget.conversationId.toString(),
        onEvent: onEvent,
      );

      await chatProvider.fetchMessages(widget.conversationId);
      setState(() {
        messages = chatProvider.messages;
      });
    } catch (e) {
      print('Error: ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              reverse: true,
              child: Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[index];
                      return Row(
                        mainAxisAlignment: message.sender.id == userId
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
                        children: [
                          if (message.sender.id != userId)
                            CircleAvatar(
                              radius: 20,
                              child: Text(
                                '${message.sender.firstName[0]}${message.sender.lastName[0]}',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          SizedBox(width: 8),
                          Flexible(
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: message.sender.id == userId
                                        ? Colors.blue
                                        : Colors.grey[300],
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    message.body,
                                    style: TextStyle(
                                      color: message.sender.id == userId
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                                Column(
                                  children: [
                                    SizedBox(height: 4),
                                    Text(
                                      _formatMessageTime(message.createdAt.toString()),
                                      style: TextStyle(
                                        fontSize: 6,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          if (message.sender.id == userId)
                            CircleAvatar(
                              radius: 20,
                              child: Text(
                                '${firstName![0]}${lastName![0]}',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          SizedBox(width: 8),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(hintText: 'Type a message'),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    chatProvider.sendMessage(
                      userId, // senderId,
                      widget.conversationId,
                      _controller.text,
                    );
                    _controller.clear();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
