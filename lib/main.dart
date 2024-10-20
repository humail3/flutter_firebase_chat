import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasechat/screens/chat_screen.dart';
import 'package:firebasechat/screens/login_screen.dart';
import 'package:firebasechat/screens/registration_screen.dart';
import 'package:firebasechat/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {

  // Initialize Firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});

  final _auth=FirebaseAuth.instance;
  var firstScreen=WelcomeScreen.id;

  dynamic checkUserAuth() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        return firstScreen=ChatScreen.id;
      }else{
        return firstScreen=WelcomeScreen.id;
      }
    } catch (e) {
      print(e);
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        textTheme: const TextTheme(bodyText1: TextStyle(color: Colors.black54)),
      ),
      initialRoute: checkUserAuth(),
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        ChatScreen.id: (context) => ChatScreen(),
      },
    );
  }
}
