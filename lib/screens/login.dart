// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:websocketapp/api/api_repository.dart';
import 'package:websocketapp/providers/inbox.dart';
import 'package:websocketapp/providers/login.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:websocketapp/screens/inbox.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _mobileNumController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();


  @override
  void initState(){
     _mobileNumController.text = "97455773439";
     _passwordController.text = "Sandy5456";
    super.initState();
  }

  @override
  void dispose() {
    _mobileNumController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  _login() async {
    EasyLoading.show(status: "Loading...");
    final provider = Provider.of<LoginProvider>(context, listen: false);
    if (_mobileNumController.text.trim().isNotEmpty&&_passwordController.text.trim().isNotEmpty) {
      provider.setErrorMessage('');
      final res = await ApiRepository().loginCall(_mobileNumController.text, _passwordController.text);      
    if(res["message"]=="success"){    
        SharedPreferences pref = await SharedPreferences.getInstance();   
        await pref.setInt('id', res["data"]["user"]["id"] ?? 0);
        await pref.setString('name', res["data"]["user"]["name"] ?? '');
         await pref.setString('username', res["data"]["user"]["username"] ?? '');
         await pref.setString('token', res["data"]["token"] ?? '');
        Navigator.pushReplacement(
          context,
            MaterialPageRoute(
              builder: (_) => ChangeNotifierProvider(
                create: (context) => InboxProvider(),
                child: const InboxScreen( 
                ),
                  //  child: ChatScreen(username: "user3254707024",
              ),
            ),
          );
      }
      else{
        provider.setErrorMessage('Login Failed');
      }
    } else {
      provider.setErrorMessage('Please complete information');
    }
    EasyLoading.dismiss();
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Selector<LoginProvider, String>(
                selector: (_, provider) => provider.errorMessage,
                builder: (_, errorMessage, __) => errorMessage != ''
                    ? Padding(
                        padding: const EdgeInsets.only(bottom: 30.0),
                        child: Card(
                          color: Colors.red,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              errorMessage,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      )
                    : Container(),
              ),
             
              Text(
                'Flutter Socket.IO Sample',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(
                height: 40,
              ),
              TextField(
                controller: _mobileNumController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter Mobile',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
                TextField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter Password',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: _login,
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
