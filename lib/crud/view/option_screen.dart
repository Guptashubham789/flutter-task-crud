
import 'package:flutter/material.dart';
import 'package:portfolio/crud/view/registration_screen.dart';
import 'package:portfolio/crud/view/sign-in-screen.dart';


import '../components/round_button.dart';

class OptionScreen extends StatefulWidget {
  const OptionScreen({super.key});

  @override
  State<OptionScreen> createState() => _OptionScreenState();
}

class _OptionScreenState extends State<OptionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image(image: AssetImage("assets/img/img.png")),
              SizedBox(height: 30,),
              RoundButton(
                  title: "Sign In",
                  onPress: (){
                     Navigator.push(
                        context,MaterialPageRoute(builder: (Context)=> SignInScreen()));
                  }),
              SizedBox(height: 30,),
              RoundButton(title: "Sign Up", onPress: (){
                 Navigator.push(
                     context,MaterialPageRoute(builder: (Context)=> RegistrationScreen()));
              }),
              SizedBox(height: 50,),

            ],
          ),
        ),
      ),
    );
  }
}
