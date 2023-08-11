// ignore_for_file: prefer_const_constructors, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:websocketapp/api/api_repository.dart';
import 'package:websocketapp/model/user.dart';
import 'package:websocketapp/providers/chat.dart';
import 'package:websocketapp/providers/login.dart';
import 'package:websocketapp/screens/chat.dart';
import 'package:websocketapp/screens/login.dart';

class InboxScreen extends StatefulWidget {
  const InboxScreen({
    Key? key,
  }) : super(key: key);

  @override
  _InboxScreenState createState() => _InboxScreenState();
}

String name = "";

Future<List<User>> fetchUsers() async{
   SharedPreferences pref = await SharedPreferences.getInstance();   
   final token = pref.getString('token');   
   name = pref.getString("name").toString();
   final res = await ApiRepository().usersListCall(token.toString());  
    print(res);
   if(res["message"]=="success"){
    
     List<dynamic> data = res["data"];  
   
     return data.map((note) => User.fromJson(note)).toList();    
   } else {

    throw Exception('Failed to load users from API');
  }
  
}


class _InboxScreenState extends State<InboxScreen> {

ListView _userListView(data) {
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return _tile(
              data[index].id,
              data[index].username.toString(),
              data[index].name.toString());
        });
  }

  _logout() async {
     SharedPreferences pref = await SharedPreferences.getInstance(); 
     pref.clear();
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (context) => LoginProvider(),
            child: LoginScreen()                
          ),
        ),);
    
  }

  ListTile _tile(int id, String username, String name) =>
      ListTile(
        onTap: (){  Navigator.push(
          context,
            MaterialPageRoute(
              builder: (_) => ChangeNotifierProvider(
                create: (context) => ChatProvider(),
                child: ChatScreen(receiverId: id, name: name, username: username 
                ),
                
              ),
            ),
          );},
        leading: const Icon(
              Icons.person,
              size: 28,
            ),                        
        title: Text(name,
            style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20,
               ),
        ),
        
      );

   @override
  Widget build(BuildContext context) {
   
    return Scaffold(
     appBar: AppBar(
        title: Text(name),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Show Snackbar',
            onPressed: () {
                  _logout();
            },
          ),
         
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 25),
          Expanded(
            child: FutureBuilder<List<User>>(
              future: fetchUsers(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<User>? data = snapshot.data;
                  if(snapshot.data!.length<=0){
                    return Center(
                      child: Center(
                        child:  Text(
                                'User`s Empty',
                                style: TextStyle(
                               
                                  fontSize: 30,
                                ),
                              ),
                      ),
                    );
                  }
                  else{
                    return _userListView(data);
                  }
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                return Center(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    
    );
  }
}