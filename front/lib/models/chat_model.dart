class Message {
  final int id;
  final String body;
  final String createdAt;
  final Conversation conversation;
  final User sender;

  Message({
    required this.id,
    required this.body,
    required this.createdAt,
    required this.conversation,
    required this.sender,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'],
      body: json['body'],
      createdAt: json['createdAt'],
      conversation: Conversation.fromJson(json['conversation']),
      sender: User.fromJson(json['sender']),
    );
  }
}

class Conversation {
  final int id;
  final User firstUser;
  final User secondUser;

  Conversation({
    required this.id,
    required this.firstUser,
    required this.secondUser,
  });

  factory Conversation.fromJson(Map<String, dynamic> json) {
    return Conversation(
      id: json['id'],
      firstUser: User.fromJson(json['firstUser']),
      secondUser: User.fromJson(json['secondUser']),
    );
  }
}

class User {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String mdp;
  final int phone;
  final String gender;
  final int consumptionExpected;
  final bool active;
  final int verified;
  final String dateCompte;
  final int role;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.mdp,
    required this.phone,
    required this.gender,
    required this.consumptionExpected,
    required this.active,
    required this.verified,
    required this.dateCompte,
    required this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      mdp: json['mdp'],
      phone: json['phone'],
      gender: json['gender'],
      consumptionExpected: json['consumptionExpected'],
      active: json['active'],
      verified: json['verified'],
      dateCompte: json['dateCompte'],
      role: json['role'],
    );
  }
}
