import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controllers/chat_provider.dart';
import '../../models/Convertation.dart';
import '../home.dart';
import 'chat_screen.dart';

class ChatListScreen extends StatefulWidget {
  @override
  _ChatListScreenState createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  int? userId;

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  Future<void> _loadUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    debugPrint('decodedToken : $token');

    if (token != null) {
      Map<String, dynamic> decodedToken = Jwt.parseJwt(token);
      setState(() {
        userId = decodedToken['user'] as int;
      });
      _fetchConversations(userId!);
    }
  }

  void _fetchConversations(int userId) {
    final chatProvider = Provider.of<ChatProvider>(context, listen: false);
    chatProvider.fetchConversationsForUser(userId);
  }

  @override
  Widget build(BuildContext context) {
    final chatProvider = Provider.of<ChatProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Row(
            children: [
        IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Get.offAll(home());
        },
        color: Colors.black,
      ),
      Text(
        'Chat',
        style: TextStyle(
          color: Colors.black, // set the color of the title text
        ),
      ),]),
      ),
      body: userId != null
          ? FutureBuilder<List<Convertation>>(
        future: chatProvider.fetchConversationsForUser(userId!),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final conversations = snapshot.data!;
            return conversations.isEmpty
                ? Center(
              child: Text(
                'Aucune conversation disponible',
                style: TextStyle(fontSize: 18),
              ),
            )
                : ListView.builder(
              itemCount: conversations.length,
              itemBuilder: (context, index) {
                final conversation = conversations[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatScreen(conversationId: conversation.id),
                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.grey[300]!)),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 24,
                          backgroundColor: Colors.blue,
                          child: Text(
                            conversation.secondUser.id == userId
                                ? conversation.firstUser.firstName[0]
                                : conversation.secondUser.firstName[0],
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                conversation.secondUser.id == userId
                                    ? '${conversation.firstUser.firstName} ${conversation.firstUser.lastName}'
                                    : '${conversation.secondUser.firstName} ${conversation.secondUser.lastName}',
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 4),
                              Text(
                                conversation.createdAt.toString(),
                                style: TextStyle(fontSize: 14),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Erreur lors de la récupération des conversations'),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      )
          : Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}