import 'package:camerin/firebase_auth.dart';
// import 'package:camerin/mainpage.dart';
import 'package:camerin/sign.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AppLogin extends StatefulWidget {
  const AppLogin({super.key});

  @override
  State<AppLogin> createState() => _AppLoginState();
}

class _AppLoginState extends State<AppLogin> {
  final FireBaseAuthService auth = FireBaseAuthService();
  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();
  final agecontroller = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();

  @override
  void dispose() {
    firstnameController.dispose();
    emailController.dispose();
    lastnameController.dispose();
    passwordController.dispose();
    agecontroller.dispose();
confirmpasswordController.dispose();
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
            child: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    const Text(
                      'Sign up',
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
                      controller: firstnameController,
                      decoration: const InputDecoration(
                        labelText: 'First Name',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: lastnameController,
                      decoration: const InputDecoration(
                        labelText: 'Last Name',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: agecontroller,
                      decoration: const InputDecoration(
                        labelText: 'age',
                        border: OutlineInputBorder(),
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
                    TextFormField(
                      controller: confirmpasswordController,
                      decoration: const InputDecoration(
                        labelText: 'Confirm Password',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      // style: ElevatedButton.styleFrom(
                      //     shape: StadiumBorder(),
                      //     shadowColor: Colors.black,
                      //     elevation: 5),
                      onPressed: () {
                        signup();
                      },
                      child: const Text("Sign Up"),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.greenAccent),
                    ),
                    RichText(
                      text: TextSpan(
                          text: "already have an account  ",
                          style: const TextStyle(
                            color: Colors.blue,
                          ),
                          children: [
                            TextSpan(
                                text: "sign in",
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => const SignInPage(),
                                    ));
                                  })
                          ]),
                    ),
                  ]),
            )),
      ),
    );
  }

//   void signUp() async {
//     // String username = usernameController.text;
//     String email = emailController.text.trim();
//     String password = passwordController.text.trim();

//     adduserDetails(
//       firstnameController.text.trim(),
//       lastnameController.text.trim(),
//       emailController.text.trim(),
//       int.parse(
//         agecontroller.text.trim(),
//       ),
//     );
//     if (confirmpassword()) {
//       User? user = await auth.signupwithEmailandPassword(email, password);

//       if (user != null) {
//         Navigator.of(context).pushReplacement(MaterialPageRoute(
//           builder: (context) => const SignInPage(),
//         ));
//       } else {
//         AppLogin();
//       }
//     }
//   }

//   Future adduserDetails(
//       String firstName, String lastName, String email, int age) async {
//     await FirebaseFirestore.instance.collection("user").add({
//       'first name': firstName,
//       'last name': lastName,
//       'email': email,
//       'age': age,
//     });
//   }

//   bool confirmpassword() {
//     if (passwordController.text.trim() ==
//         confirmpasswordController.text.trim()) {
//       return true;
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text("Passwords do not match. Please try again."),
//           backgroundColor: Colors.red,
//         ),
//       );

//       return false;
//     }
//   }
// }
Future signup() async {
    if (passwordConfirmed()) {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());

      addUserDetails(
          firstnameController.text.trim(),
          lastnameController.text.trim(),
          emailController.text.trim(),
          int.parse(agecontroller.text.trim()));
    }
  }

  Future addUserDetails(
      String firstName, String lastName, String email, int age) async {
    await FirebaseFirestore.instance.collection("demouser").add({
      'first name': firstName,
      'last name': lastName,
      'email': email,
      'age': age,
    });
  }

  bool passwordConfirmed() {
    if (passwordController.text.trim() ==
        confirmpasswordController.text.trim()) {
      return true;
    } else {
      return false;
    }
  }
}

