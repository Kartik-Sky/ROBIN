import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:robin_proto/utils/color_utils.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isLoading = false;

  void signUp() async {
      setState(() {
        isLoading = true;
      });
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      // Handle success (e.g., navigate to a welcome page or show a success message)
      log('Account created for: ${userCredential.user?.email}');
      showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Logged Out"),
        content: const Text("You have successfully logged out."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            child: const Text("OK"),
          ),
        ],
      ),
    ); // Go back to Sign In page after successful sign up
    } catch (e) {
      // Handle error (e.g., show an error message)
      print('Error: $e');
    }

    setState(() {
      emailController.text = "";
      passwordController.text = "";
      isLoading = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              hexStringToColor("CB2B93"),
              hexStringToColor("5E61F4"),
              hexStringToColor("9546C4"),
            ],
      
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter
          
          )
          ),
          child:Center(
            child: Container(
              height: 600,
              width: 340,
              // margin: EdgeInsets.only(bottom: 10),
              padding: EdgeInsets.only(top:30),
              decoration: BoxDecoration(
                color:Colors.white,
                borderRadius: BorderRadius.circular(30)
              ),
              child: isLoading ? Center(child: CircularProgressIndicator(color: Colors.deepPurple,)):Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,


                children: [
                  // Image.asset("assets/images/image2.png"),
                  Text("Sign Up",
                    style: GoogleFonts.signika(

                      fontSize: 30,
                      fontWeight: FontWeight.w600
                    ),
                  ),

                  SizedBox(height: 50,),

                  Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      
                      labelText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 35),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 100),
                ElevatedButton(
                onPressed: signUp,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Text(
                    "Sign Up",
                    style: TextStyle(fontSize: 17),
                  ),
                ),
                                    ),
                ],
              ),
            ),
          )
      ),
    );
  }
}