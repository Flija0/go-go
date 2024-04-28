/*class Message {
  final int id;
  final String body;
  final User sender;
  final int conversationId;
  final DateTime createdAt;

  Message({
    required this.id,
    required this.body,
    required this.sender,
    required this.conversationId,
    required this.createdAt,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'] as int,
      body: json['body'] as String,
      sender: User.fromJson(json['sender'] as Map<String, dynamic>),
      conversationId: json['conversationId'] as int,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }
}

class User {
  final int id;
  final String firstName;
  final String lastName;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
    );
  }
}
*/