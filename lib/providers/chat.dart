import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:websocketapp/model/message.dart';

class ChatProvider extends ChangeNotifier {
    
         
  final List<Message> _messages = [
    
    
  ];

  List<Message> get messages => _messages;

  addNewMessage(Message message) {
    _messages.add(message);
    notifyListeners();
  }

  
}