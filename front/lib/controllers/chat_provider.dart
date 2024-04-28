import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/Convertation.dart';
import '../models/chat_model.dart';
import '../services/Config.dart';

class ChatProvider with ChangeNotifier {
  static var client = http.Client();

  List<Message> _messages = [];
  List<Message> get messages => [..._messages];

  List<Conversation> _conversations = [];
  List<Conversation> get conversations => [..._conversations];



  static Future<Conversation> fetchConversationsForUser2() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    Map<String, String> requestHeaders = {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'};
    var url = Uri.http(Config.apiUrl, Config.getAllConversationsForTheAuthentifiedUser);
    var response = await client.get(
      url,
      headers: requestHeaders,
    );
    if (response.statusCode == 200) {
      var conversation = Conversation.fromJson(jsonDecode(response.body));
      return conversation;
    } else {
      debugPrint('status code: ${response.statusCode}');
      throw Exception("Failed to get the jobs");
    }
  }

  Future<List<Convertation>> fetchConversationsForUser(int userId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    final url = Uri.parse('http://10.0.2.2:3000/conversation/getAllConversationsForTheAuthentifiedUser/$userId');
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return convertationFromJson(response.body);
    } else {
      throw Exception('Failed to load conversations');
    }
  }

  Future<void> fetchMessages(int conversationId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    final url = Uri.parse('http://10.0.2.2:3000/message/get/$conversationId');
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      _messages = data.map((messageData) => Message.fromJson(messageData as Map<String, dynamic>)).toList();
      notifyListeners();
    } else {
      throw Exception('Failed to fetch messages');
    }
  }

  Future<void> sendMessage(int senderId, int conversationId, String messageContent) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    final url = Uri.parse('http://10.0.2.2:3000/message/add/$senderId/$conversationId?body=$messageContent');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      // Successfully sent message
      fetchMessages(conversationId);
    } else {
      throw Exception('Failed to send message');
    }
  }
 getSelectedConversation(int conversationId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    final url = Uri.parse('http://10.0.2.2:3000/conversation/getSelectedConversation/$conversationId');
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {

      return Convertation.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to fetch messages');
    }
  }

}
