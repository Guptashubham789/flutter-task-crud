import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:portfolio/crud/view/home_screen.dart';

import '../../user/constant/app-constant.dart';
import '../controller/add-data-services.dart';

class AddDataScreen extends StatefulWidget {
  const AddDataScreen({super.key});

  @override
  State<AddDataScreen> createState() => _AddDataScreenState();
}

class _AddDataScreenState extends State<AddDataScreen> {
  TextEditingController titleController=TextEditingController();
  TextEditingController descriptionController=TextEditingController();
  TextEditingController deadlineController=TextEditingController();
  //final FirebaseFirestore _firestore=FirebaseFirestore.instance;
  // Sign up with email and password
  DateTime? _selectedDate;


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstant.appSecondaryColor,
        iconTheme: IconThemeData(color: AppConstant.appTextColor),
        title: Text('Add Data',style: TextStyle(color: AppConstant.appTextColor,fontFamily: AppConstant.appFontFamily),),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 20.0),
              child: Container(
                height: 50.0,
                child: TextFormField(
                  controller: titleController,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(

                    labelText: 'Title',
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
                  controller: descriptionController,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  maxLines: 6,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                    hintStyle: TextStyle(fontSize: 12,color: Colors.black),
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 20.0),
              child: TextFormField(
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Select Date',
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                onTap: () async {
                  final DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (pickedDate != null) {
                    setState(() {
                      _selectedDate = pickedDate;
                    });
                  }
                },
                validator: (value) {
                  if (_selectedDate == null) {
                    return 'Please select a date';
                  }
                  return null;
                },
                controller: TextEditingController(
                  text: _selectedDate != null
                      ? DateFormat('yyyy-MM-dd').format(_selectedDate!)
                      : '',
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
                      String title=titleController.text.trim();
                      String description=descriptionController.text.trim();
                      String deadline=_selectedDate.toString();
                      // String customerToken=await getCustomerDeviceToken();
                      if(title.isEmpty || description.isEmpty || deadline.isEmpty){
                        Get.snackbar(
                          "Error",
                          "Please enter all detatils",
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: AppConstant.appSecondaryColor,
                          colorText: AppConstant.appTextColor,
                        );
                      }else {

                        sendData(
                          context:context,
                          title:title,
                          description:description,
                          deadline:deadline,

                        );

                      }
                    },
                    child: Text('Add Data',
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