import 'package:camerin/firebase_auth.dart';
import 'package:camerin/forgotpassword.dart';
import 'package:camerin/homepage.dart';
import 'package:camerin/loginpage.dart';
// import 'package:camerin/mainpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final FireBaseAuthService auth = FireBaseAuthService();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future signIn() async {
    showDialog(context: context, builder: (context){
      return const CircularProgressIndicator(color: Colors.black,);
    },);
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim());
        Navigator.of(context).pop();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Sign in',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    shadowColor: Colors.black,
                    elevation: 5),
                onPressed: () {
                  usersignin();
                },
                child: const Text("login"),
              ),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 16),
                ),
                onPressed: () {
                Navigator.push(
                  context, MaterialPageRoute(builder: (context)=> const ForgotPassword()));
                },
                child: const Text('Forgot Password'),
              ),
              RichText(
                      text: TextSpan(
                          text: "doesn't have an account  ",
                          style: const TextStyle(
                            color: Colors.blue,
                          ),
                          children: [
                            TextSpan(
                                text: "sign up",
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => const AppLogin(),
                                    ));
                                  })
                          ]),
                    ),
            ],
          ),
        ),
      ),
    );
}
  
  void usersignin() async {
    String email = emailController.text;
    String password = passwordController.text;
    showDialog(context: context, builder: (context){
      return const Center(child: CircularProgressIndicator());
    },);

    User? user = await auth.signInWithEmailandPassword(email, password);

    if (user != null) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const MyHomePage(),
      ));
    } else {
      const snackBar = SnackBar(
        content: Text('invalid',
        style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigator.of(context).pop();
      signIn();
    }
  }
  
}
