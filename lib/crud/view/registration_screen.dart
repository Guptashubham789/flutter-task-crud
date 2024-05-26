import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:portfolio/crud/view/home_screen.dart';

import '../../user/constant/app-constant.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController nameController=TextEditingController();
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
        title: Text('Sign Up',style: TextStyle(color: AppConstant.appTextColor,fontFamily: AppConstant.appFontFamily),),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 20.0),
              child: Container(
                height: 50.0,
                child: TextFormField(
                  controller: nameController,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(

                    labelText: 'Name',
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
                  keyboardType: TextInputType.text,
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
                      String name=nameController.text.trim();
                      String email=emailController.text.trim();
                      String password=passwordController.text.trim();
                      // String customerToken=await getCustomerDeviceToken();
                      if(name.isEmpty || email.isEmpty || password.isEmpty){
                        Get.snackbar(
                          "Error",
                          "Please enter all detatils",
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: AppConstant.appSecondaryColor,
                          colorText: AppConstant.appTextColor,
                        );
                      }else {
                        await FirebaseAuth.instance.createUserWithEmailAndPassword(
                          email: email,
                          password: password,
                        );
                        Get.snackbar(
                          "Account is created",
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