import 'package:flutter/material.dart';

class FailureSnackBar extends SnackBar {
  FailureSnackBar({ Key? key,String? message }) : super(key: key,content: Text(message ?? 'عملیات با خطا مواجه شد',style: const TextStyle(color: Colors.white),),backgroundColor: Colors.red,shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(10.0))));
}