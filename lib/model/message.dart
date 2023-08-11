class Message {
  final String message;
  final int senderId;
  final int receiverId;
  final DateTime sentAt;

  Message({
    required this.message,
    required this.senderId,
    required this.receiverId,
    required this.sentAt,
  });

  factory Message.fromJson(Map<String, dynamic> message) {
    return Message(
      message: message['message'],
      senderId: message['senderId'],
      receiverId: message['receiverId'],
      sentAt: DateTime.fromMillisecondsSinceEpoch(message['sentAt']),
    );
  }
}
