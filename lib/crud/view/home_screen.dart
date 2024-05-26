

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:portfolio/crud/model/product.dart';
import 'package:portfolio/crud/view/add-data-screen.dart';
import 'package:portfolio/crud/view/update-screen.dart';

import '../../user/constant/app-constant.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController titleController=TextEditingController();
  TextEditingController descriptionController=TextEditingController();
  final firebase=FirebaseFirestore.instance;
  Future<void> delete(String id) async{
    print(id);
   await firebase.doc(id).delete();
   ScaffoldMessenger.of(context).showSnackBar(
     SnackBar(
       duration: Duration(milliseconds: 500),
       content: Text("Deleted"),),);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstant.appSecondaryColor,
        iconTheme: IconThemeData(color: AppConstant.appTextColor),
        title: Text('Home Screen',style: TextStyle(color: AppConstant.appTextColor,fontFamily: AppConstant.appFontFamily),),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppConstant.appSecondaryColor,
          onPressed: (){
          Get.to(()=>AddDataScreen());
          },
          child: Icon(Icons.add,color: AppConstant.appTextColor,),
      ),
      body: StreamBuilder(
          stream:FirebaseFirestore.instance.collection('AddData').snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
            //agr koi error hai hmare snapshot me to yh condition chale
            if(snapshot.hasError){
              return Center(
                child: Text('Error'),
              );
            }
            //agr waiting me h to kya return kro
            if(snapshot.connectionState==ConnectionState.waiting){
              return Container(
                height: Get.height/5.5,
                child: Center(
                  child: CupertinoActivityIndicator(),
                ),
              );
            }
            // yani ki jo hum document ko fetch karna chah rhe h kya vh empty to nhi hai agr empty hai to yha par hum simple return karvayenge
            if(snapshot.data!.docs.isEmpty){
              return Center(
                child: Text('No data found!!'),
              );
            }
            //
            if(snapshot.data!=null){
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),

                itemBuilder: (context,index) {
                  //yha par data ko hum nikal lenge jo data aa rha h use hum model ke andr convert karennge
                  //
                  final productData=snapshot.data!.docs[index];

                  ProductModel productModel=ProductModel(
                      title: productData['title'],
                      description: productData['description'],
                      deadline: productData['deadline'],
                      createdOn: productData['createdOn']
                  );
                  return Center(
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: (){
                            //Get.to(()=>ProductDetailsScreen(productModel:productModel));
                          },
                          child: Padding(padding: EdgeInsets.all(8.0),
                            child: Container(
                                height: Get.height/4,
                              width: Get.width/1.1,
                              child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                      children: [
                        SizedBox(height: 5,),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Title :",style: TextStyle(fontFamily: 'serif',fontSize: 16),),
                        Text( productModel.title,style: TextStyle(fontFamily: 'bold'),),
                      InkWell(
                        onTap: (){
                          getDialogUpdate(snapshot.data!.docs[index].id);
                          //Get.to(()=>UpdateScreen(productModel: productModel));
                        }, 
                          child: Icon(Icons.edit),
                      ),


                      ],
                      ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("Description : ",style: TextStyle(fontFamily: 'serif',fontSize: 16),),
                            Text( productModel.description,style: TextStyle(fontSize: 12),),

                          ],
                        ),
                        SizedBox(height: 5,),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("Deadline : ",style: TextStyle(fontFamily: 'serif',fontSize: 16),),
                            Text( productModel.deadline,style: TextStyle(fontSize: 12),),

                          ],
                        ),
                        SizedBox(height: 5,),

                        InkWell(
                          onTap: (){
                            deleteDocument(snapshot.data!.docs[index].id);
                          },
                          child: Icon(Icons.delete),
                        )

                      ],
                      ),
                    ),
                    )

                              ),
                            ),
                          ),


                      ],
                    ),
                  );
                },

              );

            }

            return Container();
          }
      ),
    );
  }
  Future getDialogUpdate(id){
    return  showDialog(context: context, builder: (BuildContext context){
      return Scaffold(
        appBar: AppBar(
          backgroundColor: AppConstant.appSecondaryColor,
          iconTheme: IconThemeData(color: AppConstant.appTextColor),
          title: Text('Update Data',style: TextStyle(color: AppConstant.appTextColor,fontFamily: AppConstant.appFontFamily),),
        ),
        body: Column(
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

            ElevatedButton(onPressed: (){
              FirebaseFirestore.instance.collection('AddData').doc(id).update({
                    "title":titleController.text,
                    "description":descriptionController.text,
                  "createdOn":DateTime.now(),
                  });
              Get.to(()=>HomeScreen());
              Get.snackbar(
                "Update",
                "update is succesfull..!!",
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: AppConstant.appSecondaryColor,
                colorText: AppConstant.appTextColor,
              );

            }, child: Text("Update"))
          ],
        ),
      );
    });
  }
  void deleteDocument(id){
    try {
      print(id);
       FirebaseFirestore.instance
          .collection('AddData')
          .doc(id)
          .delete();
      Fluttertoast.showToast(msg: "Item Deleted");
    } catch (e) {
      print("Error deleting : $e");
    }
  }
}
