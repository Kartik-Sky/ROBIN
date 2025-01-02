// import 'dart:convert';
import 'dart:developer';
// import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:robin_proto/main.dart';
import 'package:robin_proto/screens/auth/signup.dart';
import 'package:robin_proto/utils/color_utils.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => LandingPageState();
}

class LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Container(
        
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              hexStringToColor("CB2B93"),
              hexStringToColor("9546C4"),
              hexStringToColor("5E61F4"),
            ],

            begin: Alignment.topCenter,
            end: Alignment.bottomCenter
          
          )
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/image2.png'),
              ElevatedButton(onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SigninPage()));
              }, 
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 30,vertical: 20),
                child: Text("Get Started", 
                style: GoogleFonts.poppins(
                  // fontFamily: "",
                  fontSize: 17,
                  fontWeight: FontWeight.w600
                ),
                )
                
                )
              )
            ],
          ),
      ),
    );
  }
}

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isLoading = false;

    final FirebaseAuth _auth = FirebaseAuth.instance;

  void signIn() async {
    setState(() {
      isLoading = true;
    });
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      // Handle success (e.g., navigate to another page or show a success message)
      log('Signed in as: ${userCredential.user?.email}');
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>AuthWrapper()), (route) => false);
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
                  Text("Sign In",
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: signIn,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        child: Text(
                          "Sign In",
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                    ),
                      ElevatedButton(
                      onPressed: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SignUpPage()));
                      },
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
                ],
              ),
            ),
          )
      ),
    );
  }
}