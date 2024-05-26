import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:portfolio/crud/model/product.dart';
import 'package:portfolio/crud/view/add-data-screen.dart';
import 'package:portfolio/crud/view/home_screen.dart';

import '../../user/constant/app-constant.dart';


void sendData({
  required BuildContext context,
  required String title,
  required String description,
  required String deadline,
}){
  final FirebaseFirestore _firestore=FirebaseFirestore.instance;
  final user=FirebaseAuth.instance.currentUser;
  if(user!=null){
    //EasyLoading.show(status: "please wait..");
    int date=DateTime.now().microsecondsSinceEpoch;
    ProductModel productModel=ProductModel(
        title: title,
        description: description,
        deadline: deadline,
        createdOn: DateTime.now()
    );
    //add data into database firebase firestore
    _firestore
        .collection('AddData')
        .doc()
        .set(productModel.toMap());
    Get.snackbar(
      "Success.!!",
      "Product add in database..!!",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppConstant.appSecondaryColor,
      colorText: AppConstant.appTextColor,
    );
    Get.to(()=>AddDataScreen());
  }else{
    Get.snackbar(
      "Error",
      "Product not add in database..!!",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppConstant.appSecondaryColor,
      colorText: AppConstant.appTextColor,
    );
  }

}
void deleteDocument(String documentId) async {
  print('Doc id : $documentId');
  await FirebaseFirestore.instance.collection('userDocument').doc(documentId).delete();
  //Fluttertoast.showToast(msg:"Delete");
}