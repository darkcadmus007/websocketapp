import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:websocketapp/model/message.dart';
import 'package:websocketapp/providers/chat.dart';
import 'package:intl/intl.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {  
  final int receiverId;
  final String name;
   final String username;   
  const ChatScreen({Key? key, required this.receiverId, required this.name, required this.username}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late IO.Socket _socket;
  final TextEditingController _messageInputController = TextEditingController();
  var yourId = 0;

  _sendMessage() async {
     SharedPreferences pref = await SharedPreferences.getInstance();   
     final myId = pref.getInt('id');   
    _socket.emit('message', {
      'message': _messageInputController.text.trim(),    
      'senderId':myId,
      'receiverId':widget.receiverId
    });
    _messageInputController.clear();
  }

  _connectSocket() async {
     SharedPreferences pref = await SharedPreferences.getInstance();   
     yourId = pref.getInt('id')!.toInt();   
    _socket.onConnect((data) => print('Connection established'));
    _socket.onConnectError((data) => print('Connect Error: $data'));
    _socket.onDisconnect((data) => print('Socket.IO server disconnected'));
    _socket.on(
      'message',
      (data) => Provider.of<ChatProvider>(context, listen: false).addNewMessage(
        Message.fromJson(data),
      ),
    );
   
  }

  @override
  void initState() {
    super.initState();
   
    _socket = IO.io(
      // 'http://10.0.2.2:3000',
      'http://localhost:3000',
      IO.OptionBuilder().setTransports(['websocket']).build(),
    );
    _connectSocket();
  }

  @override
  void dispose() {
    _messageInputController.dispose();   
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.name} (${widget.username})'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Consumer<ChatProvider>(
              builder: (_, provider, __) => ListView.separated(
                padding: const EdgeInsets.all(16),
                itemBuilder: (context, index) {
                  final message = provider.messages[index];
                  if(((message.senderId == widget.receiverId)&&(message.receiverId == yourId))||((message.senderId == yourId)&&(message.receiverId == widget.receiverId))){
                    return Wrap(
                    alignment: ((message.senderId == widget.receiverId)&&(message.receiverId == yourId))
                        ? WrapAlignment.start
                        : WrapAlignment.end,
                    children: [
                      Card(
                        color: ((message.senderId == widget.receiverId)&&(message.receiverId == yourId))
                         ? Colors.white
                         : Theme.of(context).primaryColorLight,
                           
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment:
                                ((message.senderId == widget.receiverId)&&(message.receiverId == yourId))
                                    ? CrossAxisAlignment.end
                                    : CrossAxisAlignment.start,
                            children: [
                              Text(message.message),
                              Text(
                                DateFormat('hh:mm a').format(message.sentAt),
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                    
                  );
                  }
                  return const SizedBox();
                },
                separatorBuilder: (_, index) => const SizedBox(
                  height: 5,
                ),
                itemCount: provider.messages.length,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: SafeArea(
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _messageInputController,
                      decoration: const InputDecoration(
                        hintText: 'Type your message here...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      if (_messageInputController.text.trim().isNotEmpty) {
                        _sendMessage();
                      }
                    },
                    icon: const Icon(Icons.send),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
