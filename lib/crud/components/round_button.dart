import 'package:flutter/material.dart';
import 'package:portfolio/user/constant/app-constant.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final VoidCallback onPress;
  RoundButton({required this.title,required this.onPress});

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      clipBehavior: Clip.antiAlias,
      child: MaterialButton(
        height: 50,
        minWidth: double.infinity,
        color: AppConstant.appSecondaryColor,
        onPressed: onPress,
        child: Text(title,style: TextStyle(color: Colors.black87),),
      ),
    );
  }
}