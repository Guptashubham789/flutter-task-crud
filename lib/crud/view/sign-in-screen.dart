import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:portfolio/crud/view/home_screen.dart';
import 'package:portfolio/crud/view/option_screen.dart';

import '../../user/constant/app-constant.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  //final FirebaseFirestore _firestore=FirebaseFirestore.instance;
  // Sign up with email and password
  Future<void> signUpWithEmailAndPassword(String email, String password) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      print("Error signing up: $e");
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstant.appSecondaryColor,
        iconTheme: IconThemeData(color: AppConstant.appTextColor),
        title: Text('Sign In',style: TextStyle(color: AppConstant.appTextColor,fontFamily: AppConstant.appFontFamily),),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 20.0),
              child: Container(
                height: 50.0,
                child: TextFormField(
                  controller: emailController,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                    hintStyle: TextStyle(fontSize: 12,color: Colors.black),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 20.0),
              child: Container(
                height: 50.0,
                child: TextFormField(
                  controller: passwordController,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    labelText: 'password',
                    contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                    hintStyle: TextStyle(fontSize: 12,color: Colors.black),
                  ),
                ),
              ),
            ),
            Material(
              child: Container(
                width: Get.width/2.0,
                height: Get.height/18,
                decoration: BoxDecoration(
                    color: AppConstant.appSecondaryColor,
                    borderRadius: BorderRadius.circular(10.0)
                ),
                child: TextButton(
                    onPressed: () async{
                      String email=emailController.text.trim();
                      String password=passwordController.text.trim();
                      // String customerToken=await getCustomerDeviceToken();
                      if(email.isEmpty || password.isEmpty){
                        Get.snackbar(
                          "Error",
                          "Please enter all detatils",
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: AppConstant.appSecondaryColor,
                          colorText: AppConstant.appTextColor,
                        );
                      }else {
                        await FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: email,
                          password: password,
                        );
                        Get.snackbar(
                          "SignIn Successfully",
                          "Welcome to $email",
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: AppConstant.appSecondaryColor,
                          colorText: AppConstant.appTextColor,
                        );
                        Get.offAll(()=>HomeScreen());

                      }


                    },
                    child: Text('Sign Up',
                      style: TextStyle(color: AppConstant.appTextColor,fontFamily: AppConstant.appFontFamily),)
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }

}