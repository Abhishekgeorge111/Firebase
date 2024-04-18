import 'package:camerin/HomePage.dart';
import 'package:camerin/loginpage.dart';
// import 'package:camerin/register_page.dart';
// import 'package:camerin/sign.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  const MainPage ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            return const MyHomePage();

            }
            else{
              return const AppLogin();
            }
          }

      ),
    );
  }
}
